import 'package:easy_localization/easy_localization.dart';
import 'package:for_u/app/app.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_response.freezed.dart';
part 'notification_response.g.dart';

@freezed
abstract class MobileNotification with _$MobileNotification {
  const MobileNotification._();

  const factory MobileNotification({
    required int id,
    @Default('') String type,
    @JsonKey(name: 'title_ar') @Default('') String titleAr,
    @JsonKey(name: 'title_en') @Default('') String titleEn,
    @JsonKey(name: 'body_ar') @Default('') String bodyAr,
    @JsonKey(name: 'body_en') @Default('') String bodyEn,
    @Default(<String, dynamic>{}) Map<String, dynamic> payload,
    @Default(false) bool read,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _MobileNotification;

  factory MobileNotification.fromJson(Map<String, dynamic> json) =>
      _$MobileNotificationFromJson(json);

  String title(bool arabic) => _localized(arabic, titleAr, titleEn);

  String body(bool arabic) => _localized(arabic, bodyAr, bodyEn);

  String get localizedTitle => title(_isArabic);

  String get localizedBody => body(_isArabic);

  bool get _isArabic {
    final appLocale = SCAFFOLD_MESSENGER_KEY.currentContext?.locale;
    final languageCode = appLocale?.languageCode ?? Intl.getCurrentLocale();
    return languageCode.split(RegExp('[-_]')).first == 'ar';
  }

  String _localized(bool arabic, String ar, String en) {
    final preferred = (arabic ? ar : en).trim();
    if (preferred.isNotEmpty) return preferred;
    final fallback = (arabic ? en : ar).trim();
    return fallback;
  }
}

@freezed
abstract class UnreadNotificationsCount with _$UnreadNotificationsCount {
  const factory UnreadNotificationsCount({@Default(0) int unread}) =
      _UnreadNotificationsCount;

  factory UnreadNotificationsCount.fromJson(Map<String, dynamic> json) =>
      _$UnreadNotificationsCountFromJson(json);
}

@freezed
abstract class MarkedNotificationsCount with _$MarkedNotificationsCount {
  const factory MarkedNotificationsCount({@Default(0) int marked}) =
      _MarkedNotificationsCount;

  factory MarkedNotificationsCount.fromJson(Map<String, dynamic> json) =>
      _$MarkedNotificationsCountFromJson(json);
}
