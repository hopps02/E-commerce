import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';

class SectionsState extends Equatable {
  final ReqState reqState;
  final String errorMessage;
  final List<ProductCategory> categories;

  const SectionsState({
    this.reqState = ReqState.loading,
    this.errorMessage = "",
    this.categories = const [],
  });

  SectionsState copyWith({
    ReqState? reqState,
    String? errorMessage,
    List<ProductCategory>? categories,
  }) {
    return SectionsState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [reqState, errorMessage, categories];
}

class SectionsNotifier extends Notifier<SectionsState> {
  @override
  SectionsState build() {
    return const SectionsState();
  }

  Future<void> load() async {
    state = const SectionsState();
    final result = await DI().getCategoriesUseCase.execute(null);
    result.fold(
      (failure) => state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: failure.displayMessage,
      ),
      (categories) => state = state.copyWith(
        reqState: categories.isEmpty ? ReqState.empty : ReqState.success,
        categories: categories,
      ),
    );
  }
}

final sectionsController =
    NotifierProvider.autoDispose<SectionsNotifier, SectionsState>(
      SectionsNotifier.new,
    );
