// Run in Edge with web security disabled (local web dev / CORS testing).
// PowerShell — use the call operator `&` so `--flags` aren't parsed as operators:
// & "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --disable-web-security --disable-site-isolation-trials --unsafely-treat-insecure-origin-as-secure="http://localhost:58677" --user-data-dir="C:\edge-dev-session" http://localhost:58677

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart'
    as libphonenumber;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/app.dart';
import 'package:store/app/config/brand.dart';
import 'package:store/app/config/brand_font.dart';
import 'package:store/app/config/constants.dart';
import 'package:store/app/config/supported_locales.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/utils/logger/app_logger.dart';
import 'package:store/data/response/customer/branding_response.dart';
import 'package:store/presentation/common/riverpod/brand_controller.dart';

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

  // The identity from the last run, so the first frame is already the
  // store own colours. The live one arrives a moment later and only
  // repaints if the panel changed something.
  await _paintWithTheStoreIdentity();

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

/// Reads what was cached and applies it. Nothing is downloaded here: a
/// font that is not on this device yet is fetched after the first frame,
/// so a slow network never holds up the splash screen.
Future<void> _paintWithTheStoreIdentity() async {
  final cached = DI().prefs.getMap(BrandNotifier.cacheKey);
  if (cached == null) return;

  final branding = Branding.fromJson(cached);
  Brand.apply(branding);

  final url = branding.fontUrl ?? '';
  if (url.isNotEmpty && await BrandFont.loadCached(url)) {
    Brand.useFont(BrandFont.family);
  }
}

void _onError(Object error, StackTrace stack) {
  AppLogger.instance.e('Uncaught error', error: error, stackTrace: stack);
}

// dart pub global activate flutter_gen
// fluttergen -c .\pubspec.yaml
// dart pub global run flutter_gen:flutter_gen_command -c .\pubspec.yaml
// C:\Program Files (x86)\Microsoft\Edge\Application\
// msedge.exe --disable-web-security --user-data-dir="C:\edge-dev-session" http://localhost:60776

// "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --disable-web-security --disable-site-isolation-trials --unsafely-treat-insecure-origin-as-secure="http://localhost:60963" --user-data-dir="C:\edge-dev-session" http://localhost:60963
