import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jar/data/responses/responses.dart';
import 'failure.dart';

/// A universal wrapper for executing network requests safely and cleanly.
/// 
/// This function acts as the main safety boundary between your remote data sources (API) 
/// and your repository layer. It automatically handles:
/// 
/// 1. **Execution**: Runs the asynchronous API [request].
/// 2. **Success Parsing**: If the request succeeds and `response.success` is true, 
///    it returns the data wrapped in a [Right].
/// 3. **Logical Backend Errors**: If the HTTP request succeeds (200 OK) but the backend 
///    explicitly marks it as a failure (`success` == false), it extracts the backend 
///    message and returns it as a [Left(ServerError)].
/// 4. **Exception Catching**: It catches **ALL** thrown exceptions (e.g., Dio timeouts, 
///    `400 Bad Request`, `401 Unauthorized`, `500 Server Crashes`, No Internet) and 
///    safely passes them to the `e.handle` [ErrorHandler] extension. This guarantees 
///    your UI will always receive a structured [Failure] object, never an app crash.
/// 
/// Usage in Repository:
/// ```dart
/// return fastHandler(
///   request: () => _apiServiceClient.login(requestModel),
/// );
/// ```
Future<Either<Failure, result>> fastHandler<result extends BasicResponse>({
  required Future<result> Function() request,
}) async {
  try {
    var response = await request();
    if (response.success) {
      return Right(response);
    } else {
      return Left(ServerError(message: response.message));
    }
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

extension ResponseStatusFalse on Response {
  Failure get handle => _handleResponseError(
    (this as DioException).response?.statusCode ??
        (this as DioException).response?.data["statusCode"],
    (this as DioException).response?.data["message"],
    (this as DioException).response?.data["error"],
  );
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
        DioExceptionType.badResponse => _handleResponseError(
          ((this as DioException).response?.statusCode ??
              (this as DioException).response?.data["status"]),
          (this as DioException).response?.data["message"],
          (this as DioException).response?.data["error"],
        ),
      },
      // FirebaseException() => _handleResponseError(
      //     (this as FirebaseException).code,
      //     (this as FirebaseException).message,
      //     ""
      // ),
      _ => UnexpectedError(message: toString()),
    };
  }
}

/// Parses the raw error response from the backend and maps it to a structured [Failure] object.
/// 
/// Enhancement: This function now gracefully falls back to default HTTP status messages 
/// (e.g., "Bad Request" for 400) if the backend fails to provide a clear [message] or [error] string.
Failure _handleResponseError(dynamic status, String? message, String? error) {
  final fallbackMessage = message ?? error;

  // 1. Try to match an exact known API error from the backend.
  if (status != null && fallbackMessage != null) {
    final apiError = ApiErrorType.from(status, fallbackMessage);
    if (apiError != null) {
      return CustomServerError(error: apiError);
    }
  }

  // 2. If we have a message from the backend but it's not a pre-defined ApiErrorType, return it directly.
  if (fallbackMessage != null && fallbackMessage.isNotEmpty) {
    return ServerError(message: fallbackMessage);
  }

  // 3. Enhancement: If no message is provided by the backend, map the HTTP status code to a readable message.
  if (status is int) {
    switch (status) {
      case 400:
        return ServerError(message: "Bad Request: Invalid data provided.");
      case 401:
        return ServerError(message: "Unauthorized: Please login again.");
      case 403:
        return ServerError(message: "Forbidden: You don't have access.");
      case 404:
        return ServerError(message: "Not Found: The requested resource does not exist.");
      case 429:
        return ServerError(message: "Too Many Requests: Please try again later.");
      case 500:
      case 502:
      case 503:
      case 504:
        return ServerError(message: "Server Error: Something went wrong on our end.");
      default:
        return ServerError(message: "Server Error: Code $status.");
    }
  }

  // 4. Default fallback when both status and message are unhelpful.
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
/// you should add it here. The `_handleResponseError` will automatically parse it
/// and return it as a [CustomServerError].
enum ApiErrorType {
  USER_NOT_CONFIRMED(401, "User is not confirmed."),
  UNAUTHORIZED(401, "غير مصرح"),
  EMAIL_TAKEN(400, "An account with the given email already exists."),
  INCORRECT_PASSWORD_OR_EMAIL(401, "Incorrect username or password."),
  INVALID_CODE(400, "Invalid code provided, please request a code again."),
  INVALID_REFRESH_TOKEN(400, "Invalid Refresh Token");

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
