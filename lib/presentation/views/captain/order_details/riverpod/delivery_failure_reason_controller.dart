import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';

enum DeliveryFailureReason {
  customerNotAvailable,
  notAnsweringPhone,
  incorrectAddress,
  customerRefused,
  other,
}

class DeliveryFailureReasonState extends Equatable {
  /// Index of the picked reason among [DeliveryFailureReason.values].
  /// `null` until the user taps a row.
  final int? selectedIndex;
  final TextEditingController otherReasonController;
  final ReqState reqState;
  final String msgError;

  DeliveryFailureReasonState({
    this.selectedIndex,
    TextEditingController? otherReasonController,
    this.reqState = ReqState.loading,
    this.msgError = '',
  }) : otherReasonController = otherReasonController ?? TextEditingController();

  bool get isOtherSelected =>
      selectedIndex != null &&
      DeliveryFailureReason.values[selectedIndex!] ==
          DeliveryFailureReason.other;

  DeliveryFailureReasonState copyWith({
    int? selectedIndex,
    ReqState? reqState,
    String? msgError,
  }) {
    return DeliveryFailureReasonState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      otherReasonController: otherReasonController,
      reqState: reqState ?? this.reqState,
      msgError: msgError ?? this.msgError,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, reqState, msgError];
}

class DeliveryFailureReasonNotifier
    extends Notifier<DeliveryFailureReasonState> {
  @override
  DeliveryFailureReasonState build() {
    final s = DeliveryFailureReasonState(reqState: ReqState.success);
    ref.onDispose(() => s.otherReasonController.dispose());
    return s;
  }

  void selectReason(int index) {
    state = state.copyWith(selectedIndex: index);
  }

  /// Hook for the future API fetch of failure reasons. Today the list is
  /// hardcoded so callers can ignore the loading flow, but the state already
  /// supports loading / error so wiring it later is a small change.
  void retry() {
    state = state.copyWith(reqState: ReqState.success, msgError: '');
  }
}

final deliveryFailureReasonController = NotifierProvider.autoDispose<
    DeliveryFailureReasonNotifier, DeliveryFailureReasonState>(
  DeliveryFailureReasonNotifier.new,
);
