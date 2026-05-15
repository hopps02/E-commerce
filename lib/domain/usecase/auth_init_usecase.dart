import 'package:dartz/dartz.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/data/request/request.dart';
import 'package:for_u/data/responses/responses.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class AuthInitUseCase implements Base<AuthInitRequest, AuthInitResponse> {
  final RepositoryAbs _repository;

  AuthInitUseCase(this._repository);

  @override
  Future<Either<Failure, AuthInitResponse>> execute(
    AuthInitRequest request,
  ) async {
    return await _repository.authInit(request);
  }
}
