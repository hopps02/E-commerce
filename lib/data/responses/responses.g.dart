// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthInitResponse _$AuthInitResponseFromJson(Map<String, dynamic> json) =>
    _AuthInitResponse(
      success: json['success'] as bool? ?? true,
      message: json['message'] as String? ?? '',
      registered: json['registered'] as bool? ?? false,
      createdAt: const DateTimeConverter().fromJson(
        json['created_at'] as String,
      ),
      lastLoginAt: const NullableDateTimeConverter().fromJson(
        json['last_login_at'] as String?,
      ),
    );

Map<String, dynamic> _$AuthInitResponseToJson(_AuthInitResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'registered': instance.registered,
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
      'last_login_at': const NullableDateTimeConverter().toJson(
        instance.lastLoginAt,
      ),
    };
