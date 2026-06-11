import 'package:dartz/dartz.dart';
import 'package:for_u/data/models/auth/auth_models.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/auth_repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class RequestOtpUseCase implements Base<String, OtpRequested> {
  final AuthRepository _repository;

  RequestOtpUseCase(this._repository);

  @override
  Future<Either<Failure, OtpRequested>> execute(String phone) =>
      _repository.requestOtp(phone);
}

typedef VerifyOtpInput = ({String phone, String code});

class VerifyOtpUseCase implements Base<VerifyOtpInput, AuthSession> {
  final AuthRepository _repository;

  VerifyOtpUseCase(this._repository);

  @override
  Future<Either<Failure, AuthSession>> execute(VerifyOtpInput input) =>
      _repository.verifyOtp(input.phone, input.code);
}

class GetMeUseCase implements Base<void, MeData> {
  final AuthRepository _repository;

  GetMeUseCase(this._repository);

  @override
  Future<Either<Failure, MeData>> execute(void input) => _repository.me();
}

class LogoutUseCase implements Base<void, Unit> {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> execute(void input) => _repository.logout();
}

class RegisterDeviceUseCase implements Base<RegisterDeviceBody, Unit> {
  final AuthRepository _repository;

  RegisterDeviceUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> execute(RegisterDeviceBody body) =>
      _repository.registerDevice(body);
}
