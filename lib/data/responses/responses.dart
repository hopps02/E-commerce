import 'package:freezed_annotation/freezed_annotation.dart';

import '../network/converters/datetime_converter.dart';

part 'responses.freezed.dart';
part 'responses.g.dart';

abstract class BasicResponse {
  bool get success;
  String get message;
}

@freezed
abstract class AuthInitResponse with _$AuthInitResponse implements BasicResponse {
  const factory AuthInitResponse({
    @Default(true) bool success,
    @Default('') String message,
    @Default(false) bool registered,
    @JsonKey(name: 'created_at') @DateTimeConverter() required DateTime createdAt,
    @JsonKey(name: 'last_login_at') @NullableDateTimeConverter() DateTime? lastLoginAt,
  }) = _AuthInitResponse;

  factory AuthInitResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthInitResponseFromJson(json);
}
