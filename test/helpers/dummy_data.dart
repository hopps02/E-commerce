import 'package:for_u/data/models/auth/auth_models.dart';

/// Canonical fixtures mirroring REAL backend payloads (MobileAuthResource /
/// MobilePresenter / OtpService) — keep them in sync with the API, not with
/// what the app would like to receive.
class DummyData {
  static const String customerPhone = '+966512345678';
  static const String fakeOtpCode = '000000';

  // ---- request-otp ----

  static const Map<String, dynamic> otpRequestedJson = {
    'expires_in_seconds': 300,
    'resend_after_seconds': 60,
    'masked_phone': '+966******678',
  };

  static OtpRequested otpRequested() =>
      const OtpRequested(expiresInSeconds: 300, resendAfterSeconds: 60);

  // ---- verify-otp ----

  static const Map<String, dynamic> customerAccountJson = {
    'id': 7,
    'phone': customerPhone,
    'role': 'customer',
    'status': 'active',
    'preferred_locale': 'ar',
  };

  /// Full happy-path verify-otp `data` block for a customer.
  static const Map<String, dynamic> customerSessionJson = {
    'access_token': 'jwt-token-value',
    'token_type': 'bearer',
    'account': customerAccountJson,
    'active_role': 'customer',
    'profile': {
      'id': 3,
      'customer_number': 'C345678',
      'name': 'سعيد',
      'phone': customerPhone,
    },
    'scopes': <String, dynamic>{},
    'next_screen': 'home',
    'blocked': false,
  };

  /// Suspended account: no token is issued and `blocked` is true.
  static const Map<String, dynamic> blockedSessionJson = {
    'access_token': null,
    'token_type': null,
    'account': {
      'id': 8,
      'phone': '+966512345679',
      'role': 'customer',
      'status': 'suspended',
      'preferred_locale': 'ar',
    },
    'active_role': 'customer',
    'profile': null,
    'scopes': <String, dynamic>{},
    'next_screen': 'blocked',
    'blocked': true,
  };

  static AuthSession customerSession() =>
      AuthSession.fromJson(customerSessionJson);

  // ---- backend error envelope ----

  static Map<String, dynamic> errorJson(
    String code,
    String message, {
    Map<String, dynamic>? details,
  }) => {
    'error': {
      'code': code,
      'message': message,
      if (details != null) 'details': details,
    },
  };
}
