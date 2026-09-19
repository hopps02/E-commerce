import 'dart:ui' show Color;
import 'package:flutter_test/flutter_test.dart';
import 'package:store/app/config/brand.dart';
import 'package:store/data/response/customer/branding_response.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/radius_manager.dart';
import 'package:store/presentation/res/sizes_manager.dart';

void main() {
  setUp(() => Brand.apply(const Branding()));

  group('Brand.apply', () {
    test('the shipped identity comes back out unchanged', () {
      // The palette the app was drawn with, rebuilt from its own primary: the
      // store that never opens the branding page must look the same as before.
      expect(ColorM.primary.toARGB32(), 0xFF5130EC);
      expect(ColorM.primary50.toARGB32(), 0xFFEEEAFD);
      expect(ColorM.primary400.toARGB32(), 0xFF775EF0);
      expect(ColorM.primary900.toARGB32(), 0xFF1C1050);
      expect(ColorM.red.toARGB32(), 0xFFEF4444);
      expect(SizeM.commonBorderRadius, 16);
    });

    test('a new primary repaints its whole ladder, light and dark', () {
      Brand.apply(const Branding(primary: '#0E7C66'));

      expect(ColorM.primary.toARGB32(), 0xFF0E7C66);
      expect(ColorM.primary500.toARGB32(), 0xFF0E7C66);
      // The light steps sit between white and the brand colour...
      expect(ColorM.primary50.computeLuminance(), greaterThan(ColorM.primary.computeLuminance()));
      expect(ColorM.primary100.computeLuminance(), lessThan(ColorM.primary50.computeLuminance()));
      // ...and the dark ones below it.
      expect(ColorM.primary700.computeLuminance(), lessThan(ColorM.primary.computeLuminance()));
      expect(ColorM.primary900.computeLuminance(), lessThan(ColorM.primary700.computeLuminance()));
    });

    test('the other roles are what the panel sent', () {
      Brand.apply(
        const Branding(
          secondary: '#334155',
          success: '#16A34A',
          warning: '#F59E0B',
          danger: '#DC2626',
          accent: '#A855F7',
          radius: 24,
        ),
      );

      expect(ColorM.secondary.toARGB32(), 0xFF334155);
      expect(ColorM.greenSecondary.toARGB32(), 0xFF16A34A);
      expect(ColorM.orange.toARGB32(), 0xFFF59E0B);
      expect(ColorM.red.toARGB32(), 0xFFDC2626);
      expect(ColorM.gold.toARGB32(), 0xFFA855F7);
      expect(SizeM.commonBorderRadius, 24);
    });

    test('something that is not a colour leaves the app as it was', () {
      Brand.apply(const Branding(primary: 'green', danger: '#12'));

      expect(ColorM.primary.toARGB32(), 0xFF5130EC);
      expect(ColorM.red.toARGB32(), 0xFFEF4444);
    });

    test('a logo that was never uploaded is nothing, not an empty string', () {
      Brand.apply(const Branding(logoUrl: ''));
      expect(Brand.logoUrl, isNull);

      Brand.apply(const Branding(logoUrl: 'https://shop.test/logo.png'));
      expect(Brand.logoUrl, 'https://shop.test/logo.png');
    });
  });

  group('the corners follow the store', () {
    test('one slider moves every step of the radius scale', () {
      Brand.apply(const Branding(radius: 24));

      expect(RadiusM.md, 24);
      expect(RadiusM.sm, 20);
      expect(RadiusM.xs, 16);
      expect(RadiusM.lg, 32);
      expect(RadiusM.xl, 40);
      // A pill is a pill whatever the store asks for.
      expect(RadiusM.pill, 9999);
    });

    test('square corners stay square all the way down', () {
      Brand.apply(const Branding(radius: 0));

      expect(RadiusM.md, 0);
      expect(RadiusM.sm, 0);
      expect(RadiusM.xs, 0);
    });
  });
}
