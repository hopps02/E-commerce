import 'package:for_u/data/network/error_handler/error_handler.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

/// Maps a [Failure] to user-facing, localized copy.
///
/// Branching is on the backend's stable `error.code` — never on its message,
/// which is English-only human copy that can change. Codes this app version
/// doesn't know fall back to the backend message, then to a generic line.
extension FailureDisplay on Failure {
  String get displayMessage => switch (this) {
    NoInternetConnection() => Translation.error_no_internet.tr,
    CustomDioLocalError(:final error) => switch (error) {
      DioErrorType.CONNECTION_TIMEOUT ||
      DioErrorType.SEND_TIMEOUT ||
      DioErrorType.RECEIVE_TIMEOUT => Translation.error_no_internet.tr,
      _ => Translation.error_generic.tr,
    },
    ServerError(:final code, :final message) =>
      _serverCopy(code) ?? message ?? Translation.error_generic.tr,
    _ => Translation.error_generic.tr,
  };

  static String? _serverCopy(String? code) => switch (code) {
    'otp_invalid' => Translation.error_otp_invalid.tr,
    'otp_not_found' ||
    'otp_expired' ||
    'otp_max_attempts' => Translation.error_otp_expired.tr,
    'otp_resend_cooldown' => Translation.error_otp_cooldown.tr,
    'account_suspended' => Translation.error_account_suspended.tr,
    'order_already_rated' => Translation.error_order_already_rated.tr,
    'rating_window_closed' => Translation.error_rating_window_closed.tr,
    'order_not_rateable' => Translation.error_order_not_rateable.tr,
    'unauthenticated' => Translation.unauthorized.tr,
    _ => null,
  };
}
