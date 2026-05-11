import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/retrofit.dart';

import '../network/converters/datetime_converter.dart';

part 'request.freezed.dart';
part 'request.g.dart';

@freezed
abstract class AuthInitRequest with _$AuthInitRequest {
  const factory AuthInitRequest({
    @Query('email') required String email,
    @Query('birth_date') @DateTimeConverter() required DateTime birthDate,
  }) = _AuthInitRequest;

  factory AuthInitRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthInitRequestFromJson(json);
}
