import 'package:dartz/dartz.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class CashierOrdersParams {
  final String queue;
  final int page;
  final int pageSize;

  const CashierOrdersParams({
    required this.queue,
    required this.page,
    this.pageSize = 20,
  });
}

class GetCashierOrdersUseCase
    implements Base<CashierOrdersParams, CashierOrdersPage> {
  final Repository _repository;

  GetCashierOrdersUseCase(this._repository);

  @override
  Future<Either<Failure, CashierOrdersPage>> execute(
    CashierOrdersParams params,
  ) => _repository.cashierOrders(
    queue: params.queue,
    page: params.page,
    pageSize: params.pageSize,
  );
}
