import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// A fake [HttpClientAdapter] for **logic integration tests**.
///
/// It lets a test feed canned backend payloads through the REAL stack —
/// `retrofit api → Envelope.fromJson → model.fromJson → RepositoryImpl →
/// error_handler` — without any network or UI. Only the lowest boundary
/// (Dio's transport) is faked; everything above it is the production code.
///
/// ```dart
/// final adapter = FakeHttpAdapter();
/// final dio = Dio(BaseOptions(baseUrl: 'https://test.local'))
///   ..httpClientAdapter = adapter;
/// adapter.stubJson('/mobile/me', statusCode: 200, body: {'data': {...}});
/// ```
class FakeHttpAdapter implements HttpClientAdapter {
  final Map<String, _Stub> _stubs = {};

  /// Stub a JSON response for [path]. A non-2xx [statusCode] makes Dio raise a
  /// `badResponse` DioException carrying [body] — exactly how the real backend
  /// signals errors with `{error: {code, message, details}}`.
  void stubJson(
    String path, {
    required int statusCode,
    required Object body,
  }) {
    _stubs[path] = _Stub(statusCode: statusCode, body: body);
  }

  /// Stub a transport-level failure for [path] (no internet, timeout, …).
  void stubThrow(String path, DioException error) {
    _stubs[path] = _Stub(error: error);
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final stub = _stubs[options.path] ?? _stubs[options.uri.path];
    if (stub == null) {
      throw StateError(
        'FakeHttpAdapter: no stub for ${options.method} ${options.path}',
      );
    }
    if (stub.error != null) throw stub.error!;

    return ResponseBody.fromBytes(
      utf8.encode(jsonEncode(stub.body)),
      stub.statusCode!,
      headers: {
        Headers.contentTypeHeader: ['application/json; charset=utf-8'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _Stub {
  final int? statusCode;
  final Object? body;
  final DioException? error;

  _Stub({this.statusCode, this.body, this.error});
}
