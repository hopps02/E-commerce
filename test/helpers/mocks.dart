import 'package:dio/dio.dart';
import 'package:for_u/data/models/auth/auth_models.dart';
import 'package:for_u/data/network/api/auth_api.dart';
import 'package:for_u/domain/repository/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthApi extends Mock implements AuthApi {}

class MockDio extends Mock implements Dio {}

class FakeRequestOtpBody extends Fake implements RequestOtpBody {}

class FakeVerifyOtpBody extends Fake implements VerifyOtpBody {}

class FakeRegisterDeviceBody extends Fake implements RegisterDeviceBody {}

class FakeRequestOptions extends Fake implements RequestOptions {}

void registerCommonFallbackValues() {
  registerFallbackValue(FakeRequestOtpBody());
  registerFallbackValue(FakeVerifyOtpBody());
  registerFallbackValue(FakeRegisterDeviceBody());
  registerFallbackValue(FakeRequestOptions());
}
