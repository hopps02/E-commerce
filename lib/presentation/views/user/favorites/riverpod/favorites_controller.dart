import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/extensions/failure_display_extension.dart';
import 'package:store/app/ui_kit/indicators/state_render.dart';
import 'package:store/app/utils/snackbar_helper.dart';
import 'package:store/data/response/customer/catalog_response.dart';

class FavoritesState extends Equatable {
  final ReqState reqState;
  final String errorMessage;

  /// The full favorited list (for the favorites screen).
  final List<BranchProduct> products;

  /// Canonical membership used by hearts across the app.
  final Set<int> ids;

  const FavoritesState({
    this.reqState = ReqState.loading,
    this.errorMessage = '',
    this.products = const [],
    this.ids = const {},
  });

  FavoritesState copyWith({
    ReqState? reqState,
    String? errorMessage,
    List<BranchProduct>? products,
    Set<int>? ids,
  }) {
    return FavoritesState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
      products: products ?? this.products,
      ids: ids ?? this.ids,
    );
  }

  bool contains(int id) => ids.contains(id);

  /// List-screen state for a given products list: a non-empty list is success;
  /// an empty list stays "loading" only while a fetch is in flight, else empty.
  ReqState _reqStateForList(List<BranchProduct> products) {
    if (products.isNotEmpty) return ReqState.success;
    return reqState == ReqState.loading ? ReqState.loading : ReqState.empty;
  }

  /// The optimistic result of toggling [product]'s favorite membership: updates
  /// the heart set AND the list (insert on add, drop on remove) together so the
  /// two never diverge.
  FavoritesState optimisticToggle(BranchProduct product) {
    final id = product.id;
    final wasFavorite = ids.contains(id);
    final nextIds = {...ids};
    final nextProducts = [...products];
    if (wasFavorite) {
      nextIds.remove(id);
      nextProducts.removeWhere((p) => p.id == id);
    } else {
      nextIds.add(id);
      if (nextProducts.every((p) => p.id != id)) {
        nextProducts.insert(0, product.copyWith(isFavorite: true));
      }
    }
    return copyWith(
      ids: nextIds,
      products: nextProducts,
      reqState: _reqStateForList(nextProducts),
    );
  }

  /// Reverses an optimistic [optimisticToggle] of [product] against the CURRENT
  /// state (full rollback of BOTH the id set and the list), so a failed sync
  /// rolls back cleanly even if other toggles happened in the meantime.
  /// [wasFavorite] is the membership that existed BEFORE the optimistic change.
  FavoritesState rollbackToggle(BranchProduct product, bool wasFavorite) {
    final id = product.id;
    final nextIds = {...ids};
    final nextProducts = [...products];
    if (wasFavorite) {
      // The optimistic op removed it -> put it back.
      nextIds.add(id);
      if (nextProducts.every((p) => p.id != id)) {
        nextProducts.insert(0, product.copyWith(isFavorite: true));
      }
    } else {
      // The optimistic op added it -> take it out.
      nextIds.remove(id);
      nextProducts.removeWhere((p) => p.id == id);
    }
    return copyWith(
      ids: nextIds,
      products: nextProducts,
      reqState: _reqStateForList(nextProducts),
    );
  }

  @override
  List<Object?> get props => [reqState, errorMessage, products, ids];
}

/// App-lifetime: the favorite hearts on home/products/search/details and the
/// favorites screen all read this one membership set. Toggling is optimistic
/// and reconciles with the backend.
class FavoritesNotifier extends Notifier<FavoritesState> {
  /// Products with a favorite sync in flight — guards against rapid same-product
  /// taps racing their responses into an inconsistent state.
  final Set<int> _pending = {};

  @override
  FavoritesState build() => const FavoritesState();

  /// Seeds membership from a freshly loaded product list (the API returns
  /// is_favorite per item). For each product IN the list, the heart is set to
  /// match is_favorite — so a product un-favorited elsewhere stops showing a
  /// stale filled heart. Products not in the list are left untouched, and a
  /// product whose toggle is still in flight is skipped so we don't clobber it.
  void seedFrom(List<BranchProduct> products) {
    if (products.isEmpty) return;
    final next = {...state.ids};
    for (final p in products) {
      if (_pending.contains(p.id)) continue;
      p.isFavorite ? next.add(p.id) : next.remove(p.id);
    }
    state = state.copyWith(ids: next);
  }

  /// Loads the full favorites list for the favorites screen.
  Future<void> load() async {
    state = state.copyWith(reqState: ReqState.loading);
    final result = await DI().getFavoritesUseCase.execute(null);
    result.fold(
      (failure) => state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: failure.displayMessage,
      ),
      (products) => state = state.copyWith(
        reqState: products.isEmpty ? ReqState.empty : ReqState.success,
        products: products,
        ids: products.map((p) => p.id).toSet(),
      ),
    );
  }

  /// Optimistically toggles the heart and the list together, then syncs the
  /// backend; on failure rolls BOTH back (the heart and the list row).
  /// Serialized per product: a tap is ignored while that product's previous
  /// request is still in flight, so responses can't land out of order.
  Future<void> toggle(BranchProduct product) async {
    final id = product.id;
    if (_pending.contains(id)) return;
    _pending.add(id);

    final wasFavorite = state.ids.contains(id);
    state = state.optimisticToggle(product);

    try {
      final result = wasFavorite
          ? await DI().removeFavoriteUseCase.execute(id)
          : await DI().addFavoriteUseCase.execute(id);
      result.fold((failure) {
        state = state.rollbackToggle(product, wasFavorite);
        DI().snackBarHelper.showMessage(
          failure.displayMessage,
          ErrorMessage.snackBar,
        );
      }, (_) {});
    } finally {
      _pending.remove(id);
    }
  }

  void clear() => state = const FavoritesState();
}

final favoritesController = NotifierProvider<FavoritesNotifier, FavoritesState>(
  FavoritesNotifier.new,
);
