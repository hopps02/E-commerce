import 'package:dartz/dartz.dart';
import 'package:for_u/data/request/customer/customer_request.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/data/response/customer/support_response.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class OpenCashierTicketUseCase implements Base<OpenTicketBody, Ticket> {
  final Repository _repository;

  OpenCashierTicketUseCase(this._repository);

  @override
  Future<Either<Failure, Ticket>> execute(OpenTicketBody body) =>
      _repository.openCashierTicket(body);
}
