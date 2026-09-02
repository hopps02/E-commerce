import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

/// Login codes are 6 digits — the backend generates them at this length
/// (config fouru.otp.length) and the UI collects exactly this many.
const int otpCodeLength = 6;

/// Server-assigned mobile role. The backend resolves it from the phone at
/// verify-otp; the app never chooses it (the role dialog was dev-only).
enum MobileRole {
  customer('customer');

  final String value;

  const MobileRole(this.value);

  static MobileRole? tryFrom(String? value) {
    for (final role in values) {
      if (role.value == value) return role;
    }
    return null;
  }
}

/// POST /mobile/auth/request-otp data.
@freezed
abstract class OtpRequested with _$OtpRequested {
  const factory OtpRequested({
    @JsonKey(name: 'expires_in_seconds') required int expiresInSeconds,
    @JsonKey(name: 'resend_after_seconds') required int resendAfterSeconds,
    @JsonKey(name: 'masked_phone') String? maskedPhone,
  }) = _OtpRequested;

  factory OtpRequested.fromJson(Map<String, dynamic> json) =>
      _$OtpRequestedFromJson(json);
}

/// The `account` block shared by verify-otp and /mobile/me.
@freezed
abstract class MobileAccountInfo with _$MobileAccountInfo {
  const factory MobileAccountInfo({
    required int id,
    required String phone,
    required String role,
    required String status,
    @JsonKey(name: 'preferred_locale') required String preferredLocale,
  }) = _MobileAccountInfo;

  factory MobileAccountInfo.fromJson(Map<String, dynamic> json) =>
      _$MobileAccountInfoFromJson(json);
}

/// POST /mobile/auth/verify-otp data. `accessToken` is null when the account
/// is blocked (`blocked` true) — the backend refuses to issue a token.
/// `profile` shape differs per role, so each role's feature layer parses it.
@freezed
abstract class AuthSession with _$AuthSession {
  const AuthSession._();

  const factory AuthSession({
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'token_type') String? tokenType,
    @JsonKey(name: 'refresh_token') String? refreshToken,
    @JsonKey(name: 'expires_in') int? expiresIn,
    required MobileAccountInfo account,
    @JsonKey(name: 'active_role') required String activeRole,
    Map<String, dynamic>? profile,
    @Default(<String, dynamic>{}) Map<String, dynamic> scopes,
    @JsonKey(name: 'next_screen') String? nextScreen,
    @Default(false) bool blocked,
    // True only for a brand-new signup — the welcome screen shows just then.
    @JsonKey(name: 'is_new') @Default(false) bool isNew,
  }) = _AuthSession;

  factory AuthSession.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionFromJson(json);

  MobileRole? get role => MobileRole.tryFrom(activeRole);
}

/// POST /mobile/auth/guest data. Guests only receive an access token and
/// browse with it until a login-required action prompts real auth.
class GuestSession {
  final String accessToken;
  final String? tokenType;
  final int? expiresIn;
  final bool isGuest;

  const GuestSession({
    required this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.isGuest = true,
  });

  factory GuestSession.fromJson(Map<String, dynamic> json) {
    return GuestSession(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String?,
      expiresIn: (json['expires_in'] as num?)?.toInt(),
      isGuest: json['is_guest'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
    'access_token': accessToken,
    'token_type': tokenType,
    'expires_in': expiresIn,
    'is_guest': isGuest,
  };
}

/// GET /mobile/me data — same blocks as the session, minus the token.
@freezed
abstract class MeData with _$MeData {
  const MeData._();

  const factory MeData({
    required MobileAccountInfo account,
    @JsonKey(name: 'active_role') required String activeRole,
    Map<String, dynamic>? profile,
    @Default(<String, dynamic>{}) Map<String, dynamic> scopes,
  }) = _MeData;

  factory MeData.fromJson(Map<String, dynamic> json) => _$MeDataFromJson(json);

  MobileRole? get role => MobileRole.tryFrom(activeRole);
}
