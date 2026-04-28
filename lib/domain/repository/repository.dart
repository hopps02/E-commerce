import 'package:dartz/dartz.dart';
import 'package:jar/data/network/error_handler/failure.dart';

import '../../data/request/request.dart';
import '../../data/responses/responses.dart';

abstract class RepositoryAbs {
  Future<Either<Failure, AuthInitResponse>> authInit(AuthInitRequest request);
}
