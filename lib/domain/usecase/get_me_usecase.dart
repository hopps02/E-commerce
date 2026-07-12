import 'package:dartz/dartz.dart';
import 'package:store/data/response/auth/auth_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class GetMeUseCase implements Base<void, MeData> {
  final Repository _repository;

  GetMeUseCase(this._repository);

  @override
  Future<Either<Failure, MeData>> execute(void input) => _repository.me();
}
