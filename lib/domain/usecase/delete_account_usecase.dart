import 'package:dartz/dartz.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class DeleteAccountUseCase implements Base<void, Unit> {
  final Repository _repository;

  DeleteAccountUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> execute(void input) =>
      _repository.deleteAccount();
}
