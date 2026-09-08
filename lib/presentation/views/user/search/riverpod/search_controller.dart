import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/extensions/failure_display_extension.dart';
import 'package:store/app/ui_kit/indicators/state_render.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/domain/usecase/get_products_usecase.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchState extends Equatable {
  final ReqState reqState;
  final String errorMessage;
  final String query;
  final List<BranchProduct> products;
  final int page;
  final bool hasMore;

  const SearchState({
    this.reqState = ReqState.idle,
    this.errorMessage = "",
    this.query = "",
    this.products = const [],
    this.page = 1,
    this.hasMore = true,
  });

  SearchState copyWith({
    ReqState? reqState,
    String? errorMessage,
    String? query,
    List<BranchProduct>? products,
    int? page,
    bool? hasMore,
  }) {
    return SearchState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
      query: query ?? this.query,
      products: products ?? this.products,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [
    reqState,
    errorMessage,
    query,
    products,
    page,
    hasMore,
  ];
}

class SearchNotifier extends Notifier<SearchState> {
  final RefreshController searchRefreshController = RefreshController();

  Timer? _debounce;

  @override
  SearchState build() {
    ref.onDispose(() {
      _debounce?.cancel();
      searchRefreshController.dispose();
    });
    return const SearchState();
  }

  /// Debounced so we hit the backend once per pause, not per keystroke.
  void onQueryChanged(String query) {
    _debounce?.cancel();
    final term = query.trim();
    if (term.isEmpty) {
      state = const SearchState();
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 400), () {
      state = state.copyWith(query: term, reqState: ReqState.loading);
      _loadPage(1);
    });
  }

  Future<void> loadMore() async {
    if (!state.hasMore) {
      searchRefreshController.loadNoData();
      return;
    }
    await _loadPage(state.page + 1);
    state.hasMore
        ? searchRefreshController.loadComplete()
        : searchRefreshController.loadNoData();
  }

  Future<void> refresh() async {
    await _loadPage(1);
    searchRefreshController.refreshCompleted();
  }

  Future<void> _loadPage(int page) async {
    final term = state.query;
    final result = await DI().getProductsUseCase.execute(
      ProductsParams(search: term, page: page),
    );
    // A newer query superseded this response; drop it.
    if (term != state.query) return;

    result.fold(
      (failure) {
        if (page == 1) {
          state = state.copyWith(
            reqState: ReqState.error,
            errorMessage: failure.displayMessage,
          );
        } else {
          searchRefreshController.loadFailed();
        }
      },
      (data) {
        final products = page == 1
            ? data.products
            : [...state.products, ...data.products];
        final meta = data.meta;
        state = state.copyWith(
          reqState: products.isEmpty ? ReqState.empty : ReqState.success,
          products: products,
          page: page,
          hasMore: meta == null
              ? data.products.isNotEmpty
              : page * meta.pageSize < meta.total,
        );
      },
    );
  }
}

final searchController =
    NotifierProvider.autoDispose<SearchNotifier, SearchState>(
      SearchNotifier.new,
    );
