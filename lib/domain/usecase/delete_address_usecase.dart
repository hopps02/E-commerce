import 'package:dartz/dartz.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class DeleteAddressUseCase implements Base<int, Unit> {
  final Repository _repository;

  DeleteAddressUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> execute(int id) =>
      _repository.deleteAddress(id);
}
