import 'package:dartz/dartz.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class ProductsParams {
  final int branchId;
  final int? categoryId;
  final String? search;
  final int page;
  final int pageSize;

  const ProductsParams({
    required this.branchId,
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
