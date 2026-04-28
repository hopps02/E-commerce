import 'package:dartz/dartz.dart';
import 'package:jar/data/network/error_handler/error_handler.dart';
import 'package:jar/data/network/error_handler/failure.dart';
import 'package:jar/data/network/internet_checker.dart';
import 'package:jar/data/responses/responses.dart';
import 'package:jar/domain/repository/repository.dart';

import '../network/api.dart';
import '../request/request.dart';

class Repository implements RepositoryAbs {
  final AppServices _appServices;

  Repository(this._appServices);

  @override
  Future<Either<Failure, AuthInitResponse>> authInit(
    AuthInitRequest request,
  ) async {
    return fastHandler<AuthInitResponse>(
      request: () => _appServices.authInit(request),
    );
  }
}
