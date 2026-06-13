import 'package:dartz/dartz.dart';
import 'package:for_u/data/response/cashier/cashier_response.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class ConfirmReadyUseCase implements Base<int, CashierOrder> {
  final Repository _repository;

  ConfirmReadyUseCase(this._repository);

  @override
  Future<Either<Failure, CashierOrder>> execute(int orderId) =>
      _repository.confirmReady(orderId);
}
