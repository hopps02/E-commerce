import 'package:dartz/dartz.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/data/response/customer/support_response.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class ReplyTicketParams {
  final int id;
  final String body;

  const ReplyTicketParams({required this.id, required this.body});
}

class ReplyTicketUseCase implements Base<ReplyTicketParams, Ticket> {
  final Repository _repository;

  ReplyTicketUseCase(this._repository);

  @override
  Future<Either<Failure, Ticket>> execute(ReplyTicketParams params) =>
      _repository.replyTicket(params.id, params.body);
}
