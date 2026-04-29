import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

class BottomNavigationState extends Equatable {
  final int selectedIndex;
  const BottomNavigationState({this.selectedIndex = 0});

  BottomNavigationState copyWith({int? selectedIndex}) {
    return BottomNavigationState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [selectedIndex];
}

class BottomNavigationNotifier extends Notifier<BottomNavigationState> {
  final CarouselSliderController bottomNavBarSliderController =
      CarouselSliderController();

  @override
  BottomNavigationState build() => const BottomNavigationState();

  void onSelectionChange(int selectedIndex) {
    bottomNavBarSliderController.animateToPage(
      selectedIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
    );
    state = state.copyWith(selectedIndex: selectedIndex);
  }
  void onBottomNavTap(int selectedIndex) {
    state = state.copyWith(selectedIndex: selectedIndex);
  }

}

final bottomNavigationController =
    NotifierProvider.autoDispose<
      BottomNavigationNotifier,
      BottomNavigationState
    >(BottomNavigationNotifier.new);
