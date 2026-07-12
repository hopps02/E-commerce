import 'package:dartz/dartz.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class LogoutUseCase implements Base<void, Unit> {
  final Repository _repository;

  LogoutUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> execute(void input) => _repository.logout();
}
