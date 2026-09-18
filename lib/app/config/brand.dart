import 'package:flutter/material.dart';
import 'package:store/data/response/customer/branding_response.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/sizes_manager.dart';

/// The store's identity, in one place. The panel sends a handful of colours;
/// this is what turns them into the whole palette the screens paint with, so
/// no screen ever carries a brand colour of its own.
///
/// It is applied once before the first frame from what was cached, and again
/// when the live values arrive.
abstract class Brand {
  static Branding current = const Branding();

  /// The family the text styles ask for. It becomes the uploaded font's name
  /// only once that file is actually loaded, never before.
  static String fontFamily = FontsM.ibmPlexSansArabic.name;

  /// The store's logo, when the panel uploaded one.
  static String? logoUrl;

  /// Where the palette's light steps sit between white and the brand colour,
  /// and the dark ones between it and black. The numbers are the ones the app
  /// shipped with, so the original purple comes out of them unchanged.
  static const List<double> _tints = [0.10, 0.20, 0.38, 0.56, 0.78];
  static const List<double> _shades = [0.12, 0.24, 0.38, 0.52, 0.66];

  static void apply(Branding branding) {
    current = branding;

    final primary = _parse(branding.primary, ColorM.primary);
    final secondary = _parse(branding.secondary, ColorM.secondary);
    final success = _parse(branding.success, ColorM.greenSecondary);
    final warning = _parse(branding.warning, ColorM.orange);
    final danger = _parse(branding.danger, ColorM.red);
    final accent = _parse(branding.accent, ColorM.gold);

    ColorM.primary = primary;
    ColorM.primary500 = primary;
    ColorM.primary50 = _tint(primary, _tints[0]);
    ColorM.primary100 = _tint(primary, _tints[1]);
    ColorM.primary200 = _tint(primary, _tints[2]);
    ColorM.primary300 = _tint(primary, _tints[3]);
    ColorM.primary400 = _tint(primary, _tints[4]);
    ColorM.primary550 = _shade(primary, _shades[0]);
    ColorM.primary600 = _shade(primary, _shades[1]);
    ColorM.primary700 = _shade(primary, _shades[2]);
    ColorM.primary800 = _shade(primary, _shades[3]);
    ColorM.primary900 = _shade(primary, _shades[4]);
    ColorM.lightPrimary = _tint(primary, 0.07);

    ColorM.secondary = secondary;
    ColorM.greenSecondary = success;
    ColorM.greenPrimary = _shade(success, 0.60);
    ColorM.lightGreen = _tint(success, 0.10);
    ColorM.orange = warning;
    ColorM.red = danger;
    ColorM.gold = accent;

    SizeM.commonBorderRadius = branding.radius.toDouble();
    logoUrl = (branding.logoUrl ?? '').isEmpty ? null : branding.logoUrl;
  }

  /// The font family goes through here so a font that failed to download
  /// leaves the bundled one in place instead of nothing at all.
  static void useFont(String family) => fontFamily = family;

  static Color _tint(Color base, double amount) =>
      Color.lerp(Colors.white, base, amount) ?? base;

  static Color _shade(Color base, double amount) =>
      Color.lerp(base, Colors.black, amount) ?? base;

  /// "#5130EC" as a colour. Anything else keeps what the app already had.
  static Color _parse(String hex, Color fallback) {
    final digits = hex.replaceAll('#', '').trim();
    if (digits.length != 6) return fallback;

    final value = int.tryParse(digits, radix: 16);
    return value == null ? fallback : Color(0xFF000000 | value);
  }
}
