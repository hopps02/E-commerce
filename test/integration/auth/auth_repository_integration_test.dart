import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' hide DioErrorType;
import 'package:flutter_test/flutter_test.dart';
import 'package:for_u/data/network/api/auth_api.dart';
import 'package:for_u/data/network/api/captain_api.dart';
import 'package:for_u/data/network/api/cashier_api.dart';
import 'package:for_u/data/network/api/customer_api.dart';
import 'package:for_u/data/network/error_handler/error_handler.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/data/repository/repository_impl.dart';
import 'package:for_u/data/request/auth/auth_request.dart';
import 'package:for_u/data/response/auth/auth_response.dart';
import 'package:for_u/domain/repository/repository.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/fake_http_adapter.dart';

/// Logic integration tests for the auth surface (strategy doc §2): a canned
/// backend payload travels through the REAL retrofit api → Envelope → model →
/// RepositoryImpl → error_handler, and we assert the final
/// `Either<Failure, Model>`. Only Dio's transport is faked.
void main() {
  late FakeHttpAdapter adapter;
  late Repository repo;

  setUp(() {
    adapter = FakeHttpAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://test.local'))
      ..httpClientAdapter = adapter;

    // Everything above the transport is real. Sibling apis share the same Dio
    // but are never hit by these auth tests.
    repo = RepositoryImpl(
      AuthApi(dio),
      CaptainApi(dio),
      CashierApi(dio),
      CustomerApi(dio),
    );
  });

  // ---- Either helpers: fail loudly on the wrong branch. ----
  T expectRight<T>(Either<Failure, T> e) => e.fold(
    (l) => throw TestFailure('Expected Right, got Left($l)'),
    (r) => r,
  );

  Failure expectLeft<T>(Either<Failure, T> e) => e.fold(
    (l) => l,
    (r) => throw TestFailure('Expected Left, got Right($r)'),
  );

  /// The backend's success envelope wraps the resource under `data`.
  Map<String, dynamic> ok(Object data) => {'data': data};

  group('requestOtp', () {
    test('200 → Right(OtpRequested) parsed through the full stack', () async {
      adapter.stubJson(
        '/mobile/auth/request-otp',
        statusCode: 200,
        body: ok(DummyData.otpRequestedJson),
      );

      final otp = expectRight(await repo.requestOtp(DummyData.customerPhone));

      expect(otp.expiresInSeconds, 300);
      expect(otp.resendAfterSeconds, 60);
      expect(otp.maskedPhone, '+966******678');
    });

    test('429 error envelope → Left(ServerError) with code + status', () async {
      adapter.stubJson(
        '/mobile/auth/request-otp',
        statusCode: 429,
        body: DummyData.errorJson('rate_limited', 'Too many requests'),
      );

      final failure = expectLeft(await repo.requestOtp(DummyData.customerPhone));

      expect(failure, isA<ServerError>());
      failure as ServerError;
      expect(failure.code, 'rate_limited');
      expect(failure.statusCode, 429);
    });
  });

  group('verifyOtp', () {
    test('200 happy path → Right(AuthSession) for a customer', () async {
      adapter.stubJson(
        '/mobile/auth/verify-otp',
        statusCode: 200,
        body: ok(DummyData.customerSessionJson),
      );

      final session = expectRight(
        await repo.verifyOtp(DummyData.customerPhone, DummyData.fakeOtpCode),
      );

      expect(session.accessToken, 'jwt-token-value');
      expect(session.role, MobileRole.customer);
      expect(session.account.phone, DummyData.customerPhone);
      expect(session.profile?['customer_number'], 'C345678');
      expect(session.blocked, isFalse);
    });

    test('200 blocked account → Right(AuthSession) with no token', () async {
      adapter.stubJson(
        '/mobile/auth/verify-otp',
        statusCode: 200,
        body: ok(DummyData.blockedSessionJson),
      );

      final session = expectRight(
        await repo.verifyOtp('+966512345679', DummyData.fakeOtpCode),
      );

      // A suspended account is a *successful* envelope, not an error.
      expect(session.blocked, isTrue);
      expect(session.accessToken, isNull);
      expect(session.nextScreen, 'blocked');
    });

    test('422 otp_invalid → Left(ServerError) branchable by code', () async {
      adapter.stubJson(
        '/mobile/auth/verify-otp',
        statusCode: 422,
        body: DummyData.errorJson('otp_invalid', 'The code is incorrect'),
      );

      final failure = expectLeft(
        await repo.verifyOtp(DummyData.customerPhone, '123456'),
      );

      expect(failure, isA<ServerError>());
      failure as ServerError;
      expect(failure.code, 'otp_invalid');
      expect(failure.statusCode, 422);
    });

    test('401 Unauthorized → Left(CustomServerError) via known enum', () async {
      adapter.stubJson(
        '/mobile/auth/verify-otp',
        statusCode: 401,
        body: DummyData.errorJson('unauthorized', 'Unauthorized'),
      );

      final failure = expectLeft(
        await repo.verifyOtp(DummyData.customerPhone, '123456'),
      );

      expect(failure, isA<CustomServerError>());
      expect((failure as CustomServerError).error, ApiErrorType.UNAUTHORIZED);
    });
  });

  group('me / logout / devices', () {
    test('200 → Right(MeData) with role resolved', () async {
      adapter.stubJson(
        '/mobile/me',
        statusCode: 200,
        body: ok({
          'account': DummyData.customerAccountJson,
          'active_role': 'customer',
          'profile': null,
          'scopes': <String, dynamic>{},
        }),
      );

      final me = expectRight(await repo.me());

      expect(me.role, MobileRole.customer);
      expect(me.account.id, 7);
    });

    test('logout 200 → Right(unit)', () async {
      adapter.stubJson(
        '/mobile/auth/logout',
        statusCode: 200,
        body: ok({'logged_out': true}),
      );

      expect((await repo.logout()).isRight(), isTrue);
    });

    test('registerDevice 200 → Right(unit)', () async {
      adapter.stubJson(
        '/mobile/devices',
        statusCode: 200,
        body: ok({'registered': true}),
      );

      final result = await repo.registerDevice(
        const RegisterDeviceBody(
          token: 'fcm-token',
          platform: 'ios',
          locale: 'ar',
          appVersion: '1.0.0',
        ),
      );

      expect(result.isRight(), isTrue);
    });
  });

  group('transport failures', () {
    test('connection error → Left(NoInternetConnection)', () async {
      adapter.stubThrow(
        '/mobile/me',
        DioException(
          requestOptions: RequestOptions(path: '/mobile/me'),
          type: DioExceptionType.connectionError,
        ),
      );

      final failure = expectLeft(await repo.me());

      expect(failure, isA<NoInternetConnection>());
    });

    test('receive timeout → Left(CustomDioLocalError)', () async {
      adapter.stubThrow(
        '/mobile/me',
        DioException(
          requestOptions: RequestOptions(path: '/mobile/me'),
          type: DioExceptionType.receiveTimeout,
        ),
      );

      final failure = expectLeft(await repo.me());

      expect(failure, isA<CustomDioLocalError>());
      expect(
        (failure as CustomDioLocalError).error,
        DioErrorType.RECEIVE_TIMEOUT,
      );
    });
  });
}
