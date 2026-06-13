// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RequestOtpBody _$RequestOtpBodyFromJson(Map<String, dynamic> json) =>
    _RequestOtpBody(phone: json['phone'] as String);

Map<String, dynamic> _$RequestOtpBodyToJson(_RequestOtpBody instance) =>
    <String, dynamic>{'phone': instance.phone};

_VerifyOtpBody _$VerifyOtpBodyFromJson(Map<String, dynamic> json) =>
    _VerifyOtpBody(
      phone: json['phone'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$VerifyOtpBodyToJson(_VerifyOtpBody instance) =>
    <String, dynamic>{'phone': instance.phone, 'code': instance.code};

_RegisterDeviceBody _$RegisterDeviceBodyFromJson(Map<String, dynamic> json) =>
    _RegisterDeviceBody(
      token: json['token'] as String,
      platform: json['platform'] as String,
      locale: json['locale'] as String,
      appVersion: json['app_version'] as String?,
    );

Map<String, dynamic> _$RegisterDeviceBodyToJson(_RegisterDeviceBody instance) =>
    <String, dynamic>{
      'token': instance.token,
      'platform': instance.platform,
      'locale': instance.locale,
      'app_version': instance.appVersion,
    };
