import 'package:dartz/dartz.dart';
import 'package:store/data/response/cashier/cashier_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

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
