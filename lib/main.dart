import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jar/app/app.dart';
import 'package:jar/app/config/constants.dart';
import 'package:jar/app/config/supported_locales.dart';
import 'package:jar/app/di/dependency_injection.dart';

void main() {
  runZonedGuarded(_initApp, _onError);
}

Future<void> _initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await DI.init();

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
  debugPrint('[Error] $error');
  debugPrint('[Stack] $stack');
}

// dart pub global activate flutter_gen
// fluttergen -c .\pubspec.yaml
