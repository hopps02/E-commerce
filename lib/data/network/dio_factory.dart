import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:store/app/config/env.dart';
import 'package:store/app/services/session_service.dart';
import 'package:store/app/services/storage_services/storage_service.dart';
import 'package:store/data/network/api/auth_api.dart';
import 'package:store/data/network/interceptors/auth_interceptor.dart';
import 'package:store/data/network/interceptors/language_interceptor.dart';
import 'package:store/domain/usecase/guest_login_usecase.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio buildCleanDio() => Dio(_baseOptions());

Dio buildDio(
  StorageService storageService, {
  required SessionService Function() sessionService,
  required GuestLoginUseCase Function() guestLoginUseCase,
}) {
  final dio = buildCleanDio();
  final refreshDio = buildCleanDio();

  dio.interceptors.add(
    AuthInterceptor(
      storageService,
      AuthApi(refreshDio),
      refreshDio,
      sessionService: sessionService,
      guestLoginUseCase: guestLoginUseCase,
    ),
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
