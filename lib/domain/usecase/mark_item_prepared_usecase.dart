import 'package:dartz/dartz.dart';
import 'package:for_u/data/response/cashier/cashier_response.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class MarkItemPreparedParams {
  final int orderId;
  final int itemId;
  final bool prepared;

  const MarkItemPreparedParams({
    required this.orderId,
    required this.itemId,
    required this.prepared,
  });
}

class MarkItemPreparedUseCase
    implements Base<MarkItemPreparedParams, CashierOrder> {
  final Repository _repository;

  MarkItemPreparedUseCase(this._repository);

  @override
  Future<Either<Failure, CashierOrder>> execute(
    MarkItemPreparedParams params,
  ) => _repository.markItemPrepared(
    params.orderId,
    params.itemId,
    prepared: params.prepared,
  );
}
