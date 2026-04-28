import 'package:dartz/dartz.dart';
import 'package:jar/data/network/error_handler/failure.dart';
import 'package:jar/data/request/request.dart';
import 'package:jar/data/responses/responses.dart';
import 'package:jar/domain/repository/repository.dart';
import 'package:jar/domain/usecase/base.dart';

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
