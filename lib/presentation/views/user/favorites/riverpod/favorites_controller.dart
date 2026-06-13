import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/data/models/customer/catalog_models.dart';

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

  @override
  List<Object?> get props => [reqState, errorMessage, products, ids];
}

/// App-lifetime: the favorite hearts on home/products/search/details and the
/// favorites screen all read this one membership set. Toggling is optimistic
/// and reconciles with the backend.
class FavoritesNotifier extends Notifier<FavoritesState> {
  @override
  FavoritesState build() => const FavoritesState();

  /// Seeds membership from a freshly loaded product list (the API returns
  /// is_favorite per item), so hearts are correct without a separate fetch.
  void seedFrom(List<BranchProduct> products) {
    final favored = products.where((p) => p.isFavorite).map((p) => p.id);
    if (favored.isEmpty) return;
    state = state.copyWith(ids: {...state.ids, ...favored});
  }

  /// Loads the full favorites list for the favorites screen.
  Future<void> load() async {
    state = state.copyWith(reqState: ReqState.loading);
    final result = await DI().customerRepository.favorites();
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

  /// Optimistically toggles the heart and syncs the backend; rolls back on
  /// failure. Keeps the favorites list in sync when removing.
  Future<void> toggle(BranchProduct product) async {
    final id = product.id;
    final wasFavorite = state.ids.contains(id);

    final nextIds = {...state.ids};
    final nextProducts = [...state.products];
    if (wasFavorite) {
      nextIds.remove(id);
      nextProducts.removeWhere((p) => p.id == id);
    } else {
      nextIds.add(id);
      if (nextProducts.every((p) => p.id != id)) {
        nextProducts.insert(0, product.copyWith(isFavorite: true));
      }
    }
    state = state.copyWith(
      ids: nextIds,
      products: nextProducts,
      reqState: nextProducts.isEmpty && state.reqState != ReqState.loading
          ? ReqState.empty
          : (nextProducts.isEmpty ? state.reqState : ReqState.success),
    );

    final result = wasFavorite
        ? await DI().customerRepository.removeFavorite(id)
        : await DI().customerRepository.addFavorite(id);

    result.fold((failure) {
      // Roll back to the pre-toggle membership.
      final revertIds = {...state.ids};
      wasFavorite ? revertIds.add(id) : revertIds.remove(id);
      state = state.copyWith(ids: revertIds);
      DI().snackBarHelper.showMessage(
        failure.displayMessage,
        ErrorMessage.snackBar,
      );
    }, (_) {});
  }

  void clear() => state = const FavoritesState();
}

final favoritesController = NotifierProvider<FavoritesNotifier, FavoritesState>(
  FavoritesNotifier.new,
);
