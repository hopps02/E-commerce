// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OtpRequested _$OtpRequestedFromJson(Map<String, dynamic> json) =>
    _OtpRequested(
      expiresInSeconds: (json['expires_in_seconds'] as num).toInt(),
      resendAfterSeconds: (json['resend_after_seconds'] as num).toInt(),
      maskedPhone: json['masked_phone'] as String?,
    );

Map<String, dynamic> _$OtpRequestedToJson(_OtpRequested instance) =>
    <String, dynamic>{
      'expires_in_seconds': instance.expiresInSeconds,
      'resend_after_seconds': instance.resendAfterSeconds,
      'masked_phone': instance.maskedPhone,
    };

_MobileAccountInfo _$MobileAccountInfoFromJson(Map<String, dynamic> json) =>
    _MobileAccountInfo(
      id: (json['id'] as num).toInt(),
      phone: json['phone'] as String,
      role: json['role'] as String,
      status: json['status'] as String,
      preferredLocale: json['preferred_locale'] as String,
    );

Map<String, dynamic> _$MobileAccountInfoToJson(_MobileAccountInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'role': instance.role,
      'status': instance.status,
      'preferred_locale': instance.preferredLocale,
    };

_AuthSession _$AuthSessionFromJson(Map<String, dynamic> json) => _AuthSession(
  accessToken: json['access_token'] as String?,
  tokenType: json['token_type'] as String?,
  account: MobileAccountInfo.fromJson(json['account'] as Map<String, dynamic>),
  activeRole: json['active_role'] as String,
  profile: json['profile'] as Map<String, dynamic>?,
  scopes: json['scopes'] as Map<String, dynamic>? ?? const <String, dynamic>{},
  nextScreen: json['next_screen'] as String?,
  blocked: json['blocked'] as bool? ?? false,
  isNew: json['is_new'] as bool? ?? false,
);

Map<String, dynamic> _$AuthSessionToJson(_AuthSession instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'account': instance.account,
      'active_role': instance.activeRole,
      'profile': instance.profile,
      'scopes': instance.scopes,
      'next_screen': instance.nextScreen,
      'blocked': instance.blocked,
      'is_new': instance.isNew,
    };

_MeData _$MeDataFromJson(Map<String, dynamic> json) => _MeData(
  account: MobileAccountInfo.fromJson(json['account'] as Map<String, dynamic>),
  activeRole: json['active_role'] as String,
  profile: json['profile'] as Map<String, dynamic>?,
  scopes: json['scopes'] as Map<String, dynamic>? ?? const <String, dynamic>{},
);

Map<String, dynamic> _$MeDataToJson(_MeData instance) => <String, dynamic>{
  'account': instance.account,
  'active_role': instance.activeRole,
  'profile': instance.profile,
  'scopes': instance.scopes,
};
