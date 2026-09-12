import 'package:url_launcher/url_launcher.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/utils/snackbar_helper.dart';
import 'package:store/presentation/res/translations_manager.dart';

/// Opens WhatsApp with an order already written out.
///
/// Delivery happens outside this system, so this is how an order reaches the
/// store. The server composes the whole message and hands the app a ready
/// wa.me link — nothing here decides what the message says.
class WhatsAppService {
  const WhatsAppService._();

  /// Returns true when WhatsApp (or the browser's WhatsApp Web) took over.
  static Future<bool> sendOrder(String url) async {
    if (url.trim().isEmpty) return false;

    final uri = Uri.tryParse(url);
    if (uri == null) return false;

    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (opened) return true;
    } catch (_) {
      // fall through to the message below
    }

    DI().snackBarHelper.showMessage(
      Translation.whatsapp_open_failed.tr,
      ErrorMessage.snackBar,
    );
    return false;
  }
}
