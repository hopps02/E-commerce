import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' hide DioErrorType;
import 'package:flutter_test/flutter_test.dart';
import 'package:store/data/network/error_handler/error_handler.dart';
import 'package:store/data/network/error_handler/failure.dart';

import '../../../helpers/dummy_data.dart';

DioException _badResponse({int? statusCode, dynamic data}) => DioException(
  type: DioExceptionType.badResponse,
  requestOptions: RequestOptions(path: '/x'),
  response: Response(
    requestOptions: RequestOptions(path: '/x'),
    statusCode: statusCode,
    data: data,
  ),
);

void main() {
  group('fastHandler', () {
    test('returns Right with the request value', () async {
      final result = await fastHandler(
        request: () async => DummyData.otpRequested(),
      );

      expect(result, isA<Right>());
      result.fold(
        (l) => fail('Expected Right'),
        (r) => expect(r.expiresInSeconds, 300),
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

  group('backend error envelope {error: {code, message, details}}', () {
    test('maps code + message into ServerError', () {
      final failure = _badResponse(
        statusCode: 422,
        data: DummyData.errorJson('otp_invalid', 'The code is incorrect.'),
      ).handle;

      expect(failure, isA<ServerError>());
      final error = failure as ServerError;
      expect(error.code, 'otp_invalid');
      expect(error.message, 'The code is incorrect.');
      expect(error.statusCode, 422);
    });

    test('preserves details (validation fields)', () {
      final failure = _badResponse(
        statusCode: 422,
        data: DummyData.errorJson(
          'validation_failed',
          'The given data was invalid.',
          details: {
            'fields': {
              'phone': ['The phone field is required.'],
            },
          },
        ),
      ).handle;

      final error = failure as ServerError;
      expect(error.code, 'validation_failed');
      expect(error.details?['fields'], isA<Map<String, dynamic>>());
    });

    test('preserves details (otp resend cooldown retry_after_seconds)', () {
      final failure = _badResponse(
        statusCode: 429,
        data: DummyData.errorJson(
          'otp_resend_cooldown',
          'Please wait before requesting another code.',
          details: {'retry_after_seconds': 42},
        ),
      ).handle;

      final error = failure as ServerError;
      expect(error.code, 'otp_resend_cooldown');
      expect(error.details?['retry_after_seconds'], 42);
    });

    test('error as a Map never type-errors (the old String cast bug)', () {
      // Regression guard: the previous handler typed `error` as String and
      // crashed on the canonical object shape.
      expect(
        () => _badResponse(
          statusCode: 403,
          data: DummyData.errorJson('account_suspended', 'Not active.'),
        ).handle,
        returnsNormally,
      );
    });
  });

  group('non-canonical / hostile bodies fall back by HTTP status', () {
    test('empty map body -> status text fallback', () {
      final failure = _badResponse(
        statusCode: 403,
        data: const <String, dynamic>{},
      ).handle;

      expect(failure, isA<ServerError>());
      expect((failure as ServerError).message, contains('Forbidden'));
    });

    test('HTML string body (proxy error page) -> status text fallback', () {
      final failure = _badResponse(
        statusCode: 502,
        data: '<html><body>Bad gateway</body></html>',
      ).handle;

      expect(failure, isA<ServerError>());
      expect((failure as ServerError).statusCode, 502);
    });

    test('null body and null status -> generic unknown message', () {
      final failure = _badResponse(statusCode: null, data: null).handle;

      expect(failure, isA<ServerError>());
      expect((failure as ServerError).message, contains('unknown'));
    });

    test('legacy flat {message, error:String} body still maps', () {
      final failure = _badResponse(
        statusCode: 401,
        data: const {'message': 'Unauthorized', 'error': 'Unauthorized'},
      ).handle;

      expect(failure, isA<CustomServerError>());
      expect((failure as CustomServerError).error, ApiErrorType.UNAUTHORIZED);
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

    test('Unknown exception type -> UnexpectedError', () {
      final failure = 'just a string'.handle;
      expect(failure, isA<UnexpectedError>());
    });
  });

  group('ApiErrorType.from', () {
    test('matches by status + message (case insensitive)', () {
      expect(ApiErrorType.from(401, 'Unauthorized'), ApiErrorType.UNAUTHORIZED);
    });

    test('returns null on mismatched status', () {
      expect(ApiErrorType.from(500, 'Unauthorized'), isNull);
    });

    test('returns null on mismatched message', () {
      expect(ApiErrorType.from(401, 'nope'), isNull);
    });
  });
}
