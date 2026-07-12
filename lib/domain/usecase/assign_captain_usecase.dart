import 'package:dartz/dartz.dart';
import 'package:store/data/response/cashier/cashier_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class AssignCaptainParams {
  final int orderId;
  final int captainId;

  const AssignCaptainParams({required this.orderId, required this.captainId});
}

class AssignCaptainUseCase implements Base<AssignCaptainParams, CashierOrder> {
  final Repository _repository;

  AssignCaptainUseCase(this._repository);

  @override
  Future<Either<Failure, CashierOrder>> execute(AssignCaptainParams params) =>
      _repository.assignCaptain(params.orderId, params.captainId);
}
