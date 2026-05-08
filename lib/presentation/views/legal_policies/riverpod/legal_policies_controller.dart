import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jar/app/utils/state_render.dart';

class LegalPoliciesState extends Equatable {
  final ReqState reqState;
  final String errorMessage;
  
  const LegalPoliciesState({
    this.reqState = ReqState.loading,
    this.errorMessage = "",
  });

  LegalPoliciesState copyWith({ReqState? reqState, String? errorMessage}) {
    return LegalPoliciesState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [reqState, errorMessage];
}

class LegalPoliciesNotifier extends Notifier<LegalPoliciesState> {
  @override
  LegalPoliciesState build() {
    return const LegalPoliciesState(
      reqState: ReqState.success,
    );
  }
}

final legalPoliciesController =
    NotifierProvider.autoDispose<LegalPoliciesNotifier, LegalPoliciesState>(
      LegalPoliciesNotifier.new,
    );
