import 'package:dartz/dartz.dart';
import 'package:store/data/response/cashier/cashier_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class GetCashierProfileUseCase implements Base<void, CashierProfile> {
  final Repository _repository;

  GetCashierProfileUseCase(this._repository);

  @override
  Future<Either<Failure, CashierProfile>> execute(void input) =>
      _repository.cashierMe();
}
