import 'package:dartz/dartz.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class SetCaptainAvailabilityUseCase implements Base<bool, Unit> {
  final Repository _repository;

  SetCaptainAvailabilityUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> execute(bool isAvailable) =>
      _repository.setAvailability(isAvailable);
}
