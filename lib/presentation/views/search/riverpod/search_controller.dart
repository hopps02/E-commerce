import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:for_u/app/utils/state_render.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchState extends Equatable {
  final ReqState reqState;
  final String errorMessage;
  const SearchState({this.reqState = ReqState.loading, this.errorMessage = ""});

  SearchState copyWith({ReqState? reqState, String? errorMessage}) {
    return SearchState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [reqState, errorMessage];
}

class SearchNotifier extends Notifier<SearchState> {
  final RefreshController searchRefreshController = RefreshController();

  @override
  SearchState build() {
    ref.onDispose(() {
      searchRefreshController.dispose();
    });
    return const SearchState();
  }
}

final searchController =
    NotifierProvider.autoDispose<SearchNotifier, SearchState>(
      SearchNotifier.new,
    );
