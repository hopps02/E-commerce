import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart' show Locale;
import 'package:easy_localization/easy_localization.dart';
import 'package:store/app/app.dart';
import 'package:store/app/config/supported_locales.dart';
import 'package:store/app/di/dependency_injection.dart';

class LanguageInterceptor extends Interceptor {
  LanguageInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Accept-Language'] = _language().toLanguageTag();
    handler.next(options);
  }

  /// The language on screen — except that the app asks the store a few things
  /// before the first frame exists, and there is no screen to ask that early.
  /// Then the saved language stands in, and Arabic stands in for that.
  Locale _language() {
    final context = SCAFFOLD_MESSENGER_KEY.currentContext;
    if (context != null) return context.locale;

    return DI().prefs.language ?? SupportedLocales.AR.locale;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}
