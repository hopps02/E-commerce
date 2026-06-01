import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';

class HelpSupportState extends Equatable {
  final ReqState reqState;
  final String errorMessage;

  const HelpSupportState({
    this.reqState = ReqState
        .loading, // Default to success as per your mock logic, or loading if API
    this.errorMessage = "",
  });

  HelpSupportState copyWith({ReqState? reqState, String? errorMessage}) {
    return HelpSupportState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [reqState, errorMessage];
}

class HelpSupportNotifier extends Notifier<HelpSupportState> {
  @override
  HelpSupportState build() {
    return const HelpSupportState(reqState: ReqState.success);
  }
}

final helpSupportController =
    NotifierProvider.autoDispose<HelpSupportNotifier, HelpSupportState>(
      HelpSupportNotifier.new,
    );
