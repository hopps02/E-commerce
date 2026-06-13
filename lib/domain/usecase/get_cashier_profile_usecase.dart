import 'package:dartz/dartz.dart';
import 'package:for_u/data/response/cashier/cashier_response.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class GetCashierProfileUseCase implements Base<void, CashierProfile> {
  final Repository _repository;

  GetCashierProfileUseCase(this._repository);

  @override
  Future<Either<Failure, CashierProfile>> execute(void input) =>
      _repository.cashierMe();
}
