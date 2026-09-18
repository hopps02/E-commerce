import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/config/brand.dart';
import 'package:store/app/config/brand_font.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/utils/logger/app_logger.dart';
import 'package:store/data/response/customer/branding_response.dart';

/// The store's identity, kept where the app can repaint itself when it lands.
///
/// The first frame is already painted from what was cached at startup, so this
/// only matters when the panel has changed something: the new values are
/// applied, written to the cache for next time, and the state bumped so the
/// theme is rebuilt.
class BrandNotifier extends Notifier<Branding> {
  static const String cacheKey = 'branding';

  @override
  Branding build() => Brand.current;

  Future<void> refresh() async {
    try {
      final result = await DI().getBrandingUseCase.execute(null);

      await result.fold(
        // A store that cannot be reached keeps the colours it already has.
        (failure) async =>
            AppLogger.instance.w('The store identity did not arrive: ${failure.runtimeType}'),
        (branding) async {
          Brand.apply(branding);

          final url = branding.fontUrl ?? '';
          if (url.isNotEmpty && await BrandFont.load(url)) {
            Brand.useFont(BrandFont.family);
          }

          await DI().prefs.setMap(cacheKey, branding.toJson());
          state = branding;
        },
      );
    } catch (error, stack) {
      // The colours already on screen are good enough to shop with.
      AppLogger.instance.w(
        'The store identity could not be read',
        error: error,
        stackTrace: stack,
      );
    }
  }
}

final brandController = NotifierProvider<BrandNotifier, Branding>(
  BrandNotifier.new,
);
