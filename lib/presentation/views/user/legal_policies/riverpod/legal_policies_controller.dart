import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/extensions/failure_display_extension.dart';
import 'package:store/app/ui_kit/indicators/state_render.dart';
import 'package:store/data/response/customer/support_response.dart';

class LegalPoliciesState extends Equatable {
  final ReqState reqState;
  final String errorMessage;
  final List<LegalSection> sections;

  const LegalPoliciesState({
    this.reqState = ReqState.loading,
    this.errorMessage = "",
    this.sections = const [],
  });

  LegalPoliciesState copyWith({
    ReqState? reqState,
    String? errorMessage,
    List<LegalSection>? sections,
  }) {
    return LegalPoliciesState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
      sections: sections ?? this.sections,
    );
  }

  @override
  List<Object?> get props => [reqState, errorMessage, sections];
}

class LegalPoliciesNotifier extends Notifier<LegalPoliciesState> {
  @override
  LegalPoliciesState build() {
    Future.microtask(_load);
    return const LegalPoliciesState();
  }

  Future<void> _load() async {
    final result = await DI().getLegalPoliciesUseCase.execute(null);
    result.fold(
      (failure) => state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: failure.displayMessage,
      ),
      (sections) => state = LegalPoliciesState(
        reqState: sections.isEmpty ? ReqState.empty : ReqState.success,
        sections: sections,
      ),
    );
  }

  Future<void> retry() {
    state = state.copyWith(reqState: ReqState.loading);
    return _load();
  }
}

final legalPoliciesController =
    NotifierProvider.autoDispose<LegalPoliciesNotifier, LegalPoliciesState>(
      LegalPoliciesNotifier.new,
    );
