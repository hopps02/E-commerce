import 'package:dartz/dartz.dart';
import 'package:store/data/response/cashier/cashier_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class GetCashierOrderDetailUseCase implements Base<int, CashierOrder> {
  final Repository _repository;

  GetCashierOrderDetailUseCase(this._repository);

  @override
  Future<Either<Failure, CashierOrder>> execute(int id) =>
      _repository.cashierOrderDetail(id);
}
