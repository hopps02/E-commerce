import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/extensions/failure_display_extension.dart';
import 'package:store/app/ui_kit/indicators/state_render.dart';
import 'package:store/data/response/customer/catalog_response.dart';

class ProductDetailsState extends Equatable {
  final ReqState reqState;
  final String errorMessage;
  final BranchProduct? product;
  final bool isFavorite;

  const ProductDetailsState({
    this.reqState = ReqState.loading,
    this.errorMessage = "",
    this.product,
    this.isFavorite = false,
  });

  ProductDetailsState copyWith({
    ReqState? reqState,
    String? errorMessage,
    BranchProduct? product,
    bool? isFavorite,
  }) {
    return ProductDetailsState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
      product: product ?? this.product,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [reqState, errorMessage, product, isFavorite];
}

class ProductDetailsNotifier extends Notifier<ProductDetailsState> {
  @override
  ProductDetailsState build() {
    return const ProductDetailsState();
  }

  /// Shows the list row instantly when provided, then refreshes from the
  /// backend so price/stock are live.
  Future<void> load(int productId, {BranchProduct? initial}) async {
    state = initial != null
        ? ProductDetailsState(reqState: ReqState.success, product: initial)
        : const ProductDetailsState();

    final result = await DI().getProductDetailUseCase.execute(productId);
    result.fold(
      (failure) {
        // Keep showing the passed-in row; only a cold open surfaces the error.
        if (state.product == null) {
          state = state.copyWith(
            reqState: ReqState.error,
            errorMessage: failure.displayMessage,
          );
        }
      },
      (product) => state = state.copyWith(
        reqState: ReqState.success,
        product: product,
      ),
    );
  }

  /// Switching to another size stays on the same screen: everything the
  /// sizes share is already on it, and the row behind them arrived with
  /// the product, so nothing is fetched again.
  void chooseVariant(int branchItemId) {
    final product = state.product;
    if (product == null || product.id == branchItemId) return;

    state = state.copyWith(product: product.withVariant(branchItemId));
  }

  void toggleFavorite() {
    state = state.copyWith(isFavorite: !state.isFavorite);
  }
}

final productDetailsController =
    NotifierProvider.autoDispose<ProductDetailsNotifier, ProductDetailsState>(
      ProductDetailsNotifier.new,
    );
