import 'package:dartz/dartz.dart';
import 'package:store/data/request/auth/auth_request.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class RegisterDeviceUseCase implements Base<RegisterDeviceBody, Unit> {
  final Repository _repository;

  RegisterDeviceUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> execute(RegisterDeviceBody body) =>
      _repository.registerDevice(body);
}
