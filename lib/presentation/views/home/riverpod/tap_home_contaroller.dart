import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:jar/app/utils/state_render.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TapHomeState extends Equatable {
  final ReqState reqState;
  const TapHomeState({this.reqState = ReqState.loading});

  TapHomeState copyWith({ReqState? reqState}) {
    return TapHomeState(reqState: reqState ?? this.reqState);
  }

  @override
  List<Object?> get props => [reqState];
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
