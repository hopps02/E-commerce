import 'package:dartz/dartz.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class GetFavoritesUseCase implements Base<void, List<BranchProduct>> {
  final Repository _repository;

  GetFavoritesUseCase(this._repository);

  @override
  Future<Either<Failure, List<BranchProduct>>> execute(void input) =>
      _repository.favorites();
}
