import 'package:dartz/dartz.dart';
import 'package:for_u/data/response/cashier/cashier_response.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class MarkItemUnavailableParams {
  final int orderId;
  final int itemId;
  final String? reason;

  const MarkItemUnavailableParams({
    required this.orderId,
    required this.itemId,
    this.reason,
  });
}

class MarkItemUnavailableUseCase
    implements Base<MarkItemUnavailableParams, CashierOrder> {
  final Repository _repository;

  MarkItemUnavailableUseCase(this._repository);

  @override
  Future<Either<Failure, CashierOrder>> execute(
    MarkItemUnavailableParams params,
  ) => _repository.markItemUnavailable(
    params.orderId,
    params.itemId,
    reason: params.reason,
  );
}
