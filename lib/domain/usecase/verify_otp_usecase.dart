import 'package:dartz/dartz.dart';
import 'package:for_u/data/response/auth/auth_response.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

typedef VerifyOtpInput = ({String phone, String code});

class VerifyOtpUseCase implements Base<VerifyOtpInput, AuthSession> {
  final Repository _repository;

  VerifyOtpUseCase(this._repository);

  @override
  Future<Either<Failure, AuthSession>> execute(VerifyOtpInput input) =>
      _repository.verifyOtp(input.phone, input.code);
}
