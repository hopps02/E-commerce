import 'package:carousel_slider/carousel_controller.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// dart format off

class CashierTapData extends Equatable {
  final ReqState reqState;
  final String msgError;
  const CashierTapData({
    this.reqState = ReqState.success,
    this.msgError = '',
  });

  CashierTapData copyWith({ReqState? reqState, String? msgError}) {
    return CashierTapData(
      reqState: reqState ?? this.reqState,
      msgError: msgError ?? this.msgError,
    );
  }

  @override
  List<Object?> get props => [reqState, msgError];
}

class CashierTabState extends Equatable {
  final int selectedIndex;
  final CashierTapData preparationData;
  final CashierTapData onTheWayData;

  const CashierTabState({
    this.selectedIndex = 0,
    this.preparationData = const CashierTapData(),
    this.onTheWayData = const CashierTapData(),
  });

  CashierTabState copyWith({
    int? selectedIndex,
    CashierTapData? preparationData,
    CashierTapData? onTheWayData,
  }) {
    return CashierTabState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      preparationData: preparationData ?? this.preparationData,
      onTheWayData: onTheWayData ?? this.onTheWayData,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, preparationData, onTheWayData];
}

class CashierTabNotifier extends Notifier<CashierTabState> {
  final CarouselSliderController carouselController =
      CarouselSliderController();

  final RefreshController preparationRefreshController = RefreshController();
  final RefreshController onTheWayRefreshController = RefreshController();

  @override
  CashierTabState build() {
    ref.onDispose(() {
      preparationRefreshController.dispose();
      onTheWayRefreshController.dispose();
    });
    return const CashierTabState();
  }

  void onTabChange(int index) {
    state = state.copyWith(selectedIndex: index);
    carouselController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }
}

final cashierTabController =
    NotifierProvider.autoDispose<CashierTabNotifier, CashierTabState>(
      CashierTabNotifier.new,
    );
