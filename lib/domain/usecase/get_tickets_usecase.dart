import 'package:dartz/dartz.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class GetTicketsUseCase implements Base<int, TicketsPage> {
  final Repository _repository;

  GetTicketsUseCase(this._repository);

  @override
  Future<Either<Failure, TicketsPage>> execute(int page) =>
      _repository.tickets(page: page);
}
