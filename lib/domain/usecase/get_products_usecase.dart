import 'package:dartz/dartz.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class ProductsParams {
  final int? branchId;
  final int? categoryId;
  final String? search;
  final int page;
  final int pageSize;

  const ProductsParams({
    this.branchId,
    this.categoryId,
    this.search,
    required this.page,
    this.pageSize = 20,
  });
}

class GetProductsUseCase implements Base<ProductsParams, ProductsPage> {
  final Repository _repository;

  GetProductsUseCase(this._repository);

  @override
  Future<Either<Failure, ProductsPage>> execute(ProductsParams params) =>
      _repository.products(
        branchId: params.branchId,
        categoryId: params.categoryId,
        search: params.search,
        page: params.page,
        pageSize: params.pageSize,
      );
}
