import 'package:dartz/dartz.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/data/response/auth/auth_response.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class GuestLoginUseCase implements Base<void, GuestSession> {
  final Repository _repository;

  GuestLoginUseCase(this._repository);

  @override
  Future<Either<Failure, GuestSession>> execute(void input) =>
      _repository.guestLogin();
}
