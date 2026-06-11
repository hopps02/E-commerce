import 'package:dartz/dartz.dart';
import 'package:for_u/data/models/auth/auth_models.dart';
import 'package:for_u/data/network/api/auth_api.dart';
import 'package:for_u/data/network/error_handler/error_handler.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _api;

  AuthRepositoryImpl(this._api);

  @override
  Future<Either<Failure, OtpRequested>> requestOtp(String phone) => fastHandler(
    request: () async =>
        (await _api.requestOtp(RequestOtpBody(phone: phone))).data,
  );

  @override
  Future<Either<Failure, AuthSession>> verifyOtp(String phone, String code) =>
      fastHandler(
        request: () async => (await _api.verifyOtp(
          VerifyOtpBody(phone: phone, code: code),
        )).data,
      );

  @override
  Future<Either<Failure, MeData>> me() =>
      fastHandler(request: () async => (await _api.me()).data);

  @override
  Future<Either<Failure, Unit>> logout() => fastHandler(
    request: () async {
      await _api.logout();
      return unit;
    },
  );

  @override
  Future<Either<Failure, Unit>> registerDevice(RegisterDeviceBody body) =>
      fastHandler(
        request: () async {
          await _api.registerDevice(body);
          return unit;
        },
      );

  @override
  Future<Either<Failure, Unit>> unregisterDevice(String token) => fastHandler(
    request: () async {
      await _api.unregisterDevice({'token': token});
      return unit;
    },
  );
}
