import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jar/app/utils/state_render.dart';



class CartState {
  final ReqState reqState;
  final String errorMessage;

  const CartState({
    this.reqState = ReqState.loading,
    this.errorMessage = "",
  });

  CartState copyWith({
    ReqState? reqState,
    String? errorMessage,
  }) {
    return CartState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class CartController extends Notifier<CartState> {
  @override
  CartState build() {
    return const CartState(
      reqState: ReqState.success,
    );
  }


}

final cartController = NotifierProvider.autoDispose<CartController, CartState>(
  CartController.new,
);
