import 'package:flutter_test/flutter_test.dart';
import 'package:for_u/app/validation/phone_validation.dart';

void main() {
  group('validatePhoneNumber', () {
    test(
      'returns EmptyPhone for blank input without calling the parser',
      () async {
        var parserCalled = false;
        final result = await validatePhoneNumber(
          dialCode: '+966',
          number: '   ',
          parse: (_) async {
            parserCalled = true;
            return {};
          },
        );

        expect(result, isA<EmptyPhone>());
        expect(parserCalled, isFalse);
      },
    );

    test('returns ValidPhone with the e164 from the parser', () async {
      final result = await validatePhoneNumber(
        dialCode: '+966',
        number: '512345678',
        parse: (_) async => {'e164': '+966512345678'},
      );

      expect(result, isA<ValidPhone>());
      expect((result as ValidPhone).e164, '+966512345678');
    });

    test(
      'passes the combined, whitespace-stripped number to the parser',
      () async {
        late String received;
        await validatePhoneNumber(
          dialCode: '+966',
          number: ' 51 234 5678 ',
          parse: (phone) async {
            received = phone;
            return {'e164': '+966512345678'};
          },
        );

        expect(received, '+966512345678');
      },
    );

    test(
      'falls back to the raw combined number when e164 is missing',
      () async {
        final result = await validatePhoneNumber(
          dialCode: '+1',
          number: '5551234567',
          parse: (_) async => {},
        );

        expect((result as ValidPhone).e164, '+15551234567');
      },
    );

    test('returns InvalidPhone when the parser throws', () async {
      final result = await validatePhoneNumber(
        dialCode: '+966',
        number: '123',
        parse: (_) async => throw const FormatException('bad number'),
      );

      expect(result, isA<InvalidPhone>());
    });
  });
}
