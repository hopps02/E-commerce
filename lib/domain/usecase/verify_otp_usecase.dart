import 'package:dartz/dartz.dart';
import 'package:store/data/response/auth/auth_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

typedef VerifyOtpInput = ({String phone, String code});

class VerifyOtpUseCase implements Base<VerifyOtpInput, AuthSession> {
  final Repository _repository;

  VerifyOtpUseCase(this._repository);

  @override
  Future<Either<Failure, AuthSession>> execute(VerifyOtpInput input) =>
      _repository.verifyOtp(input.phone, input.code);
}
