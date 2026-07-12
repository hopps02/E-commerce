import 'package:dartz/dartz.dart';
import 'package:store/data/response/captain/captain_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class GetCaptainProfileUseCase implements Base<void, CaptainProfile> {
  final Repository _repository;

  GetCaptainProfileUseCase(this._repository);

  @override
  Future<Either<Failure, CaptainProfile>> execute(void input) =>
      _repository.captainMe();
}
