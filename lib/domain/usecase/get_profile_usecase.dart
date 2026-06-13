import 'package:dartz/dartz.dart';
import 'package:for_u/data/response/customer/customer_response.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class GetProfileUseCase implements Base<void, CustomerProfile> {
  final Repository _repository;

  GetProfileUseCase(this._repository);

  @override
  Future<Either<Failure, CustomerProfile>> execute(void input) =>
      _repository.profile();
}
