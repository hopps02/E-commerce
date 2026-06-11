import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/data/models/cashier/cashier_models.dart';

class AssignCaptainState extends Equatable {
  final List<AvailableCaptain> captains;
  final int? selectedIndex;
  final String query;
  final ReqState reqState;
  final String errorMessage;

  const AssignCaptainState({
    this.captains = const [],
    this.selectedIndex,
    this.query = '',
    this.reqState = ReqState.loading,
    this.errorMessage = '',
  });

  AssignCaptainState copyWith({
    List<AvailableCaptain>? captains,
    int? selectedIndex,
    String? query,
    ReqState? reqState,
    String? errorMessage,
  }) {
    return AssignCaptainState(
      captains: captains ?? this.captains,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      query: query ?? this.query,
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// Captains filtered by [query] paired with their original index so the
  /// selection check can stay stable across filters.
  List<(int, AvailableCaptain)> get filtered {
    final indexed = [
      for (var i = 0; i < captains.length; i++) (i, captains[i]),
    ];
    if (query.trim().isEmpty) return indexed;
    final q = query.toLowerCase();
    return indexed.where((e) {
      return (e.$2.name ?? '').toLowerCase().contains(q) ||
          (e.$2.phone ?? '').toLowerCase().contains(q);
    }).toList();
  }

  AvailableCaptain? get selectedCaptain =>
      selectedIndex == null ? null : captains[selectedIndex!];

  /// What [FastStateRender] should show. Falls back to [ReqState.empty] when
  /// the user typed a query that matches nothing, even though the underlying
  /// fetch succeeded.
  ReqState get displayState =>
      reqState.isSuccess && filtered.isEmpty && query.trim().isNotEmpty
      ? ReqState.empty
      : reqState;

  @override
  List<Object?> get props => [
    captains,
    selectedIndex,
    query,
    reqState,
    errorMessage,
  ];
}

class AssignCaptainNotifier extends Notifier<AssignCaptainState> {
  final TextEditingController searchController = TextEditingController();

  @override
  AssignCaptainState build() {
    ref.onDispose(searchController.dispose);
    return const AssignCaptainState();
  }

  /// Loads the branch's currently-available captains for [orderId].
  Future<void> load(int orderId) async {
    state = const AssignCaptainState();
    final result = await DI().cashierRepository.availableCaptains(orderId);
    result.fold(
      (failure) => state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: failure.displayMessage,
      ),
      (captains) => state = state.copyWith(
        captains: captains,
        reqState: captains.isEmpty ? ReqState.empty : ReqState.success,
      ),
    );
  }

  void setQuery(String q) {
    state = state.copyWith(query: q);
  }

  void selectCaptain(int index) {
    state = state.copyWith(selectedIndex: index);
  }

  /// Assigns the selected captain. Returns the updated order on success so
  /// the caller can refresh its screen; failures are shown and return null.
  Future<CashierOrder?> confirm(int orderId) async {
    final captain = state.selectedCaptain;
    if (captain == null) return null;

    DI().loadingService.show();
    final result = await DI().cashierRepository.assignCaptain(
      orderId,
      captain.id,
    );
    DI().loadingService.hide();

    return result.fold((failure) {
      DI().snackBarHelper.showMessage(
        failure.displayMessage,
        ErrorMessage.snackBar,
      );
      return null;
    }, (order) => order);
  }
}

final assignCaptainController =
    NotifierProvider.autoDispose<AssignCaptainNotifier, AssignCaptainState>(
      AssignCaptainNotifier.new,
    );
