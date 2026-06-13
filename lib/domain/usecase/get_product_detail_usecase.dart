import 'package:dartz/dartz.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class GetProductDetailUseCase implements Base<int, BranchProduct> {
  final Repository _repository;

  GetProductDetailUseCase(this._repository);

  @override
  Future<Either<Failure, BranchProduct>> execute(int id) =>
      _repository.productDetail(id);
}
