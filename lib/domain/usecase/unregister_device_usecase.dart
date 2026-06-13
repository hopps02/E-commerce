import 'package:dartz/dartz.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class UnregisterDeviceUseCase implements Base<String, Unit> {
  final Repository _repository;

  UnregisterDeviceUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> execute(String token) =>
      _repository.unregisterDevice(token);
}
