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
    @DateTimeConverter() required DateTime createdAt,
    @NullableDateTimeConverter() DateTime? lastLoginAt,
  }) = _AuthInitResponse;

  factory AuthInitResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthInitResponseFromJson(json);
}
