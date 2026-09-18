import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/utils/snackbar_helper.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/presentation/res/translations_manager.dart';

/// The customer's cart. Lines live client-side (the backend validates and
/// prices them at checkout); single-branch per order is a v1 rule.
class CartState extends Equatable {
  final List<CartLine> lines;

  const CartState({this.lines = const []});

  CartState copyWith({List<CartLine>? lines}) =>
      CartState(lines: lines ?? this.lines);

  bool get isEmpty => lines.isEmpty;

  int? get cartBranchId => lines.isEmpty ? null : lines.first.product?.branchId;

  /// Distinct products, not kilos: a line is one item however much it weighs.
  int get itemsCount => lines.length;

  /// Gross products total — discounts are shown on their own row.
  int get subtotalHalalas =>
      lines.fold(0, (sum, l) => sum + l.lineSubtotalHalalas);

  int get discountHalalas =>
      lines.fold(0, (sum, l) => sum + l.lineDiscountHalalas);

  double quantityOf(int branchItemId) => lines
      .firstWhere(
        (l) => l.branchItemId == branchItemId,
        orElse: () => const CartLine(branchItemId: 0, quantity: 0),
      )
      .quantity;

  @override
  List<Object?> get props => [lines];
}

class CartNotifier extends Notifier<CartState> {
  DateTime? _lastStockToastAt;

  @override
  CartState build() => const CartState();

  /// One stock toast per burst of taps, not one per tap.
  void notifyStockLimit() {
    final now = DateTime.now();
    final last = _lastStockToastAt;
    if (last != null && now.difference(last).inMilliseconds < 2500) return;
    _lastStockToastAt = now;
    DI().snackBarHelper.showMessage(
      Translation.stock_limit_reached.tr,
      ErrorMessage.snackBar,
    );
  }

  /// Sets a product's quantity, clamped to its live stock; zero removes the
  /// line. Returns the quantity actually applied.
  double setQuantity(BranchProduct product, double quantity) {
    if (quantity <= 0) {
      removeLine(product.id);
      return 0;
    }

    var applied = quantity;
    if (quantity > product.available) {
      applied = product.available;
      notifyStockLimit();
      if (applied <= 0) {
        removeLine(product.id);
        return 0;
      }
    }

    final line = CartLine(
      branchItemId: product.id,
      quantity: applied,
      product: product,
    );
    final existing = state.lines.indexWhere(
      (l) => l.branchItemId == product.id,
    );
    final lines = [...state.lines];
    if (existing >= 0) {
      lines[existing] = line;
    } else {
      lines.add(line);
    }
    state = state.copyWith(lines: lines);
    return applied;
  }

  void clearAndAdd(BranchProduct product, double quantity) {
    clear();
    setQuantity(product, quantity);
  }

  void removeLine(int branchItemId) {
    state = state.copyWith(
      lines: state.lines.where((l) => l.branchItemId != branchItemId).toList(),
    );
  }

  /// Reconciles local lines against a validate response: refreshes prices and
  /// stock, clamps over-asks, and drops lines the branch no longer sells.
  /// Returns true when anything changed (the cart screen mentions it).
  bool applyValidation(CartValidationResult result) {
    var changed = false;
    final lines = <CartLine>[];

    for (final line in state.lines) {
      final remote = result.lines.where(
        (r) => r.branchItemId == line.branchItemId,
      );
      if (remote.isEmpty) continue;
      final r = remote.first;

      final stock = r.availableQuantity ?? 0;
      if (!r.available && stock <= 0) {
        changed = true;
        continue;
      }

      final quantity = line.quantity > stock ? stock : line.quantity;
      if (quantity != line.quantity) changed = true;

      final product = line.product;
      lines.add(
        CartLine(
          branchItemId: line.branchItemId,
          quantity: quantity,
          product: product == null
              ? null
              : product.copyWith(
                  priceHalalas: r.unitPriceHalalas ?? product.priceHalalas,
                  discountHalalas: r.discountHalalas ?? product.discountHalalas,
                  available: stock,
                ),
        ),
      );
    }

    state = state.copyWith(lines: lines);
    return changed;
  }

  void clear() => state = const CartState();
}

/// App-lifetime on purpose: the cart must survive navigation between home,
/// products, details and checkout. It resets on logout via [CartNotifier.clear].
final cartController = NotifierProvider<CartNotifier, CartState>(
  CartNotifier.new,
);
