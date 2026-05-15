import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// dart format off

class CashierTabState extends Equatable {
  final int selectedIndex;
  const CashierTabState({this.selectedIndex = 0});

  CashierTabState copyWith({int? selectedIndex}) =>
      CashierTabState(selectedIndex: selectedIndex ?? this.selectedIndex);

  @override
  List<Object?> get props => [selectedIndex];
}

class CashierTabNotifier extends Notifier<CashierTabState> {
  @override
  CashierTabState build() => const CashierTabState();

  void onTabChange(int index) {
    state = state.copyWith(selectedIndex: index);
  }
}

final cashierTabController =
    NotifierProvider.autoDispose<CashierTabNotifier, CashierTabState>(
      CashierTabNotifier.new,
    );
