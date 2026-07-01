import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart'
    as libphonenumber;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/app.dart';
import 'package:for_u/app/config/constants.dart';
import 'package:for_u/app/config/supported_locales.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/services/firebase_messeging_services.dart';
import 'package:for_u/app/utils/logger/app_logger.dart';
import 'package:for_u/firebase_options.dart';
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

  // Firebase + push. Guarded so a messaging hiccup (e.g. iOS APNs not yet set up)
  // never blocks the app from starting.
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseMessegingServices.instance.initialize();
    unawaited(FirebaseMessegingServices.instance.handleInitialMessage());
  } catch (e, s) {
    AppLogger.instance.e('Firebase init failed', error: e, stackTrace: s);
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
