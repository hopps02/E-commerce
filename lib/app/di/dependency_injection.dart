import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/services/storage_services/secure_storage_service.dart';
import 'package:for_u/app/services/storage_services/shared_prefrences_service.dart';
import 'package:for_u/app/services/storage_services/storage_service.dart';
import 'package:for_u/app/utils/overlay_loading/overlay_loading_manager.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/data/network/api/auth_api.dart';
import 'package:for_u/data/network/dio_factory.dart';
import 'package:for_u/data/repository/auth_repository_impl.dart';
import 'package:for_u/domain/repository/auth_repository.dart';
import 'package:for_u/domain/usecase/auth_usecases.dart';
import 'package:shared_preferences/shared_preferences.dart';

// dart format off
class DI {
  static late final ProviderContainer container;

  // --- Core Infrastructure ---
  static final _sharedPreferences         = Provider<SharedPreferences>((ref) => throw UnimplementedError("Initialize SharedPreferences in DI.init()"));

  static final _secureStorage             = Provider((ref) => SecureStorageService());

  static final _sharedPrefsService        = Provider((ref) => SharedPrefsService(ref.read(_sharedPreferences)));

  static final _storageService            = Provider((ref) => StorageService(ref.read(_secureStorage), ref.read(_sharedPrefsService)));

  // --- Network ---
  static final _dio                       = Provider((ref) => buildDio(ref.read(_storageService)));

  static final _authApi                   = Provider((ref) => AuthApi(ref.read(_dio)));
  // --- Domain & Data ---
  static final _authRepository            = Provider<AuthRepository>((ref) => AuthRepositoryImpl(ref.read(_authApi)));

  // --- snack bar Helper
  static final _snackBarHelper            = Provider((ref) => SnackbarHelper());

  static final _loadingService            = Provider<LoadingManager>((ref) => OverlayLoadingManager());

  /// Call this in your main.dart before runApp()
  static Future<void> init({ProviderContainer? container}) async {
    final prefs   = await SharedPreferences.getInstance();

    DI.container  = container ?? ProviderContainer(
      overrides: [_sharedPreferences.overrideWithValue(prefs)],
    );

    // Warm the token cache so the first API request doesn't pay the secure-storage read.
    await DI().storageService.getToken();
  }
}

extension DICoreServicesExtension on DI {
  StorageService      get storageService   => DI.container.read(DI._storageService);
  SnackbarHelper      get snackBarHelper   => DI.container.read(DI._snackBarHelper);
  LoadingManager      get loadingService   => DI.container.read(DI._loadingService);
}

extension DIUseCasesExtension on DI {
  RequestOtpUseCase     get requestOtpUseCase     => RequestOtpUseCase(DI.container.read(DI._authRepository));
  VerifyOtpUseCase      get verifyOtpUseCase      => VerifyOtpUseCase(DI.container.read(DI._authRepository));
  GetMeUseCase          get getMeUseCase          => GetMeUseCase(DI.container.read(DI._authRepository));
  LogoutUseCase         get logoutUseCase         => LogoutUseCase(DI.container.read(DI._authRepository));
  RegisterDeviceUseCase get registerDeviceUseCase => RegisterDeviceUseCase(DI.container.read(DI._authRepository));
}

// dart format on
