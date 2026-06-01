import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';

typedef PickedCaptain = ({
  String name,
  String phone,
  String avatarUrl,
  int completedToday,
});

const List<PickedCaptain> captains = [
  (name: 'عماد مجدي', phone: '+96542627282', avatarUrl: 'https://i.pravatar.cc/200?img=12', completedToday: 12),
  (name: 'عماد مجدي', phone: '+96542627282', avatarUrl: 'https://i.pravatar.cc/200?img=13', completedToday: 12),
  (name: 'عماد مجدي', phone: '+96542627282', avatarUrl: 'https://i.pravatar.cc/200?img=14', completedToday: 12),
  (name: 'عماد مجدي', phone: '+96542627282', avatarUrl: 'https://i.pravatar.cc/200?img=15', completedToday: 12),
  (name: 'عماد مجدي', phone: '+96542627282', avatarUrl: 'https://i.pravatar.cc/200?img=16', completedToday: 12),
];

class AssignCaptainState extends Equatable {
  final int? selectedIndex;
  final String query;
  final ReqState reqState;
  final String errorMessage;

  const AssignCaptainState({
    this.selectedIndex,
    this.query = '',
    this.reqState = ReqState.loading,
    this.errorMessage = '',
  });

  AssignCaptainState copyWith({
    int? selectedIndex,
    String? query,
    ReqState? reqState,
    String? errorMessage,
  }) {
    return AssignCaptainState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      query: query ?? this.query,
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// Captains filtered by [query] paired with their original index so the
  /// selection check can stay stable across filters.
  List<(int, PickedCaptain)> get filtered {
    final indexed = [
      for (var i = 0; i < captains.length; i++) (i, captains[i]),
    ];
    if (query.trim().isEmpty) return indexed;
    final q = query.toLowerCase();
    return indexed.where((e) {
      return e.$2.name.toLowerCase().contains(q) ||
          e.$2.phone.toLowerCase().contains(q);
    }).toList();
  }

  PickedCaptain? get selectedCaptain =>
      selectedIndex == null ? null : captains[selectedIndex!];

  /// What [FastStateRender] should show. Falls back to [ReqState.empty] when
  /// the user typed a query that matches nothing, even though the underlying
  /// fetch succeeded.
  ReqState get displayState =>
      reqState.isSuccess && filtered.isEmpty && query.trim().isNotEmpty
          ? ReqState.empty
          : reqState;

  @override
  List<Object?> get props => [selectedIndex, query, reqState, errorMessage];
}

class AssignCaptainNotifier extends Notifier<AssignCaptainState> {
  final TextEditingController searchController = TextEditingController();

  @override
  AssignCaptainState build() {
    ref.onDispose(searchController.dispose);
    return const AssignCaptainState(
      reqState: ReqState.success,
    );
  }

  void setQuery(String q) {
    state = state.copyWith(query: q);
  }

  void selectCaptain(int index) {
    state = state.copyWith(selectedIndex: index);
  }
}

final assignCaptainController =
    NotifierProvider.autoDispose<AssignCaptainNotifier, AssignCaptainState>(
      AssignCaptainNotifier.new,
    );
