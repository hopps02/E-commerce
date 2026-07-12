import 'package:flutter_test/flutter_test.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/presentation/views/user/cart/riverpod/checkout_controller.dart';

/// The fingerprint is the heart of quote invalidation: it must change for any
/// pricing-relevant edit (address, line set, or a line's quantity) and stay
/// stable otherwise, so a stale delivery fee / total is never shown as final.
void main() {
  const banana = CartLine(branchItemId: 6, quantity: 2);
  const eggs = CartLine(branchItemId: 11, quantity: 1);

  group('checkoutFingerprint', () {
    test('is stable for the same address + lines', () {
      expect(
        checkoutFingerprint(5, const [banana, eggs]),
        checkoutFingerprint(5, const [banana, eggs]),
      );
    });

    test('changes when a quantity changes', () {
      expect(
        checkoutFingerprint(5, const [banana]),
        isNot(
          checkoutFingerprint(5, const [CartLine(branchItemId: 6, quantity: 3)]),
        ),
      );
    });

    test('changes when a line is added', () {
      expect(
        checkoutFingerprint(5, const [banana]),
        isNot(checkoutFingerprint(5, const [banana, eggs])),
      );
    });

    test('changes when a line is removed', () {
      expect(
        checkoutFingerprint(5, const [banana, eggs]),
        isNot(checkoutFingerprint(5, const [banana])),
      );
    });

    test('changes when the address changes (delivery fee reprices per zone)', () {
      expect(
        checkoutFingerprint(5, const [banana]),
        isNot(checkoutFingerprint(7, const [banana])),
      );
    });
  });

  group('CheckoutState.matchesCart', () {
    test('is false before any quote (empty fingerprint)', () {
      const state = CheckoutState();
      expect(state.matchesCart(const [banana]), isFalse);
    });

    test('is true only for the exact quoted address + lines', () {
      final state = const CheckoutState().copyWith(
        addressId: 5,
        quotedFingerprint: checkoutFingerprint(5, const [banana]),
      );

      // Same cart that was quoted -> fresh.
      expect(state.matchesCart(const [banana]), isTrue);

      // Quantity edit -> stale (must re-quote).
      expect(
        state.matchesCart(const [CartLine(branchItemId: 6, quantity: 3)]),
        isFalse,
      );

      // Added line -> stale.
      expect(state.matchesCart(const [banana, eggs]), isFalse);

      // Removed all lines -> stale.
      expect(state.matchesCart(const []), isFalse);
    });
  });
}
