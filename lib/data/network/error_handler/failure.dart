import 'error_handler.dart';

abstract class Failure {
  const Failure();
}

// *

class DioLocalError extends Failure {
  final String? message;
  DioLocalError({this.message});
}

class CustomDioLocalError extends Failure {
  final DioErrorType? error;
  CustomDioLocalError({this.error});
}

// *

/// A backend-signalled failure. [code] is the stable machine code from the
/// canonical `{error: {code, message, details}}` envelope (e.g. `otp_invalid`,
/// `account_suspended`) — branch on it, never on [message], which is
/// human-facing copy that can change.
class ServerError extends Failure {
  final String? message;
  final String? code;
  final int? statusCode;
  final Map<String, dynamic>? details;

  ServerError({this.message, this.code, this.statusCode, this.details});
}

class CustomServerError extends Failure {
  final ApiErrorType? error;
  CustomServerError({this.error});
}

// *

class UnexpectedError extends Failure {
  final String? message;
  UnexpectedError({this.message});
}

class NoInternetConnection extends Failure {
  const NoInternetConnection();
}
