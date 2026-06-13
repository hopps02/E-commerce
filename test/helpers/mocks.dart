import 'package:dio/dio.dart';
import 'package:for_u/data/request/auth/auth_request.dart';
import 'package:for_u/data/network/api/auth_api.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/get_me_usecase.dart';
import 'package:for_u/domain/usecase/logout_usecase.dart';
import 'package:for_u/domain/usecase/register_device_usecase.dart';
import 'package:for_u/domain/usecase/unregister_device_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements Repository {}

class MockRegisterDeviceUseCase extends Mock implements RegisterDeviceUseCase {}

class MockGetMeUseCase extends Mock implements GetMeUseCase {}

class MockUnregisterDeviceUseCase extends Mock
    implements UnregisterDeviceUseCase {}

class MockLogoutUseCase extends Mock implements LogoutUseCase {}

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
