import 'package:dartz/dartz.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class GetCategoriesUseCase implements Base<void, List<ProductCategory>> {
  final Repository _repository;

  GetCategoriesUseCase(this._repository);

  @override
  Future<Either<Failure, List<ProductCategory>>> execute(void input) =>
      _repository.categories();
}
