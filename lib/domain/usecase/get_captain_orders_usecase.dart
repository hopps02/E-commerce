import 'package:dartz/dartz.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class CaptainOrdersParams {
  final String queue;
  final int page;
  final int pageSize;

  const CaptainOrdersParams({
    required this.queue,
    required this.page,
    this.pageSize = 20,
  });
}

class GetCaptainOrdersUseCase
    implements Base<CaptainOrdersParams, CaptainOrdersPage> {
  final Repository _repository;

  GetCaptainOrdersUseCase(this._repository);

  @override
  Future<Either<Failure, CaptainOrdersPage>> execute(
    CaptainOrdersParams params,
  ) => _repository.captainOrders(
    queue: params.queue,
    page: params.page,
    pageSize: params.pageSize,
  );
}
