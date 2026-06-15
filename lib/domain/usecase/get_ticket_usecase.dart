import 'package:dartz/dartz.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/data/response/customer/support_response.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class GetTicketUseCase implements Base<int, Ticket> {
  final Repository _repository;

  GetTicketUseCase(this._repository);

  @override
  Future<Either<Failure, Ticket>> execute(int id) => _repository.ticket(id);
}
