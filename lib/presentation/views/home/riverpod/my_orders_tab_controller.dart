import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:for_u/app/utils/state_render.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TapData extends Equatable {
  final ReqState reqState;
  final String msgError;
  const TapData({this.reqState = ReqState.loading, this.msgError = ''});

  TapData copyWith({ReqState? reqState, String? msgError}) {
    return TapData(
      reqState: reqState ?? this.reqState,
      msgError: msgError ?? this.msgError,
    );
  }

  @override
  List<Object?> get props => [reqState, msgError];
}

class MyOrdersTabState extends Equatable {
  final int selectedIndex;
  final TapData currentData;
  final TapData previousData;

  const MyOrdersTabState({
    this.selectedIndex = 0,
    this.currentData = const TapData(reqState: ReqState.success),
    this.previousData = const TapData(reqState: ReqState.success),
  });

  MyOrdersTabState copyWith({
    int? selectedIndex,
    TapData? currentData,
    TapData? previousData,
  }) {
    return MyOrdersTabState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      currentData: currentData ?? this.currentData,
      previousData: previousData ?? this.previousData,
    );
  }

  @override
  List<Object?> get props => [selectedIndex];
}

class MyOrdersTabNotifier extends Notifier<MyOrdersTabState> {
  final CarouselSliderController carouselController =
      CarouselSliderController();

  final RefreshController currentRefreshController = RefreshController();

  final RefreshController previousRefreshController = RefreshController();

  @override
  MyOrdersTabState build() {
    ref.onDispose(() {
      currentRefreshController.dispose();
      previousRefreshController.dispose();
    });
    return const MyOrdersTabState();
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

final myOrdersTabController =
    NotifierProvider.autoDispose<MyOrdersTabNotifier, MyOrdersTabState>(
      MyOrdersTabNotifier.new,
    );
