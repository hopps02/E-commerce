import 'dart:async';
import 'dart:io' show Platform;

import 'package:for_u/app/services/storage_services/storage_service.dart';
import 'package:for_u/data/models/auth/auth_models.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/auth_repository.dart';

/// Where a cold start should land.
sealed class SessionStart {
  const SessionStart();
}

final class StartAuth extends SessionStart {
  const StartAuth();
}

final class StartHome extends SessionStart {
  final MobileRole role;
  const StartHome(this.role);
}

/// Owns the authenticated session: persisting it after verify-otp, restoring
/// it on cold start, and tearing it down on logout / forced sign-out.
///
/// The FCM token provider is injected so tests never touch Firebase and a
/// simulator without push support can still log in.
class SessionService {
  final StorageService _storage;
  final AuthRepository _authRepository;
  final Future<String?> Function() _fcmToken;

  SessionService(this._storage, this._authRepository, this._fcmToken);

  /// Persists a verified session and registers the device for push.
  /// Returns false (and stores nothing) when the backend refused a token
  /// (blocked account) or sent a role this app version doesn't know.
  Future<bool> establish(AuthSession session) async {
    final token = session.accessToken;
    final role = session.role;
    if (session.blocked || token == null || role == null) return false;

    await _storage.setToken(token);
    await _storage.setRole(role.value);
    unawaited(registerDeviceBestEffort());
    return true;
  }

  /// Push registration must never block or fail login — a simulator has no
  /// FCM token and the backend may be unreachable; the next login retries.
  Future<void> registerDeviceBestEffort() async {
    try {
      final fcm = await _fcmToken();
      if (fcm == null) return;
      await _authRepository.registerDevice(
        RegisterDeviceBody(
          token: fcm,
          platform: Platform.isIOS ? 'ios' : 'android',
          locale: _storage.language?.languageCode ?? 'ar',
        ),
      );
    } catch (_) {
      // Best-effort by contract.
    }
  }

  Future<MobileRole?> storedRole() async =>
      MobileRole.tryFrom(await _storage.getRole());

  /// Resolves the cold-start destination. The stored session is validated
  /// against the backend when reachable; a dead session (expired token,
  /// suspended/deleted account) is cleared. When the backend is unreachable
  /// the stored role wins — being offline must not lock the user out.
  Future<SessionStart> resolveStart() async {
    final token = await _storage.getToken();
    if (token == null) return const StartAuth();

    final stored = await storedRole();
    if (stored == null) {
      // A token without a role predates role persistence; re-authenticate.
      await clearLocal();
      return const StartAuth();
    }

    final result = await _authRepository.me();
    return result.fold(
      (failure) async {
        if (_isSessionDead(failure)) {
          await clearLocal();
          return const StartAuth();
        }
        return StartHome(stored);
      },
      (me) async {
        final current = me.role;
        if (current == null) {
          await clearLocal();
          return const StartAuth();
        }
        // The backend is authoritative — refresh in case the role changed.
        await _storage.setRole(current.value);
        return StartHome(current);
      },
    );
  }

  /// Revokes the session server-side first (the requests need the token),
  /// then clears local state regardless of how the network calls went.
  Future<void> logout() async {
    try {
      final fcm = await _fcmToken();
      if (fcm != null) {
        await _authRepository.unregisterDevice(fcm);
      }
    } catch (_) {
      // The backend prunes dead tokens on failed pushes.
    }
    await _authRepository.logout();
    await clearLocal();
  }

  Future<void> clearLocal() async {
    await _storage.deleteToken();
    await _storage.deleteRole();
  }

  /// Only an invalid token or a deactivated account ends the session —
  /// other failures (timeouts, 5xx, no internet) are transient.
  bool _isSessionDead(Failure failure) =>
      failure is ServerError &&
      (failure.statusCode == 401 || failure.code == 'account_suspended');
}
