import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:jar/app/app.dart';

class LanguageInterceptor extends Interceptor {

  LanguageInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final language = SCAFFOLD_MESSENGER_KEY.currentContext!.locale.toLanguageTag();
    options.headers['Accept-Language'] = language;
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}
