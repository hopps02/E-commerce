import 'package:dartz/dartz.dart';
import 'package:for_u/data/response/cashier/cashier_response.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class RejectOrderParams {
  final int orderId;
  final String? reason;

  const RejectOrderParams({required this.orderId, this.reason});
}

class RejectOrderUseCase implements Base<RejectOrderParams, CashierOrder> {
  final Repository _repository;

  RejectOrderUseCase(this._repository);

  @override
  Future<Either<Failure, CashierOrder>> execute(RejectOrderParams params) =>
      _repository.rejectOrder(params.orderId, reason: params.reason);
}
