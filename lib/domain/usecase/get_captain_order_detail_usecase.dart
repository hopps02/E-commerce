import 'package:dartz/dartz.dart';
import 'package:store/data/response/captain/captain_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class GetCaptainOrderDetailUseCase implements Base<int, CaptainOrder> {
  final Repository _repository;

  GetCaptainOrderDetailUseCase(this._repository);

  @override
  Future<Either<Failure, CaptainOrder>> execute(int id) =>
      _repository.captainOrderDetail(id);
}
