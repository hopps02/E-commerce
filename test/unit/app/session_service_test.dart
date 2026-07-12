import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:store/app/services/session_service.dart';
import 'package:store/app/services/storage_services/storage_service.dart';
import 'package:store/data/request/auth/auth_request.dart';
import 'package:store/data/response/auth/auth_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/mocks.dart';

class MockStorageService extends Mock implements StorageService {}

void main() {
  late MockStorageService storage;
  late MockRegisterDeviceUseCase registerDeviceUseCase;
  late MockGetMeUseCase getMeUseCase;
  late MockUnregisterDeviceUseCase unregisterDeviceUseCase;
  late MockLogoutUseCase logoutUseCase;
  late SessionService service;
  String? fcmToken;

  setUpAll(registerCommonFallbackValues);

  setUp(() {
    storage = MockStorageService();
    registerDeviceUseCase = MockRegisterDeviceUseCase();
    getMeUseCase = MockGetMeUseCase();
    unregisterDeviceUseCase = MockUnregisterDeviceUseCase();
    logoutUseCase = MockLogoutUseCase();
    fcmToken = 'fcm-token';
    service = SessionService(
      storage,
      () async => fcmToken,
      registerDeviceUseCase: registerDeviceUseCase,
      getMeUseCase: getMeUseCase,
      unregisterDeviceUseCase: unregisterDeviceUseCase,
      logoutUseCase: logoutUseCase,
    );

    when(() => storage.setToken(any())).thenAnswer((_) async {});
    when(() => storage.setRole(any())).thenAnswer((_) async {});
    when(() => storage.deleteToken()).thenAnswer((_) async {});
    when(() => storage.deleteRole()).thenAnswer((_) async {});
    when(() => storage.language).thenReturn(const Locale('ar'));
    when(
      () => registerDeviceUseCase.execute(any()),
    ).thenAnswer((_) async => const Right(unit));
  });

  group('establish', () {
    test('stores token + role and registers the device', () async {
      final ok = await service.establish(DummyData.customerSession());

      expect(ok, isTrue);
      verify(() => storage.setToken('jwt-token-value')).called(1);
      verify(() => storage.setRole('customer')).called(1);

      // Device registration is fired without awaiting; let it run.
      await Future<void>.delayed(Duration.zero);
      final body =
          verify(
                () => registerDeviceUseCase.execute(captureAny()),
              ).captured.single
              as RegisterDeviceBody;
      expect(body.token, 'fcm-token');
      expect(body.locale, 'ar');
    });

    test('a blocked session stores nothing', () async {
      final ok = await service.establish(
        AuthSession.fromJson(DummyData.blockedSessionJson),
      );

      expect(ok, isFalse);
      verifyNever(() => storage.setToken(any()));
      verifyNever(() => storage.setRole(any()));
    });

    test('an unknown role stores nothing (forward-compat)', () async {
      final json = Map<String, dynamic>.from(DummyData.customerSessionJson)
        ..['active_role'] = 'supervisor';

      final ok = await service.establish(AuthSession.fromJson(json));

      expect(ok, isFalse);
      verifyNever(() => storage.setToken(any()));
    });

    test('login succeeds even when the FCM token is unavailable', () async {
      fcmToken = null; // e.g. iOS simulator without push support

      final ok = await service.establish(DummyData.customerSession());

      expect(ok, isTrue);
      await Future<void>.delayed(Duration.zero);
      verifyNever(() => registerDeviceUseCase.execute(any()));
    });
  });

  group('resolveStart', () {
    test('no token -> auth', () async {
      when(() => storage.getToken()).thenAnswer((_) async => null);

      expect(await service.resolveStart(), isA<StartAuth>());
    });

    test('token without a stored role -> cleared + auth', () async {
      when(() => storage.getToken()).thenAnswer((_) async => 'jwt');
      when(() => storage.getRole()).thenAnswer((_) async => null);

      expect(await service.resolveStart(), isA<StartAuth>());
      verify(() => storage.deleteToken()).called(1);
    });

    test('valid session -> home for the backend role', () async {
      when(() => storage.getToken()).thenAnswer((_) async => 'jwt');
      when(() => storage.getRole()).thenAnswer((_) async => 'customer');
      when(() => getMeUseCase.execute(null)).thenAnswer(
        (_) async => Right(
          MeData.fromJson(const {
            'account': DummyData.customerAccountJson,
            'active_role': 'customer',
            'profile': null,
            'scopes': <String, dynamic>{},
          }),
        ),
      );

      final start = await service.resolveStart();
      expect(start, isA<StartHome>());
      expect((start as StartHome).role, MobileRole.customer);
    });

    test('expired token (401) -> cleared + auth', () async {
      when(() => storage.getToken()).thenAnswer((_) async => 'jwt');
      when(() => storage.getRole()).thenAnswer((_) async => 'customer');
      when(() => getMeUseCase.execute(null)).thenAnswer(
        (_) async =>
            Left(ServerError(code: 'unauthenticated', statusCode: 401)),
      );

      expect(await service.resolveStart(), isA<StartAuth>());
      verify(() => storage.deleteToken()).called(1);
      verify(() => storage.deleteRole()).called(1);
    });

    test('suspended account -> cleared + auth', () async {
      when(() => storage.getToken()).thenAnswer((_) async => 'jwt');
      when(() => storage.getRole()).thenAnswer((_) async => 'cashier');
      when(() => getMeUseCase.execute(null)).thenAnswer(
        (_) async =>
            Left(ServerError(code: 'account_suspended', statusCode: 403)),
      );

      expect(await service.resolveStart(), isA<StartAuth>());
    });

    test('offline -> stored role wins (no lock-out)', () async {
      when(() => storage.getToken()).thenAnswer((_) async => 'jwt');
      when(() => storage.getRole()).thenAnswer((_) async => 'captain');
      when(
        () => getMeUseCase.execute(null),
      ).thenAnswer((_) async => const Left(NoInternetConnection()));

      final start = await service.resolveStart();
      expect(start, isA<StartHome>());
      expect((start as StartHome).role, MobileRole.captain);
      verifyNever(() => storage.deleteToken());
    });
  });

  group('logout', () {
    test('revokes server-side then clears local state', () async {
      when(
        () => unregisterDeviceUseCase.execute(any()),
      ).thenAnswer((_) async => const Right(unit));
      when(
        () => logoutUseCase.execute(null),
      ).thenAnswer((_) async => const Right(unit));

      await service.logout();

      verify(() => unregisterDeviceUseCase.execute('fcm-token')).called(1);
      verify(() => logoutUseCase.execute(null)).called(1);
      verify(() => storage.deleteToken()).called(1);
      verify(() => storage.deleteRole()).called(1);
    });

    test('local state clears even when the server is unreachable', () async {
      when(
        () => unregisterDeviceUseCase.execute(any()),
      ).thenAnswer((_) async => const Left(NoInternetConnection()));
      when(
        () => logoutUseCase.execute(null),
      ).thenAnswer((_) async => const Left(NoInternetConnection()));

      await service.logout();

      verify(() => storage.deleteToken()).called(1);
      verify(() => storage.deleteRole()).called(1);
    });
  });
}
