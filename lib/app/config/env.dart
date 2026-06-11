/// Build-time backend selection. Pass `--dart-define=BASE_URL=...` to point a
/// build elsewhere without touching code:
///
/// - iOS simulator (default): http://127.0.0.1:8000/api/v1
/// - Android emulator:        http://10.0.2.2:8000/api/v1
/// - Production:              set the deployed API origin + /api/v1
class Env {
  Env._();

  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://127.0.0.1:8000/api/v1',
  );
}
