import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/presentation/views/user/cart/riverpod/cart_controller.dart';

void main() {
  const banana = BranchProduct(
    id: 6,
    branchId: 1,
    nameAr: 'موز - كجم',
    priceHalalas: 700,
    discountHalalas: 0,
    available: 3,
  );

  const eggs = BranchProduct(
    id: 11,
    branchId: 1,
    nameAr: 'بيض بلدي - طبق',
    priceHalalas: 1500,
    discountHalalas: 200,
    available: 18,
  );

  late ProviderContainer container;
  late CartNotifier cart;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
    cart = container.read(cartController.notifier);
  });

  CartState state() => container.read(cartController);

  test('setQuantity adds, updates and removes lines', () {
    cart.setQuantity(banana, 2);
    cart.setQuantity(eggs, 1);
    expect(state().lines, hasLength(2));
    expect(state().quantityOf(6), 2);
    expect(state().itemsCount, 3);

    cart.setQuantity(banana, 1);
    expect(state().quantityOf(6), 1);

    cart.setQuantity(banana, 0);
    expect(state().quantityOf(6), 0);
    expect(state().lines, hasLength(1));
  });

  test('totals sum gross subtotal and discounts separately', () {
    cart.setQuantity(banana, 2); // 1400, no discount
    cart.setQuantity(eggs, 1); // 1500 gross, 200 discount
    expect(state().subtotalHalalas, 2900);
    expect(state().discountHalalas, 200);
  });

  test('applyValidation refreshes prices and clamps to live stock', () {
    cart.setQuantity(banana, 3);
    cart.setQuantity(eggs, 2);

    final changed = cart.applyValidation(
      const CartValidationResult(
        branchId: 1,
        allAvailable: false,
        lines: [
          // Banana stock dropped to 1 -> clamp 3 down to 1.
          CartValidationLine(
            branchItemId: 6,
            quantity: 3,
            available: false,
            reason: 'insufficient_stock',
            unitPriceHalalas: 700,
            discountHalalas: 0,
            availableQuantity: 1,
          ),
          // Eggs got repriced server-side.
          CartValidationLine(
            branchItemId: 11,
            quantity: 2,
            available: true,
            reason: 'ok',
            unitPriceHalalas: 1600,
            discountHalalas: 100,
            availableQuantity: 18,
          ),
        ],
      ),
    );

    expect(changed, isTrue);
    expect(state().quantityOf(6), 1);
    expect(state().lines.first.product?.priceHalalas, 700);
    final eggsLine = state().lines.last;
    expect(eggsLine.product?.priceHalalas, 1600);
    expect(eggsLine.product?.discountHalalas, 100);
  });

  test('applyValidation drops lines the branch no longer sells', () {
    cart.setQuantity(banana, 1);

    final changed = cart.applyValidation(
      const CartValidationResult(
        branchId: 1,
        allAvailable: false,
        lines: [
          CartValidationLine(
            branchItemId: 6,
            quantity: 1,
            available: false,
            reason: 'inactive',
            availableQuantity: 0,
          ),
        ],
      ),
    );

    expect(changed, isTrue);
    expect(state().isEmpty, isTrue);
  });

  test('applyValidation reports no change for a clean cart', () {
    cart.setQuantity(eggs, 1);

    final changed = cart.applyValidation(
      const CartValidationResult(
        branchId: 1,
        allAvailable: true,
        lines: [
          CartValidationLine(
            branchItemId: 11,
            quantity: 1,
            available: true,
            reason: 'ok',
            unitPriceHalalas: 1500,
            discountHalalas: 200,
            availableQuantity: 18,
          ),
        ],
      ),
    );

    expect(changed, isFalse);
    expect(state().quantityOf(11), 1);
  });

  test('clear empties the cart', () {
    cart.setQuantity(banana, 1);
    cart.clear();
    expect(state().isEmpty, isTrue);
    expect(state().subtotalHalalas, 0);
  });
}
