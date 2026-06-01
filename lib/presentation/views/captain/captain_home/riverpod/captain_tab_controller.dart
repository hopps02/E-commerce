import 'package:carousel_slider/carousel_controller.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// dart format off

class CaptainTabData extends Equatable {
  final ReqState reqState;
  final String msgError;
  const CaptainTabData({
    this.reqState = ReqState.success,
    this.msgError = '',
  });

  CaptainTabData copyWith({ReqState? reqState, String? msgError}) {
    return CaptainTabData(
      reqState: reqState ?? this.reqState,
      msgError: msgError ?? this.msgError,
    );
  }

  @override
  List<Object?> get props => [reqState, msgError];
}

class CaptainHomeState extends Equatable {
  final int selectedIndex;
  final bool isAvailable;
  final CaptainTabData upcomingData;
  final CaptainTabData inDeliveryData;
  final CaptainTabData completedData;

  const CaptainHomeState({
    this.selectedIndex = 0,
    this.isAvailable = true,
    this.upcomingData = const CaptainTabData(),
    this.inDeliveryData = const CaptainTabData(),
    this.completedData = const CaptainTabData(),
  });

  CaptainHomeState copyWith({
    int? selectedIndex,
    bool? isAvailable,
    CaptainTabData? upcomingData,
    CaptainTabData? inDeliveryData,
    CaptainTabData? completedData,
  }) {
    return CaptainHomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isAvailable: isAvailable ?? this.isAvailable,
      upcomingData: upcomingData ?? this.upcomingData,
      inDeliveryData: inDeliveryData ?? this.inDeliveryData,
      completedData: completedData ?? this.completedData,
    );
  }

  @override
  List<Object?> get props => [
        selectedIndex,
        isAvailable,
        upcomingData,
        inDeliveryData,
        completedData,
      ];
}

class CaptainHomeNotifier extends Notifier<CaptainHomeState> {
  final CarouselSliderController carouselController =
      CarouselSliderController();

  final RefreshController upcomingRefreshController = RefreshController();
  final RefreshController inDeliveryRefreshController = RefreshController();
  final RefreshController completedRefreshController = RefreshController();

  @override
  CaptainHomeState build() {
    ref.onDispose(() {
      upcomingRefreshController.dispose();
      inDeliveryRefreshController.dispose();
      completedRefreshController.dispose();
    });
    return const CaptainHomeState();
  }

  void onTabChange(int index) {
    state = state.copyWith(selectedIndex: index);
    carouselController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  void toggleAvailability() {
    state = state.copyWith(isAvailable: !state.isAvailable);
  }
}

final captainHomeController =
    NotifierProvider.autoDispose<CaptainHomeNotifier, CaptainHomeState>(
      CaptainHomeNotifier.new,
    );
