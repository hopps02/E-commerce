import 'dart:async';

import 'package:dio/dio.dart';
import 'package:store/app/app.dart';
import 'package:store/app/services/session_service.dart';
import 'package:store/app/services/storage_services/storage_service.dart';
import 'package:store/data/network/api/auth_api.dart';
import 'package:store/data/response/auth/auth_response.dart';
import 'package:store/domain/usecase/guest_login_usecase.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:go_router/go_router.dart';

class AuthInterceptor extends Interceptor {
  static const _retryMarker = 'auth_retry_attempted';
  static Completer<AuthSession?>? _refreshCompleter;
  static Completer<String?>? _guestCompleter;
  static String? _lastIssuedAccessToken;

  final StorageService _storageService;
  final AuthApi _authApi;
  final Dio _retryDio;
  final SessionService Function() _sessionService;
  final GuestLoginUseCase Function() _guestLoginUseCase;

  AuthInterceptor(
    this._storageService,
    this._authApi,
    this._retryDio, {
    required SessionService Function() sessionService,
    required GuestLoginUseCase Function() guestLoginUseCase,
  })  : _sessionService = sessionService,
        _guestLoginUseCase = guestLoginUseCase;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storageService.getToken();
    if (token != null) {
      options.headers['authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  /// Expired access tokens retry once. Customers refresh with their refresh
  /// token; guests silently mint a fresh guest token unless the backend said
  /// the action itself requires login.
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (_isAuthCall(err.requestOptions)) {
      handler.next(err);
      return;
    }

    if (_isAccountSuspended(err)) {
      await _clearSessionAndNavigate();
      handler.next(err);
      return;
    }

    if (!_isUnauthorized(err)) {
      handler.next(err);
      return;
    }

    if (await _storageService.getGuest()) {
      await _handleGuestUnauthorized(err, handler);
      return;
    }

    await _handleCustomerUnauthorized(err, handler);
  }

  Future<void> _handleGuestUnauthorized(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (_errorCode(err) == 'login_required') {
      handler.next(err);
      return;
    }

    if (_hasRetried(err.requestOptions)) {
      // A guest is never sent to the login screen: surface the error and keep
      // the guest session so the next call can re-mint. Navigating to auth here
      // traps the guest (home 401s again → back to auth, forever).
      handler.next(err);
      return;
    }

    try {
      final retryResponse = await _retryIfAccessTokenChanged(
        err.requestOptions,
      );
      if (retryResponse != null) {
        handler.resolve(retryResponse);
        return;
      }
    } on DioException catch (retryErr) {
      handler.next(retryErr);
      return;
    } catch (_) {
      // Fall through to guest token re-mint.
    }

    final accessToken = await _reissueGuest();
    if (accessToken == null || accessToken.isEmpty) {
      // Re-mint failed (e.g. offline). Don't clear the session or bounce to the
      // login screen — surface the error; a later call retries the guest mint.
      handler.next(err);
      return;
    }

    try {
      final retryResponse = await _retryRequest(
        err.requestOptions,
        accessToken,
      );
      handler.resolve(retryResponse);
      return;
    } on DioException catch (retryErr) {
      handler.next(retryErr);
      return;
    }
  }

  Future<void> _handleCustomerUnauthorized(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (_hasRetried(err.requestOptions)) {
      await _clearSessionAndNavigate();
      handler.next(err);
      return;
    }

    try {
      final retryResponse = await _retryIfAccessTokenChanged(
        err.requestOptions,
      );
      if (retryResponse != null) {
        handler.resolve(retryResponse);
        return;
      }
    } on DioException catch (retryErr) {
      handler.next(retryErr);
      return;
    } catch (_) {
      // Fall through to the normal refresh path.
    }

    final session = await _refreshSession();
    final accessToken = session?.accessToken;
    if (accessToken == null || accessToken.isEmpty) {
      await _clearSessionAndNavigate();
      handler.next(err);
      return;
    }

    try {
      final retryResponse = await _retryRequest(
        err.requestOptions,
        accessToken,
      );
      handler.resolve(retryResponse);
      return;
    } on DioException catch (retryErr) {
      handler.next(retryErr);
      return;
    }
  }

  Future<String?> _reissueGuest() async {
    final activeGuest = _guestCompleter;
    if (activeGuest != null) return activeGuest.future;

    final completer = Completer<String?>();
    _guestCompleter = completer;

    try {
      final result = await _guestLoginUseCase().execute(null);
      return await result.fold(
        (_) async {
          completer.complete(null);
          return null;
        },
        (session) async {
          await _sessionService().establishGuest(session.accessToken);
          _lastIssuedAccessToken = session.accessToken;
          completer.complete(session.accessToken);
          return session.accessToken;
        },
      );
    } catch (_) {
      completer.complete(null);
      return null;
    } finally {
      if (identical(_guestCompleter, completer)) {
        _guestCompleter = null;
      }
    }
  }

  Future<AuthSession?> _refreshSession() async {
    final activeRefresh = _refreshCompleter;
    if (activeRefresh != null) return activeRefresh.future;

    final completer = Completer<AuthSession?>();
    _refreshCompleter = completer;

    try {
      final storedRefreshToken = await _storageService.getRefreshToken();
      if (storedRefreshToken == null || storedRefreshToken.isEmpty) {
        completer.complete(null);
        return null;
      }

      final response = await _authApi.refresh({
        'refresh_token': storedRefreshToken,
      });
      final session = response.data;
      final persisted = await _persistRefreshedSession(session);
      final refreshedSession = persisted ? session : null;
      completer.complete(refreshedSession);
      return refreshedSession;
    } catch (_) {
      // Any refresh failure means the refresh token can no longer extend
      // this session.
      completer.complete(null);
      return null;
    } finally {
      if (identical(_refreshCompleter, completer)) {
        _refreshCompleter = null;
      }
    }
  }

  Future<bool> _persistRefreshedSession(AuthSession session) async {
    final accessToken = session.accessToken;
    final refreshToken = session.refreshToken;
    final role = session.role;

    if (session.blocked ||
        accessToken == null ||
        accessToken.isEmpty ||
        refreshToken == null ||
        refreshToken.isEmpty ||
        role == null) {
      return false;
    }

    await _storageService.setToken(accessToken);
    await _storageService.setRefreshToken(refreshToken);
    await _storeAccessTokenExpiry(session.expiresIn);
    await _storageService.deleteGuest();
    await _storageService.setRole(role.value);
    _lastIssuedAccessToken = accessToken;
    return true;
  }

  Future<void> _storeAccessTokenExpiry(int? expiresIn) async {
    if (expiresIn == null || expiresIn <= 0) {
      await _storageService.deleteAccessTokenExpiresAt();
      return;
    }
    await _storageService.setAccessTokenExpiresAt(
      DateTime.now().add(Duration(seconds: expiresIn)),
    );
  }

  Future<Response<dynamic>> _retryRequest(
    RequestOptions requestOptions,
    String accessToken,
  ) {
    final headers = Map<String, dynamic>.from(requestOptions.headers);
    headers['authorization'] = 'Bearer $accessToken';

    return _retryDio.fetch<dynamic>(
      requestOptions.copyWith(
        headers: headers,
        extra: {
          ...requestOptions.extra,
          _retryMarker: true,
        },
      ),
    );
  }

  Future<Response<dynamic>?> _retryIfAccessTokenChanged(
    RequestOptions requestOptions,
  ) async {
    final currentToken = await _storageService.getToken();
    if (currentToken == null || currentToken.isEmpty) return null;
    if (_lastIssuedAccessToken != currentToken) return null;

    final requestToken = _requestBearerToken(requestOptions);
    if (requestToken == currentToken) return null;

    return _retryRequest(requestOptions, currentToken);
  }

  String? _requestBearerToken(RequestOptions requestOptions) {
    final value = requestOptions.headers['authorization'] ??
        requestOptions.headers['Authorization'];
    if (value is! String || value.isEmpty) return null;

    const bearerPrefix = 'bearer ';
    if (value.toLowerCase().startsWith(bearerPrefix)) {
      return value.substring(bearerPrefix.length);
    }
    return value;
  }

  Future<void> _clearSessionAndNavigate() async {
    await _sessionService().clearLocal();
    _lastIssuedAccessToken = null;
    NAVIGATOR_KEY.currentContext?.goNamed(Routes.auth.name);
  }

  bool _isUnauthorized(DioException err) => err.response?.statusCode == 401;

  bool _hasRetried(RequestOptions options) =>
      options.extra[_retryMarker] == true;

  bool _isAccountSuspended(DioException err) {
    final status = err.response?.statusCode;
    return status == 403 && _errorCode(err) == 'account_suspended';
  }

  String? _errorCode(DioException err) {
    final body = err.response?.data;
    return body is Map && body['error'] is Map
        ? body['error']['code']?.toString()
        : null;
  }

  /// Login/verify/guest/refresh calls legitimately 401 on bad input — never
  /// recurse into the auth handlers for those.
  bool _isAuthCall(RequestOptions options) =>
      options.path.contains('/mobile/auth/');
}
