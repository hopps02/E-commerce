import 'package:jar/app/services/storage_services/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jar/app/config/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String _APPLICATION_JSON = 'application/json';
const String _CONTENT_TYPE = 'content-type';
const String _ACCEPT = 'accept';
const String _AUTHORIZATION = 'authorization';
const String _DEFAULT_LANGUAGE = 'language';

enum RequestMethod { GET, POST, PUT, DELETE, PATCH }

class DioFactory {
  late Dio _dio;
  StorageService _storageService;
  bool isForNotification;

  Dio get dio => _dio;

  DioFactory(this._storageService, {this.isForNotification = false}) {
    _dio = Dio();

    Map<String, String> headers = {
      _CONTENT_TYPE: _APPLICATION_JSON,
      _ACCEPT: _APPLICATION_JSON,
      _DEFAULT_LANGUAGE: 'en',
    };

    _dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      followRedirects: false,
      receiveDataWhenStatusError: true,
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storageService.getToken();
          if (token != null) options.headers[_AUTHORIZATION] = 'Bearer $token';
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          return handler.next(e);
        },
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
      );
    }
  }

  Future<Response> request(
    String path, {
    RequestMethod method = RequestMethod.GET,
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.request(
      path,
      data: body,
      queryParameters: queryParameters,
      options: Options(method: method.name, headers: headers),
    );
  }
}
