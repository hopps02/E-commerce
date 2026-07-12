import 'package:dartz/dartz.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class GetProductDetailUseCase implements Base<int, BranchProduct> {
  final Repository _repository;

  GetProductDetailUseCase(this._repository);

  @override
  Future<Either<Failure, BranchProduct>> execute(int id) =>
      _repository.productDetail(id);
}
