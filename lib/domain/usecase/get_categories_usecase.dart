import 'package:dartz/dartz.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class GetCategoriesUseCase implements Base<void, List<ProductCategory>> {
  final Repository _repository;

  GetCategoriesUseCase(this._repository);

  @override
  Future<Either<Failure, List<ProductCategory>>> execute(void input) =>
      _repository.categories();
}
