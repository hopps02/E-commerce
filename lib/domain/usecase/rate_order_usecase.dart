import 'package:dartz/dartz.dart';
import 'package:for_u/data/request/customer/customer_request.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class RateOrderParams {
  final int id;
  final RateOrderBody body;

  const RateOrderParams({required this.id, required this.body});
}

class RateOrderUseCase implements Base<RateOrderParams, Unit> {
  final Repository _repository;

  RateOrderUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> execute(RateOrderParams params) =>
      _repository.rateOrder(params.id, params.body);
}
