import 'package:dartz/dartz.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class RemoveFavoriteUseCase implements Base<int, Unit> {
  final Repository _repository;

  RemoveFavoriteUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> execute(int branchItemId) =>
      _repository.removeFavorite(branchItemId);
}
