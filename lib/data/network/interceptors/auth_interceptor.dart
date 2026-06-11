import 'package:dio/dio.dart';
import 'package:for_u/app/app.dart';
import 'package:for_u/app/services/storage_services/storage_service.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:go_router/go_router.dart';

class AuthInterceptor extends Interceptor {
  final StorageService _storageService;

  AuthInterceptor(this._storageService);

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

  /// A dead session (expired/blacklisted token, or the account suspended
  /// mid-session) is cleared and the user lands back on auth — instead of
  /// every subsequent call failing forever.
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (_isSessionDead(err) && !_isAuthCall(err.requestOptions)) {
      await _storageService.deleteToken();
      await _storageService.deleteRole();
      NAVIGATOR_KEY.currentContext?.goNamed(Routes.auth.name);
    }
    handler.next(err);
  }

  bool _isSessionDead(DioException err) {
    final status = err.response?.statusCode;
    if (status == 401) return true;

    final body = err.response?.data;
    final code = body is Map
        ? (body['error'] is Map ? body['error']['code'] : null)
        : null;
    return status == 403 && code == 'account_suspended';
  }

  /// Login/verify calls legitimately 401 on bad input — never react to those.
  bool _isAuthCall(RequestOptions options) =>
      options.path.contains('/mobile/auth/');
}
