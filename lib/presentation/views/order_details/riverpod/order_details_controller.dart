import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jar/app/utils/state_render.dart';

class OrderDetailsState extends Equatable {
  final ReqState reqState;
  final String errorMessage;
  const OrderDetailsState({
    this.reqState = ReqState.loading,
    this.errorMessage = "",
  });

  OrderDetailsState copyWith({ReqState? reqState, String? errorMessage}) {
    return OrderDetailsState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [reqState];
}

class OrderDetailsNotifier extends Notifier<OrderDetailsState> {
  @override
  OrderDetailsState build() {
    return const OrderDetailsState(
      reqState: ReqState.success,
    );
  }
}

final orderDetailsController =
    NotifierProvider.autoDispose<OrderDetailsNotifier, OrderDetailsState>(
      OrderDetailsNotifier.new,
    );
