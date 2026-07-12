import 'package:dartz/dartz.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class SetCaptainAvailabilityUseCase implements Base<bool, Unit> {
  final Repository _repository;

  SetCaptainAvailabilityUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> execute(bool isAvailable) =>
      _repository.setAvailability(isAvailable);
}
