import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart'
    as libphonenumber;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/app.dart';
import 'package:store/app/config/constants.dart';
import 'package:store/app/config/supported_locales.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/utils/logger/app_logger.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';



/// dart format off
void main() {
  runZonedGuarded(_initApp, _onError);
}

Future<void> _initApp() async {
  // Framework + plugins
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await libphonenumber.init();
  await DI.init();

  // Initialize Google Maps renderer
  try {
    final GoogleMapsFlutterPlatform mapsImplementation = GoogleMapsFlutterPlatform.instance;
    if (mapsImplementation is GoogleMapsFlutterAndroid) {
      await mapsImplementation.initializeWithRenderer(AndroidMapRenderer.latest);
      mapsImplementation.useAndroidViewSurface = true;
    }
  } catch (e) {
      AppLogger.instance.e('Failed to initialize maps with latest renderer: $e');
      AppLogger.instance.e('Falling back to platform default renderer');
  }

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
