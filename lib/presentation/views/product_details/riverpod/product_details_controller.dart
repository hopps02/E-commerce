import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jar/app/utils/state_render.dart';

class ProductDetailsState extends Equatable {
  final ReqState reqState;
  final String errorMessage;
  final int selectedWeightIndex;
  const ProductDetailsState({
    this.reqState = ReqState.loading,
    this.errorMessage = "",
    this.selectedWeightIndex = 0,
  });

  ProductDetailsState copyWith({
    ReqState? reqState,
    String? errorMessage,
    int? selectedWeightIndex,
    bool? isFavorite,
    int? quantity,
  }) {
    return ProductDetailsState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedWeightIndex: selectedWeightIndex ?? this.selectedWeightIndex,
    );
  }

  @override
  List<Object?> get props => [
    reqState,
    errorMessage,
    selectedWeightIndex,
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

}

final productDetailsController = NotifierProvider.autoDispose<
  ProductDetailsNotifier,
  ProductDetailsState
>(ProductDetailsNotifier.new);
