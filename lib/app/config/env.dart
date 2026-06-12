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

  /// The browse branch until the multi-store home ships (GET /mobile/home is
  /// pending the client's marketplace decision). Products, cart and checkout
  /// already flow per-branch, so removing this later is a one-site change.
  static const int defaultBranchId = int.fromEnvironment(
    'DEFAULT_BRANCH_ID',
    defaultValue: 1,
  );
}
