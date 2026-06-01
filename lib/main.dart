import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart'
    as libphonenumber;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/app.dart';
import 'package:for_u/app/config/constants.dart';
import 'package:for_u/app/config/supported_locales.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/utils/logger/app_logger.dart';

void main() {
  runZonedGuarded(_initApp, _onError);
}

Future<void> _initApp() async {
  // Framework + plugins
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await libphonenumber.init();
  await DI.init();

  // System UI
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    UncontrolledProviderScope(
      container: DI.container,
      child: EasyLocalization(
        supportedLocales: SupportedLocales.allLocales,
        startLocale: SupportedLocales.AR.locale,
        path: Constants.translationsPath,
        child: MyApp(),
      ),
    ),
  );
}

void _onError(Object error, StackTrace stack) {
  AppLogger.instance.e('Uncaught error', error: error, stackTrace: stack);
}

// dart pub global activate flutter_gen
// fluttergen -c .\pubspec.yaml
