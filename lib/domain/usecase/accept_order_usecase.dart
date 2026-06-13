import 'package:dartz/dartz.dart';
import 'package:for_u/data/response/captain/captain_response.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class AcceptOrderUseCase implements Base<int, CaptainOrder> {
  final Repository _repository;

  AcceptOrderUseCase(this._repository);

  @override
  Future<Either<Failure, CaptainOrder>> execute(int orderId) =>
      _repository.acceptOrder(orderId);
}
