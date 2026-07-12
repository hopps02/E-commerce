import 'package:dartz/dartz.dart';
import 'package:store/data/request/customer/customer_request.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/data/response/customer/support_response.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class OpenCaptainTicketUseCase implements Base<OpenTicketBody, Ticket> {
  final Repository _repository;

  OpenCaptainTicketUseCase(this._repository);

  @override
  Future<Either<Failure, Ticket>> execute(OpenTicketBody body) =>
      _repository.openCaptainTicket(body);
}
