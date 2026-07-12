import 'package:dartz/dartz.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class AddFavoriteUseCase implements Base<int, Unit> {
  final Repository _repository;

  AddFavoriteUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> execute(int branchItemId) =>
      _repository.addFavorite(branchItemId);
}
