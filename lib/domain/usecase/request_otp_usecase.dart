import 'package:dartz/dartz.dart';
import 'package:store/data/response/auth/auth_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class RequestOtpUseCase implements Base<String, OtpRequested> {
  final Repository _repository;

  RequestOtpUseCase(this._repository);

  @override
  Future<Either<Failure, OtpRequested>> execute(String phone) =>
      _repository.requestOtp(phone);
}
