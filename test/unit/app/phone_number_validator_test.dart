import 'package:flutter_test/flutter_test.dart';
import 'package:jar/app/validation/phone_number_validator.dart';

void main() {
  group('Country', () {
    test('isValidLength returns true within range', () {
      final c = Country('Test', 'TS', '+999', 7, 9);
      expect(c.isValidLength(7), isTrue);
      expect(c.isValidLength(8), isTrue);
      expect(c.isValidLength(9), isTrue);
    });

    test('isValidLength returns false outside range', () {
      final c = Country('Test', 'TS', '+999', 7, 9);
      expect(c.isValidLength(6), isFalse);
      expect(c.isValidLength(10), isFalse);
    });

    test('equality is based on isoCode', () {
      final a = Country('A', 'XX', '+1', 10, 10);
      final b = Country('B', 'XX', '+2', 5, 5);
      expect(a, equals(b));
    });
  });

  group('CountryUtils.normalizePhoneNumber', () {
    test('strips spaces, dashes and parens', () {
      expect(
        CountryUtils.normalizePhoneNumber('+1 (555) 123-4567'),
        '+15551234567',
      );
    });

    test('keeps the leading +', () {
      expect(CountryUtils.normalizePhoneNumber('+44 20 7946 0958'),
          '+442079460958');
    });
  });

  group('CountryUtils.formatE164', () {
    test('produces +<code><digits>', () {
      expect(CountryUtils.formatE164('+1', '555-123-4567'), '+15551234567');
    });

    test('adds + if missing in code', () {
      expect(CountryUtils.formatE164('1', '5551234567'), '+15551234567');
    });
  });

  group('CountryUtils.getCountryByIsoCode', () {
    test('returns country for valid ISO code (case-insensitive)', () {
      final c = CountryUtils.getCountryByIsoCode('eg');
      expect(c, isNotNull);
      expect(c!.dialCode, '+20');
    });

    test('returns null for unknown ISO code', () {
      expect(CountryUtils.getCountryByIsoCode('ZZ'), isNull);
    });
  });

  group('CountryUtils.validatePhoneNumberByCountry', () {
    test('Egypt mobile starting with 1 of length 10 is valid', () {
      final egypt = CountryUtils.getCountryByIsoCode('EG')!;
      expect(
        CountryUtils.validatePhoneNumberByCountry('1012345678', egypt),
        isTrue,
      );
    });

    test('Egypt number not starting with 1 is invalid', () {
      final egypt = CountryUtils.getCountryByIsoCode('EG')!;
      expect(
        CountryUtils.validatePhoneNumberByCountry('2012345678', egypt),
        isFalse,
      );
    });

    test('wrong length is invalid', () {
      final egypt = CountryUtils.getCountryByIsoCode('EG')!;
      expect(
        CountryUtils.validatePhoneNumberByCountry('123', egypt),
        isFalse,
      );
    });
  });

  group('CountryUtils.validateFullPhoneNumber', () {
    test('valid US number passes', () {
      final result =
          CountryUtils.validateFullPhoneNumber('+1', '5551234567');
      expect(result.isValid, isTrue);
      expect(result.phoneNumber, isNotNull);
      expect(result.phoneNumber!.country.isoCode, isNotNull);
    });

    test('empty number is invalid', () {
      final result = CountryUtils.validateFullPhoneNumber('', '');
      expect(result.isValid, isFalse);
      expect(result.error, contains('empty'));
    });

    test('missing + prefix is invalid', () {
      final result =
          CountryUtils.validateFullPhoneNumber('1', '5551234567');
      expect(result.isValid, isFalse);
      expect(result.error, contains('+'));
    });

    test('unknown country code is invalid', () {
      final result =
          CountryUtils.validateFullPhoneNumber('+999999', '12345');
      expect(result.isValid, isFalse);
    });
  });

  group('PhoneNumber equality', () {
    test('same code + local number are equal', () {
      final country = CountryUtils.getCountryByIsoCode('US')!;
      final a = PhoneNumber(
        countryCode: '+1',
        localNumber: '5551234567',
        country: country,
      );
      final b = PhoneNumber(
        countryCode: '+1',
        localNumber: '5551234567',
        country: country,
      );
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });
  });
}
