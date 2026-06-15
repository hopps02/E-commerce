import 'package:dartz/dartz.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/data/response/customer/support_response.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class GetLegalPoliciesUseCase implements Base<void, List<LegalSection>> {
  final Repository _repository;

  GetLegalPoliciesUseCase(this._repository);

  @override
  Future<Either<Failure, List<LegalSection>>> execute(void input) =>
      _repository.legalPolicies();
}
