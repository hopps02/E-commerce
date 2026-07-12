import 'package:dartz/dartz.dart';
import 'package:store/data/response/cashier/cashier_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class ReassignCaptainParams {
  final int orderId;
  final int captainId;
  final String reason;
  final String? note;

  const ReassignCaptainParams({
    required this.orderId,
    required this.captainId,
    required this.reason,
    this.note,
  });
}

class ReassignCaptainUseCase
    implements Base<ReassignCaptainParams, CashierOrder> {
  final Repository _repository;

  ReassignCaptainUseCase(this._repository);

  @override
  Future<Either<Failure, CashierOrder>> execute(ReassignCaptainParams params) =>
      _repository.reassignCaptain(
        params.orderId,
        params.captainId,
        params.reason,
        params.note,
      );
}
