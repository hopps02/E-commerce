import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/presentation/views/user/favorites/riverpod/favorites_controller.dart';

void main() {
  const banana = BranchProduct(
    id: 6,
    branchId: 1,
    nameAr: 'موز',
    priceHalalas: 700,
    discountHalalas: 0,
    available: 3,
  );
  const eggs = BranchProduct(
    id: 11,
    branchId: 1,
    nameAr: 'بيض',
    priceHalalas: 1500,
    discountHalalas: 200,
    available: 18,
  );

  group('optimisticToggle', () {
    test('adding inserts the product + id and marks the list success', () {
      const state = FavoritesState(reqState: ReqState.empty);
      final next = state.optimisticToggle(banana);
      expect(next.ids, contains(6));
      expect(next.products.map((p) => p.id), contains(6));
      expect(next.products.first.isFavorite, isTrue);
      expect(next.reqState, ReqState.success);
    });

    test('removing drops both the id and the product row', () {
      const state = FavoritesState(
        reqState: ReqState.success,
        products: [banana],
        ids: {6},
      );
      final next = state.optimisticToggle(banana);
      expect(next.ids, isNot(contains(6)));
      expect(next.products, isEmpty);
      expect(next.reqState, ReqState.empty);
    });
  });

  group('rollbackToggle — full rollback (the bug being fixed)', () {
    test('failed ADD rolls back BOTH the id and the inserted product', () {
      const original = FavoritesState(reqState: ReqState.empty);
      final optimistic = original.optimisticToggle(banana); // heart added + row inserted
      final rolledBack = optimistic.rollbackToggle(banana, false);

      expect(rolledBack.ids, isNot(contains(6)));
      // The old bug left this product in the list; it must be gone now.
      expect(rolledBack.products.map((p) => p.id), isNot(contains(6)));
      expect(rolledBack, original);
    });

    test('failed REMOVE rolls back BOTH the id and the removed product row', () {
      const original = FavoritesState(
        reqState: ReqState.success,
        products: [banana],
        ids: {6},
      );
      final optimistic = original.optimisticToggle(banana); // heart + row removed
      final rolledBack = optimistic.rollbackToggle(banana, true);

      expect(rolledBack.ids, contains(6));
      expect(rolledBack.products.map((p) => p.id), contains(6));
      expect(rolledBack.reqState, ReqState.success);
    });

    test('rollback reverses only its own op — a concurrent toggle survives', () {
      const s0 = FavoritesState(reqState: ReqState.empty);
      final addA = s0.optimisticToggle(banana); // +banana
      final addB = addA.optimisticToggle(eggs); // +banana +eggs
      final rollbackA = addB.rollbackToggle(banana, false); // banana sync failed

      expect(rollbackA.ids, isNot(contains(6))); // banana gone
      expect(rollbackA.ids, contains(11)); // eggs kept
      expect(rollbackA.products.map((p) => p.id), contains(11));
      expect(rollbackA.products.map((p) => p.id), isNot(contains(6)));
    });
  });

  group('seedFrom reconciliation', () {
    test('sets hearts to match is_favorite for products in the list', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(favoritesController.notifier);

      notifier.seedFrom([banana.copyWith(isFavorite: true)]);
      expect(container.read(favoritesController).ids, {6});

      // The same product now comes back not-favorited -> the stale heart clears.
      notifier.seedFrom([banana.copyWith(isFavorite: false)]);
      expect(container.read(favoritesController).ids, isEmpty);
    });

    test('leaves ids for products not present in the passed list', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final notifier = container.read(favoritesController.notifier);

      notifier.seedFrom([
        banana.copyWith(isFavorite: true),
        eggs.copyWith(isFavorite: true),
      ]);
      expect(container.read(favoritesController).ids, {6, 11});

      // A partial list (only banana) must not drop eggs' heart.
      notifier.seedFrom([banana.copyWith(isFavorite: false)]);
      expect(container.read(favoritesController).ids, {11});
    });
  });
}
