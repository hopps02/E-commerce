import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/services/firebase_messeging_services.dart';
import 'package:for_u/app/services/session_service.dart';
import 'package:for_u/app/services/storage_services/secure_storage_service.dart';
import 'package:for_u/app/services/storage_services/shared_prefrences_service.dart';
import 'package:for_u/app/services/storage_services/storage_service.dart';
import 'package:for_u/app/utils/overlay_loading/overlay_loading_manager.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/data/network/api/auth_api.dart';
import 'package:for_u/data/network/api/captain_api.dart';
import 'package:for_u/data/network/api/cashier_api.dart';
import 'package:for_u/data/network/api/customer_api.dart';
import 'package:for_u/data/network/dio_factory.dart';
import 'package:for_u/data/repository/auth_repository_impl.dart';
import 'package:for_u/data/repository/captain_repository_impl.dart';
import 'package:for_u/data/repository/cashier_repository_impl.dart';
import 'package:for_u/data/repository/customer_repository_impl.dart';
import 'package:for_u/domain/repository/auth_repository.dart';
import 'package:for_u/domain/repository/captain_repository.dart';
import 'package:for_u/domain/repository/cashier_repository.dart';
import 'package:for_u/domain/repository/customer_repository.dart';
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
  static final _cashierApi                = Provider((ref) => CashierApi(ref.read(_dio)));
  static final _captainApi                = Provider((ref) => CaptainApi(ref.read(_dio)));
  static final _customerApi               = Provider((ref) => CustomerApi(ref.read(_dio)));
  // --- Domain & Data ---
  static final _authRepository            = Provider<AuthRepository>((ref) => AuthRepositoryImpl(ref.read(_authApi)));
  static final _cashierRepository         = Provider<CashierRepository>((ref) => CashierRepositoryImpl(ref.read(_cashierApi)));
  static final _captainRepository         = Provider<CaptainRepository>((ref) => CaptainRepositoryImpl(ref.read(_captainApi)));
  static final _customerRepository        = Provider<CustomerRepository>((ref) => CustomerRepositoryImpl(ref.read(_customerApi)));

  static final _sessionService            = Provider((ref) => SessionService(
                                              ref.read(_storageService),
                                              ref.read(_authRepository),
                                              () => FirebaseMessegingServices.instance.fcmToken,
                                            ));

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
  SessionService      get sessionService   => DI.container.read(DI._sessionService);
  SnackbarHelper      get snackBarHelper   => DI.container.read(DI._snackBarHelper);
  LoadingManager      get loadingService   => DI.container.read(DI._loadingService);
  CashierRepository   get cashierRepository=> DI.container.read(DI._cashierRepository);
  CaptainRepository   get captainRepository=> DI.container.read(DI._captainRepository);
  CustomerRepository  get customerRepository=> DI.container.read(DI._customerRepository);
}

extension DIUseCasesExtension on DI {
  RequestOtpUseCase     get requestOtpUseCase     => RequestOtpUseCase(DI.container.read(DI._authRepository));
  VerifyOtpUseCase      get verifyOtpUseCase      => VerifyOtpUseCase(DI.container.read(DI._authRepository));
  GetMeUseCase          get getMeUseCase          => GetMeUseCase(DI.container.read(DI._authRepository));
  LogoutUseCase         get logoutUseCase         => LogoutUseCase(DI.container.read(DI._authRepository));
  RegisterDeviceUseCase get registerDeviceUseCase => RegisterDeviceUseCase(DI.container.read(DI._authRepository));
}

// dart format on
