import 'package:flutter/foundation.dart';

/// The real runtime target the app is running on.
///
/// Note: [AppPlatform.web] takes priority — on web, `defaultTargetPlatform`
/// still reports the underlying OS (android/ios/macos/...), so a Flutter web
/// app running inside Safari on an iPhone resolves to [AppPlatform.web], not
/// [AppPlatform.ios]. Use [hostTargetPlatform] on [ResponsiveInfo] if you need
/// the OS behind the browser.
enum AppPlatform { web, android, ios, windows, macos, linux, fuchsia }

/// Resolves the current [AppPlatform] safely on every target (never touches
/// `dart:io`, so it does not throw on web).
AppPlatform currentAppPlatform() {
  if (kIsWeb) return AppPlatform.web;
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return AppPlatform.android;
    case TargetPlatform.iOS:
      return AppPlatform.ios;
    case TargetPlatform.windows:
      return AppPlatform.windows;
    case TargetPlatform.macOS:
      return AppPlatform.macos;
    case TargetPlatform.linux:
      return AppPlatform.linux;
    case TargetPlatform.fuchsia:
      return AppPlatform.fuchsia;
  }
}
