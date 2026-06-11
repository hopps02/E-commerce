import 'package:dartz/dartz.dart';
import 'package:for_u/data/models/auth/auth_models.dart';
import 'package:for_u/data/network/error_handler/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, OtpRequested>> requestOtp(String phone);

  Future<Either<Failure, AuthSession>> verifyOtp(String phone, String code);

  Future<Either<Failure, MeData>> me();

  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, Unit>> registerDevice(RegisterDeviceBody body);

  Future<Either<Failure, Unit>> unregisterDevice(String token);
}
