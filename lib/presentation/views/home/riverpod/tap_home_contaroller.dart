import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:jar/app/utils/state_render.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TapHomeState extends Equatable {
  final ReqState reqState;
  final String errorMessage;

  const TapHomeState({
    this.reqState = ReqState.loading,
    this.errorMessage = "",
  });

  TapHomeState copyWith({
    ReqState? reqState,
    String? errorMessage,
  }) {
    return TapHomeState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [reqState, errorMessage];
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
