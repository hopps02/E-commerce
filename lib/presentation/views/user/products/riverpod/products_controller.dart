import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductsState extends Equatable {
  final ReqState reqState;
  final String errorMessage;
  const ProductsState({
    this.reqState = ReqState.loading,
    this.errorMessage = "",
  });

  ProductsState copyWith({ReqState? reqState, String? errorMessage}) {
    return ProductsState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [reqState, errorMessage];
}

class ProductsNotifier extends Notifier<ProductsState> {
  final RefreshController refreshController = RefreshController();
  @override
  ProductsState build() {
    ref.onDispose(() {
      refreshController.dispose();
    });
    return const ProductsState();
  }
}

final productsController =
    NotifierProvider.autoDispose<ProductsNotifier, ProductsState>(
      ProductsNotifier.new,
    );
