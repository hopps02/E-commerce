import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jar/app/utils/state_render.dart';

class ProductDetailsState extends Equatable {
  final ReqState reqState;
  final String errorMessage;
  final int selectedWeightIndex;
  final int quantity;
  final bool isFavorite;

  const ProductDetailsState({
    this.reqState = ReqState.loading,
    this.errorMessage = "",
    this.selectedWeightIndex = 0,
    this.quantity = 0,
    this.isFavorite = false,
  });

  ProductDetailsState copyWith({
    ReqState? reqState,
    String? errorMessage,
    int? selectedWeightIndex,
    int? quantity,
    bool? isFavorite,
  }) {
    return ProductDetailsState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedWeightIndex: selectedWeightIndex ?? this.selectedWeightIndex,
      quantity: quantity ?? this.quantity,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        reqState,
        errorMessage,
        selectedWeightIndex,
        quantity,
        isFavorite,
      ];
}

class ProductDetailsNotifier extends Notifier<ProductDetailsState> {
  @override
  ProductDetailsState build() {
    return const ProductDetailsState();
  }

  void selectWeight(int index) {
    state = state.copyWith(selectedWeightIndex: index);
  }

  void incrementQuantity() {
    state = state.copyWith(quantity: state.quantity + 1);
  }

  void decrementQuantity() {
    if (state.quantity > 0) {
      state = state.copyWith(quantity: state.quantity - 1);
    }
  }

  void toggleFavorite() {
    state = state.copyWith(isFavorite: !state.isFavorite);
  }
}

final productDetailsController =
    NotifierProvider.autoDispose<ProductDetailsNotifier, ProductDetailsState>(
        ProductDetailsNotifier.new);
