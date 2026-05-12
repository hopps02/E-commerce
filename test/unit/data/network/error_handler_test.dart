import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' hide DioErrorType;
import 'package:flutter_test/flutter_test.dart';
import 'package:jar/data/network/error_handler/error_handler.dart';
import 'package:jar/data/network/error_handler/failure.dart';

import '../../../helpers/dummy_data.dart';

void main() {
  group('fastHandler', () {
    test('returns Right when response.success is true', () async {
      final response = DummyData.authInitResponseSuccess();

      final result = await fastHandler(request: () async => response);

      expect(result, isA<Right>());
      result.fold(
        (l) => fail('Expected Right'),
        (r) => expect(r, response),
      );
    });

    test('returns Left(ServerError) when response.success is false', () async {
      final response =
          DummyData.authInitResponseLogicalFailure(message: 'denied');

      final result = await fastHandler(request: () async => response);

      result.fold(
        (l) {
          expect(l, isA<ServerError>());
          expect((l as ServerError).message, 'denied');
        },
        (r) => fail('Expected Left'),
      );
    });

    test('catches thrown DioException and returns mapped Failure', () async {
      final result = await fastHandler(
        request: () async => throw DioException(
          type: DioExceptionType.connectionError,
          requestOptions: RequestOptions(path: '/x'),
        ),
      );

      result.fold(
        (l) => expect(l, isA<NoInternetConnection>()),
        (r) => fail('Expected Left'),
      );
    });

    test('catches non-Dio exceptions and returns UnexpectedError', () async {
      final result = await fastHandler(
        request: () async => throw Exception('something broke'),
      );

      result.fold(
        (l) => expect(l, isA<UnexpectedError>()),
        (r) => fail('Expected Left'),
      );
    });
  });

  group('ErrorHandler.handle extension', () {
    test('DioException.cancel -> CustomDioLocalError(CANCEL)', () {
      final failure = DioException(
        type: DioExceptionType.cancel,
        requestOptions: RequestOptions(path: '/x'),
      ).handle;
      expect(failure, isA<CustomDioLocalError>());
      expect((failure as CustomDioLocalError).error, DioErrorType.CANCEL);
    });

    test('DioException.sendTimeout -> CustomDioLocalError(SEND_TIMEOUT)', () {
      final failure = DioException(
        type: DioExceptionType.sendTimeout,
        requestOptions: RequestOptions(path: '/x'),
      ).handle;
      expect((failure as CustomDioLocalError).error, DioErrorType.SEND_TIMEOUT);
    });

    test(
        'badResponse 401 UNAUTHORIZED maps to CustomServerError(UNAUTHORIZED)',
        () {
      final failure = DioException(
        type: DioExceptionType.badResponse,
        requestOptions: RequestOptions(path: '/x'),
        response: Response(
          requestOptions: RequestOptions(path: '/x'),
          statusCode: 401,
          data: const {
            'message': 'Unauthorized',
            'error': 'Unauthorized',
          },
        ),
      ).handle;
      expect(failure, isA<CustomServerError>());
      expect(
        (failure as CustomServerError).error,
        ApiErrorType.UNAUTHORIZED,
      );
    });

    test('badResponse with unknown 403 status -> Forbidden fallback', () {
      final failure = DioException(
        type: DioExceptionType.badResponse,
        requestOptions: RequestOptions(path: '/x'),
        response: Response(
          requestOptions: RequestOptions(path: '/x'),
          statusCode: 403,
          data: const <String, dynamic>{},
        ),
      ).handle;
      expect(failure, isA<ServerError>());
      expect((failure as ServerError).message, contains('Forbidden'));
    });

    test('Unknown exception type -> UnexpectedError', () {
      final failure = 'just a string'.handle;
      expect(failure, isA<UnexpectedError>());
    });
  });

  group('ApiErrorType.from', () {
    test('matches by status + message (case insensitive)', () {
      expect(
        ApiErrorType.from(401, 'Unauthorized'),
        ApiErrorType.UNAUTHORIZED,
      );
    });

    test('returns null on mismatched status', () {
      expect(ApiErrorType.from(500, 'Unauthorized'), isNull);
    });

    test('returns null on mismatched message', () {
      expect(ApiErrorType.from(401, 'nope'), isNull);
    });
  });
}
