import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/config/env.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/domain/usecase/get_products_usecase.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductsState extends Equatable {
  final ReqState reqState;
  final String errorMessage;
  final List<BranchProduct> products;
  final int page;
  final bool hasMore;

  const ProductsState({
    this.reqState = ReqState.loading,
    this.errorMessage = "",
    this.products = const [],
    this.page = 1,
    this.hasMore = true,
  });

  ProductsState copyWith({
    ReqState? reqState,
    String? errorMessage,
    List<BranchProduct>? products,
    int? page,
    bool? hasMore,
  }) {
    return ProductsState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
      products: products ?? this.products,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [reqState, errorMessage, products, page, hasMore];
}

class ProductsNotifier extends Notifier<ProductsState> {
  final RefreshController refreshController = RefreshController();

  int? _categoryId;
  String? _search;

  @override
  ProductsState build() {
    ref.onDispose(() {
      refreshController.dispose();
    });
    return const ProductsState();
  }

  /// Loads the first page for a category and/or search term. The browse
  /// branch is fixed until the multi-store home ships.
  Future<void> init({int? categoryId, String? search}) async {
    _categoryId = categoryId;
    _search = search;
    state = const ProductsState();
    await _loadPage(1);
  }

  Future<void> refresh() async {
    await _loadPage(1);
    refreshController.refreshCompleted();
  }

  Future<void> loadMore() async {
    if (!state.hasMore) {
      refreshController.loadNoData();
      return;
    }
    await _loadPage(state.page + 1);
    state.hasMore
        ? refreshController.loadComplete()
        : refreshController.loadNoData();
  }

  Future<void> _loadPage(int page) async {
    final result = await DI().getProductsUseCase.execute(
      ProductsParams(
        branchId: Env.defaultBranchId,
        categoryId: _categoryId,
        search: _search,
        page: page,
      ),
    );

    result.fold(
      (failure) {
        if (page == 1) {
          state = state.copyWith(
            reqState: ReqState.error,
            errorMessage: failure.displayMessage,
          );
        } else {
          refreshController.loadFailed();
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

final productsController =
    NotifierProvider.autoDispose<ProductsNotifier, ProductsState>(
      ProductsNotifier.new,
    );
