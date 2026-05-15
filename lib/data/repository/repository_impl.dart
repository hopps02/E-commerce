import 'package:dartz/dartz.dart';
import 'package:for_u/data/network/error_handler/error_handler.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/data/responses/responses.dart';
import 'package:for_u/domain/repository/repository.dart';

import '../network/api/api.dart';
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
