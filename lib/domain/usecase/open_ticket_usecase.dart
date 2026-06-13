import 'package:dartz/dartz.dart';
import 'package:for_u/data/request/customer/customer_request.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class OpenTicketUseCase implements Base<OpenTicketBody, Unit> {
  final Repository _repository;

  OpenTicketUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> execute(OpenTicketBody body) =>
      _repository.openTicket(body);
}
