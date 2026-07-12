import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/enums/enums.dart';
import 'package:store/app/extensions/failure_display_extension.dart';
import 'package:store/app/ui_kit/indicators/state_render.dart';
import 'package:store/app/utils/snackbar_helper.dart';
import 'package:store/data/response/cashier/cashier_response.dart';
import 'package:store/domain/usecase/reassign_captain_usecase.dart';

class ChangeCaptainState extends Equatable {
  final List<AvailableCaptain> captains;
  final int? selectedIndex;
  final ReassignReason? reason;
  final String note;
  final String query;
  final ReqState reqState;
  final String errorMessage;

  const ChangeCaptainState({
    this.captains = const [],
    this.selectedIndex,
    this.reason,
    this.note = '',
    this.query = '',
    this.reqState = ReqState.loading,
    this.errorMessage = '',
  });

  ChangeCaptainState copyWith({
    List<AvailableCaptain>? captains,
    int? selectedIndex,
    ReassignReason? reason,
    String? note,
    String? query,
    ReqState? reqState,
    String? errorMessage,
  }) {
    return ChangeCaptainState(
      captains: captains ?? this.captains,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      reason: reason ?? this.reason,
      note: note ?? this.note,
      query: query ?? this.query,
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// Captains filtered by [query] paired with their original index so the
  /// selection check stays stable across filters.
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

  /// A reason is mandatory; "other" additionally needs a note.
  bool get canConfirm =>
      selectedCaptain != null &&
      reason != null &&
      (!reason!.isOther || note.trim().isNotEmpty);

  ReqState get displayState =>
      reqState.isSuccess && filtered.isEmpty && query.trim().isNotEmpty
      ? ReqState.empty
      : reqState;

  @override
  List<Object?> get props => [
    captains,
    selectedIndex,
    reason,
    note,
    query,
    reqState,
    errorMessage,
  ];
}

class ChangeCaptainNotifier extends Notifier<ChangeCaptainState> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  ChangeCaptainState build() {
    ref.onDispose(searchController.dispose);
    ref.onDispose(noteController.dispose);
    return const ChangeCaptainState();
  }

  /// Loads the branch's available captains for [orderId], excluding the one
  /// currently assigned (you can only swap to a different captain).
  Future<void> load(int orderId, int? currentCaptainId) async {
    state = const ChangeCaptainState();
    final result = await DI().availableCaptainsUseCase.execute(orderId);
    result.fold(
      (failure) => state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: failure.displayMessage,
      ),
      (captains) {
        final others = captains
            .where((c) => c.id != currentCaptainId)
            .toList();
        state = state.copyWith(
          captains: others,
          reqState: others.isEmpty ? ReqState.empty : ReqState.success,
        );
      },
    );
  }

  void setQuery(String q) => state = state.copyWith(query: q);

  void selectCaptain(int index) => state = state.copyWith(selectedIndex: index);

  void selectReason(ReassignReason reason) {
    if (!reason.isOther) noteController.clear();
    state = state.copyWith(
      reason: reason,
      note: reason.isOther ? state.note : '',
    );
  }

  void setNote(String note) => state = state.copyWith(note: note);

  /// Reassigns to the selected captain with the chosen reason. Returns the
  /// updated order on success so the caller can refresh; failures are shown.
  Future<CashierOrder?> confirm(int orderId) async {
    final captain = state.selectedCaptain;
    final reason = state.reason;
    if (captain == null || reason == null || !state.canConfirm) return null;

    DI().loadingService.show();
    final result = await DI().reassignCaptainUseCase.execute(
      ReassignCaptainParams(
        orderId: orderId,
        captainId: captain.id,
        reason: reason.value,
        note: reason.isOther ? state.note.trim() : null,
      ),
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

final changeCaptainController =
    NotifierProvider.autoDispose<ChangeCaptainNotifier, ChangeCaptainState>(
      ChangeCaptainNotifier.new,
    );
