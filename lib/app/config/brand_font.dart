import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart' show FontLoader;
import 'package:path_provider/path_provider.dart';
import 'package:store/app/config/env.dart';
import 'package:store/app/utils/logger/app_logger.dart';

/// The font the panel uploaded. It is downloaded once, kept next to the app's
/// own data, and registered under one family name — so the theme can name that
/// family without caring which file is behind it today.
abstract class BrandFont {
  static const String family = 'BrandFont';

  /// The URL already registered, so a second call costs nothing.
  static String? _loaded;

  /// The font this device already has. Startup calls this one, so a slow
  /// network never holds up the first frame.
  static Future<bool> loadCached(String url) => _register(url, download: false);

  /// Returns true only when the font is actually usable; a font that will not
  /// download is not worth a screen with no text on it.
  static Future<bool> load(String url) => _register(url, download: true);

  static Future<bool> _register(String url, {required bool download}) async {
    if (url.isEmpty) return false;
    if (_loaded == url) return true;

    try {
      final bytes = await _bytes(url, download: download);
      if (bytes == null || bytes.isEmpty) return false;

      await (FontLoader(family)
            ..addFont(Future.value(ByteData.sublistView(bytes))))
          .load();

      _loaded = url;
      return true;
    } catch (error) {
      AppLogger.instance.w('The store font did not load: $error');
      return false;
    }
  }

  /// The file from disk when it was fetched before, otherwise from the store.
  static Future<Uint8List?> _bytes(String url, {required bool download}) async {
    final cached = await _file(url);

    if (cached != null && cached.existsSync()) {
      final bytes = await cached.readAsBytes();
      if (bytes.isNotEmpty) return bytes;
    }

    if (!download) return null;

    final response = await Dio().get<List<int>>(
      _absolute(url),
      options: Options(responseType: ResponseType.bytes),
    );
    final data = response.data;
    if (data == null) return null;

    final bytes = Uint8List.fromList(data);
    if (cached != null) await cached.writeAsBytes(bytes, flush: true);

    return bytes;
  }

  /// Where the font lives between runs. The web has no such place, so there it
  /// is fetched each time and the browser's own cache does the work.
  static Future<File?> _file(String url) async {
    if (kIsWeb) return null;

    try {
      final directory = await getApplicationSupportDirectory();
      final name = url.hashCode.toUnsigned(32).toRadixString(16);

      return File('${directory.path}/brand-font-$name');
    } catch (_) {
      return null;
    }
  }

  /// The panel can hand back a path rather than a whole address, and that
  /// path belongs to whoever is serving the store.
  static String _absolute(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) return url;

    return Uri.parse(Env.baseUrl).replace(path: url, query: null).toString();
  }
}
