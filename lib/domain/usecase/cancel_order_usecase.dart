import 'package:dartz/dartz.dart';
import 'package:for_u/data/response/customer/customer_response.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class CancelOrderUseCase implements Base<int, CustomerOrder> {
  final Repository _repository;

  CancelOrderUseCase(this._repository);

  @override
  Future<Either<Failure, CustomerOrder>> execute(int id) =>
      _repository.cancelOrder(id);
}
