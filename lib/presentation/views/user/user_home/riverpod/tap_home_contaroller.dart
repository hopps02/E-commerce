import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TapHomeState extends Equatable {
  final ReqState reqState;
  final String errorMessage;
  final bool isOutOfCoverage;

  const TapHomeState({
    this.reqState = ReqState.loading,
    this.errorMessage = "",
    this.isOutOfCoverage = false,
  });

  TapHomeState copyWith({
    ReqState? reqState,
    String? errorMessage,
    bool? isOutOfCoverage,
  }) {
    return TapHomeState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
      isOutOfCoverage: isOutOfCoverage ?? this.isOutOfCoverage,
    );
  }

  @override
  List<Object?> get props => [reqState, errorMessage, isOutOfCoverage];
}

class TapHomeNotifier extends Notifier<TapHomeState> {
  final RefreshController refreshController = RefreshController();

  @override
  TapHomeState build() {
    ref.onDispose(() {
      refreshController.dispose();
    });

    return const TapHomeState();
  }
}

final tapHomeController =
    NotifierProvider.autoDispose<TapHomeNotifier, TapHomeState>(
      TapHomeNotifier.new,
    );
