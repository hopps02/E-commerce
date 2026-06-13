import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_request.freezed.dart';
part 'auth_request.g.dart';

@freezed
abstract class RequestOtpBody with _$RequestOtpBody {
  const factory RequestOtpBody({required String phone}) = _RequestOtpBody;

  factory RequestOtpBody.fromJson(Map<String, dynamic> json) =>
      _$RequestOtpBodyFromJson(json);
}

@freezed
abstract class VerifyOtpBody with _$VerifyOtpBody {
  const factory VerifyOtpBody({required String phone, required String code}) =
      _VerifyOtpBody;

  factory VerifyOtpBody.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpBodyFromJson(json);
}

@freezed
abstract class RegisterDeviceBody with _$RegisterDeviceBody {
  const factory RegisterDeviceBody({
    required String token,
    required String platform,
    required String locale,
    @JsonKey(name: 'app_version') String? appVersion,
  }) = _RegisterDeviceBody;

  factory RegisterDeviceBody.fromJson(Map<String, dynamic> json) =>
      _$RegisterDeviceBodyFromJson(json);
}
