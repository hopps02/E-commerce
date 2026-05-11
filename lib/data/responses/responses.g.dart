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
        json['createdAt'] as String,
      ),
      lastLoginAt: const NullableDateTimeConverter().fromJson(
        json['lastLoginAt'] as String?,
      ),
    );

Map<String, dynamic> _$AuthInitResponseToJson(
  _AuthInitResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'registered': instance.registered,
  'createdAt': const DateTimeConverter().toJson(instance.createdAt),
  'lastLoginAt': const NullableDateTimeConverter().toJson(instance.lastLoginAt),
};
