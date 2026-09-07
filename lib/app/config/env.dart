import 'package:flutter/foundation.dart' show kIsWeb;

/// Where the app looks for its backend.
class Env {
  Env._();

  static const String _override = String.fromEnvironment('BASE_URL');

  /// A `--dart-define=BASE_URL=...` always wins.
  ///
  /// Failing that, a web build talks to whatever host served it, so one bundle
  /// works on localhost, staging and production without a rebuild — and never
  /// trips CORS, because every call is same-origin. Put the API behind
  /// `/api/v1` on that host (the bundled dev server and any reverse proxy in
  /// front of Laravel already do).
  ///
  /// A mobile build has no origin to borrow, so it falls back to the Android
  /// emulator's route to the host machine and must be given a real one at
  /// build time:
  ///
  ///   flutter build apk --dart-define=BASE_URL=https://api.example.com/api/v1
  static String get baseUrl {
    if (_override.isNotEmpty) return _override;
    if (kIsWeb) return '${Uri.base.origin}/api/v1';

    return 'http://10.0.2.2:8000/api/v1';
  }
}
