import 'package:dartz/dartz.dart';
import 'package:for_u/data/response/auth/auth_response.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class RequestOtpUseCase implements Base<String, OtpRequested> {
  final Repository _repository;

  RequestOtpUseCase(this._repository);

  @override
  Future<Either<Failure, OtpRequested>> execute(String phone) =>
      _repository.requestOtp(phone);
}
