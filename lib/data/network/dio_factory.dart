import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:for_u/app/config/env.dart';
import 'package:for_u/app/services/storage_services/storage_service.dart';
import 'package:for_u/data/network/api/auth_api.dart';
import 'package:for_u/data/network/interceptors/auth_interceptor.dart';
import 'package:for_u/data/network/interceptors/language_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio buildCleanDio() => Dio(_baseOptions());

Dio buildDio(StorageService storageService) {
  final dio = buildCleanDio();
  final refreshDio = buildCleanDio();

  dio.interceptors.add(
    AuthInterceptor(storageService, AuthApi(refreshDio), refreshDio),
  );
  dio.interceptors.add(LanguageInterceptor());

  if (kDebugMode) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ),
    );
  }

  return dio;
}

BaseOptions _baseOptions() => BaseOptions(
  baseUrl: Env.baseUrl,
  headers: {
    'content-type': 'application/json',
    'accept': 'application/json',
    'language': 'en',
  },
  followRedirects: false,
  receiveDataWhenStatusError: true,
);
