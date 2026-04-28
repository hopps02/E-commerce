import 'package:jar/app/utils/overlay_loading/overlay_loading_manager.dart';
import 'package:jar/app/utils/snackbar_helper.dart';
import 'package:jar/app/utils/overlay_loading/overlay_loading.dart';
import 'package:jar/domain/usecase/auth_init_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jar/data/network/api.dart';
import 'package:jar/data/network/dio_factory.dart';
import 'package:jar/data/repository/repository_impl.dart';

import 'package:jar/app/services/storage_services/secure_storage_service.dart';
import 'package:jar/app/services/storage_services/shared_prefrences_service.dart';
import 'package:jar/app/services/storage_services/storage_service.dart';

class DI {
  static late final ProviderContainer container;
  // --- Core Infrastructure ---
  static final _sharedPreferences = Provider<SharedPreferences>((ref) {
    throw UnimplementedError("Initialize SharedPreferences in DI.init()");
  });
  static final _secureStorage = Provider((ref) => SecureStorageService());
  static final _sharedPrefsService = Provider((ref) {
    return SharedPrefsService(ref.watch(_sharedPreferences));
  });
  static final _storageService = Provider((ref) {
    return StorageService(
      ref.watch(_secureStorage),
      ref.watch(_sharedPrefsService),
    );
  });
  // --- Network ---
  static final _dioFactory = Provider(
    (ref) => DioFactory(ref.watch(_storageService)),
  );
  static final _appServices = Provider(
    (ref) => AppServices(ref.watch(_dioFactory)),
  );
  // --- Domain & Data ---
  static final _repository = Provider(
    (ref) => Repository(ref.watch(_appServices)),
  );

  // --- snack bar Helper
  static final _snackBarHelper = Provider((ref) => SnackbarHelper());
  static final _loadingService = Provider<LoadingManager>(
    (ref) => OverlayLoadingManager(),
  );
  // --- Use Cases ---
  static final _authInitUseCase = Provider.autoDispose((ref) {
    return AuthInitUseCase(ref.watch(_repository));
  });

  /// Call this in your main.dart before runApp()
  static Future<void> init({ProviderContainer? container}) async {
    final prefs = await SharedPreferences.getInstance();

    DI.container =
        container ??
        ProviderContainer(
          overrides: [_sharedPreferences.overrideWithValue(prefs)],
        );
  }
}

extension ProviderContainerExtension on DI {
  StorageService get storageService => DI.container.read(DI._storageService);
  AuthInitUseCase get authInitUseCase => DI.container.read(DI._authInitUseCase);
  SnackbarHelper get snackBarHelper => DI.container.read(DI._snackBarHelper);
  LoadingManager get loadingService => DI.container.read(DI._loadingService);
}
