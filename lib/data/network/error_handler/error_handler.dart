import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'failure.dart';

/// A universal wrapper for executing network requests safely and cleanly.
///
/// This function acts as the main safety boundary between your remote data
/// sources (API) and your repository layer. It automatically handles:
///
/// 1. **Execution**: Runs the asynchronous API [request] and returns its
///    value wrapped in a [Right].
/// 2. **Backend Errors**: The backend signals every failure with a non-2xx
///    status and `{error: {code, message, details}}` — Dio raises that as a
///    [DioException], which is mapped to a structured [ServerError].
/// 3. **Exception Catching**: It catches **ALL** thrown exceptions (timeouts,
///    no internet, 4xx/5xx, parsing) and passes them to the `e.handle`
///    [ErrorHandler] extension, so the UI always receives a [Failure],
///    never a crash.
///
/// Usage in Repository:
/// ```dart
/// return fastHandler(
///   request: () async => (await _api.verifyOtp(body)).data,
/// );
/// ```
Future<Either<Failure, T>> fastHandler<T>({
  required Future<T> Function() request,
}) async {
  try {
    return Right(await request());
  } catch (e) {
    return Left(e.handle);
  }
}

extension DioErrorTypeFailure on DioErrorType {
  Failure get getFailure {
    return CustomDioLocalError(error: this);
  }
}

extension ApiErrorTypeFailure on ApiErrorType {
  Failure get getFailure {
    return CustomServerError(error: this);
  }
}

extension ErrorHandler on dynamic {
  Failure get handle {
    return switch (this) {
      // Dio Errors
      DioException() => switch ((this as DioException).type) {
        DioExceptionType.cancel => CustomDioLocalError(
          error: DioErrorType.CANCEL,
        ),
        DioExceptionType.connectionError => NoInternetConnection(),
        DioExceptionType.unknown => CustomDioLocalError(
          error: DioErrorType.UNKNOWN,
        ),
        DioExceptionType.connectionTimeout => CustomDioLocalError(
          error: DioErrorType.CONNECTION_TIMEOUT,
        ),
        DioExceptionType.sendTimeout => CustomDioLocalError(
          error: DioErrorType.SEND_TIMEOUT,
        ),
        DioExceptionType.receiveTimeout => CustomDioLocalError(
          error: DioErrorType.RECEIVE_TIMEOUT,
        ),
        DioExceptionType.badCertificate => CustomDioLocalError(
          error: DioErrorType.BAD_CERTIFICATE,
        ),
        DioExceptionType.badResponse => _failureFromResponse(
          (this as DioException).response,
        ),
      },
      _ => UnexpectedError(message: toString()),
    };
  }
}

/// Maps a non-2xx backend response to a structured [Failure]. Never throws —
/// any unexpected body shape (proxy HTML, empty body, plain string) falls
/// back to a readable message derived from the HTTP status.
///
/// Canonical backend shape:
/// ```json
/// {"error": {"code": "otp_invalid", "message": "...", "details": {...}}}
/// ```
Failure _failureFromResponse(Response<dynamic>? response) {
  final status = response?.statusCode;
  final body = response?.data;

  String? code;
  String? message;
  Map<String, dynamic>? details;

  if (body is Map) {
    final error = body['error'];
    if (error is Map) {
      code = error['code']?.toString();
      message = error['message']?.toString();
      final rawDetails = error['details'];
      if (rawDetails is Map) {
        details = Map<String, dynamic>.from(rawDetails);
      }
    } else {
      // Legacy / non-canonical shapes: flat `message` or string `error`.
      message = body['message']?.toString() ?? (error is String ? error : null);
    }
  }

  if (message != null && message.isNotEmpty) {
    // Keep the legacy enum mapping for transport-level errors pinned by tests.
    final known = status != null ? ApiErrorType.from(status, message) : null;
    if (known != null) {
      return CustomServerError(error: known);
    }
    return ServerError(
      message: message,
      code: code,
      statusCode: status,
      details: details,
    );
  }

  // No usable message from the backend: map the HTTP status to readable copy.
  if (status != null) {
    switch (status) {
      case 400:
        return ServerError(
          message: "Bad Request: Invalid data provided.",
          statusCode: status,
        );
      case 401:
        return ServerError(
          message: "Unauthorized: Please login again.",
          statusCode: status,
        );
      case 403:
        return ServerError(
          message: "Forbidden: You don't have access.",
          statusCode: status,
        );
      case 404:
        return ServerError(
          message: "Not Found: The requested resource does not exist.",
          statusCode: status,
        );
      case 429:
        return ServerError(
          message: "Too Many Requests: Please try again later.",
          statusCode: status,
        );
      case 500:
      case 502:
      case 503:
      case 504:
        return ServerError(
          message: "Server Error: Something went wrong on our end.",
          statusCode: status,
        );
      default:
        return ServerError(
          message: "Server Error: Code $status.",
          statusCode: status,
        );
    }
  }

  return ServerError(message: "An unknown error occurred.");
}

/// Represents connection-level and protocol-level errors thrown by the Dio HTTP client.
///
/// Use this enum to handle things like request timeouts, lack of internet connection,
/// or bad SSL certificates. These happen BEFORE or DURING the request, not based on backend logic.
enum DioErrorType {
  CANCEL("CANCEL", "Request was cancelled", "CANCEL"),
  CONNECTION_ERROR(
    "CONNECTION_ERROR",
    "Failed to connect to the server",
    "CONNECTION_ERROR",
  ),
  UNKNOWN("UNKNOWN", "An unknown error occurred", "UNKNOWN"),
  CONNECTION_TIMEOUT(
    "CONNECTION_TIMEOUT",
    "Connection to the server timed out",
    "CONNECTION_TIMEOUT",
  ),
  SEND_TIMEOUT(
    "SEND_TIMEOUT",
    "Request timed out while sending",
    "SEND_TIMEOUT",
  ),
  RECEIVE_TIMEOUT(
    "RECEIVE_TIMEOUT",
    "Response timed out while receiving",
    "RECEIVE_TIMEOUT",
  ),
  BAD_CERTIFICATE(
    "BAD_CERTIFICATE",
    "Invalid certificate from the server",
    "BAD_CERTIFICATE",
  ),
  BAD_RESPONSE(
    "BAD_RESPONSE",
    "Invalid or unexpected response from the server",
    "BAD_RESPONSE",
  );

  final dynamic
  status; // `dynamic` to handle both String (Dio errors) and int (HTTP errors)
  final String message;
  final String error;

  const DioErrorType(this.status, this.message, this.error);

  static DioErrorType? from(dynamic status, String error) {
    for (var e in DioErrorType.values) {
      if (e.status == status && e.error.toLowerCase() == error.toLowerCase()) {
        return e;
      }
    }
    return null;
  }
}

/// Represents known business-logic errors specifically returned by your backend API.
///
/// Whenever the backend team defines a new standard error (e.g., "USER_BANNED"),
/// you should add it here. The `_failureFromResponse` will automatically parse it
/// and return it as a [CustomServerError].
enum ApiErrorType {
  UNAUTHORIZED(401, "Unauthorized");

  final dynamic statusCode;
  final String message;

  const ApiErrorType(this.statusCode, this.message);

  static ApiErrorType? from(dynamic statusCode, String message) {
    for (var e in ApiErrorType.values) {
      if (e.message.toLowerCase() == message.toLowerCase() &&
          e.statusCode == statusCode) {
        return e;
      }
    }
    return null;
  }
}
