import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';

class SectionsState extends Equatable {
  final ReqState reqState;
  final String errorMessage;
  const SectionsState({
    this.reqState = ReqState.loading,
    this.errorMessage = "",
  });

  SectionsState copyWith({ReqState? reqState, String? errorMessage}) {
    return SectionsState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [reqState, errorMessage];
}

class SectionsNotifier extends Notifier<SectionsState> {
  @override
  SectionsState build() {
    return const SectionsState();
  }
}

final sectionsController =
    NotifierProvider.autoDispose<SectionsNotifier, SectionsState>(
      SectionsNotifier.new,
    );
