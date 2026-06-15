import 'package:dartz/dartz.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class GetTicketsUseCase implements Base<int, TicketsPage> {
  final Repository _repository;

  GetTicketsUseCase(this._repository);

  @override
  Future<Either<Failure, TicketsPage>> execute(int page) =>
      _repository.tickets(page: page);
}
