import 'package:dio/dio.dart';
import 'package:for_u/data/network/api/api.dart';
import 'package:for_u/data/request/request.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements RepositoryAbs {}

class MockAppServices extends Mock implements AppServices {}

class MockDio extends Mock implements Dio {}

class FakeAuthInitRequest extends Fake implements AuthInitRequest {}

class FakeRequestOptions extends Fake implements RequestOptions {}

void registerCommonFallbackValues() {
  registerFallbackValue(FakeAuthInitRequest());
  registerFallbackValue(FakeRequestOptions());
}
