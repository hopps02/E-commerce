// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MobileNotification _$MobileNotificationFromJson(Map<String, dynamic> json) =>
    _MobileNotification(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? '',
      titleAr: json['title_ar'] as String? ?? '',
      titleEn: json['title_en'] as String? ?? '',
      bodyAr: json['body_ar'] as String? ?? '',
      bodyEn: json['body_en'] as String? ?? '',
      payload:
          json['payload'] as Map<String, dynamic>? ?? const <String, dynamic>{},
      read: json['read'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$MobileNotificationToJson(_MobileNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title_ar': instance.titleAr,
      'title_en': instance.titleEn,
      'body_ar': instance.bodyAr,
      'body_en': instance.bodyEn,
      'payload': instance.payload,
      'read': instance.read,
      'created_at': instance.createdAt.toIso8601String(),
    };

_UnreadNotificationsCount _$UnreadNotificationsCountFromJson(
  Map<String, dynamic> json,
) => _UnreadNotificationsCount(unread: (json['unread'] as num?)?.toInt() ?? 0);

Map<String, dynamic> _$UnreadNotificationsCountToJson(
  _UnreadNotificationsCount instance,
) => <String, dynamic>{'unread': instance.unread};

_MarkedNotificationsCount _$MarkedNotificationsCountFromJson(
  Map<String, dynamic> json,
) => _MarkedNotificationsCount(marked: (json['marked'] as num?)?.toInt() ?? 0);

Map<String, dynamic> _$MarkedNotificationsCountToJson(
  _MarkedNotificationsCount instance,
) => <String, dynamic>{'marked': instance.marked};
