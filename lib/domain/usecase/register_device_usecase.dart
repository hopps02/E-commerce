import 'package:dartz/dartz.dart';
import 'package:for_u/data/request/auth/auth_request.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class RegisterDeviceUseCase implements Base<RegisterDeviceBody, Unit> {
  final Repository _repository;

  RegisterDeviceUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> execute(RegisterDeviceBody body) =>
      _repository.registerDevice(body);
}
