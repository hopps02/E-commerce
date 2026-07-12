import 'package:flutter_test/flutter_test.dart';
import 'package:store/app/utils/money.dart';

void main() {
  group('Money.amount', () {
    // Boundary cases: zero, sub-riyal, exact riyal, single-digit fraction,
    // negative (discounts), large totals.
    test('zero', () => expect(Money.amount(0), '0.00'));

    test('sub-riyal amount keeps leading zero riyals', () {
      expect(Money.amount(50), '0.50');
    });

    test('exact riyals have .00 fraction', () {
      expect(Money.amount(1200), '12.00');
    });

    test('single-digit fraction is left-padded', () {
      expect(Money.amount(1205), '12.05');
    });

    test('typical price', () => expect(Money.amount(1250), '12.50'));

    test('negative amounts keep the sign with padded fraction', () {
      expect(Money.amount(-90), '-0.90');
      expect(Money.amount(-1205), '-12.05');
    });

    test('large order total has no precision drift', () {
      expect(Money.amount(123456789), '1234567.89');
    });
  });

  group('Money.format', () {
    test('arabic puts the symbol after the amount', () {
      expect(Money.format(3500, arabic: true), '35.00 ر.س');
    });

    test('english puts the code before the amount', () {
      expect(Money.format(3500, arabic: false), 'SAR 35.00');
    });
  });
}
