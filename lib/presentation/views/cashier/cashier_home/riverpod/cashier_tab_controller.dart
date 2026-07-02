import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/data/response/cashier/cashier_response.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/get_cashier_orders_usecase.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// dart format off

class CashierTapData extends Equatable {
  final ReqState reqState;
  final String msgError;
  final List<CashierOrder> orders;
  final int page;
  final bool hasMore;

  const CashierTapData({
    this.reqState = ReqState.loading,
    this.msgError = '',
    this.orders = const [],
    this.page = 1,
    this.hasMore = true,
  });

  CashierTapData copyWith({
    ReqState? reqState,
    String? msgError,
    List<CashierOrder>? orders,
    int? page,
    bool? hasMore,
  }) {
    return CashierTapData(
      reqState: reqState ?? this.reqState,
      msgError: msgError ?? this.msgError,
      orders: orders ?? this.orders,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [reqState, msgError, orders, page, hasMore];
}

class CashierTabState extends Equatable {
  final int selectedIndex;
  final String cashierName;
  final CashierTapData preparationData;
  final CashierTapData onTheWayData;
  final CashierTapData exceptionsData;
  final bool hasNewOrder;
  final int newOrderCount;

  const CashierTabState({
    this.selectedIndex = 0,
    this.cashierName = '',
    this.preparationData = const CashierTapData(),
    this.onTheWayData = const CashierTapData(),
    this.exceptionsData = const CashierTapData(),
    this.hasNewOrder = false,
    this.newOrderCount = 0,
  });

  CashierTabState copyWith({
    int? selectedIndex,
    String? cashierName,
    CashierTapData? preparationData,
    CashierTapData? onTheWayData,
    CashierTapData? exceptionsData,
    bool? hasNewOrder,
    int? newOrderCount,
  }) {
    return CashierTabState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      cashierName: cashierName ?? this.cashierName,
      preparationData: preparationData ?? this.preparationData,
      onTheWayData: onTheWayData ?? this.onTheWayData,
      exceptionsData: exceptionsData ?? this.exceptionsData,
      hasNewOrder: hasNewOrder ?? this.hasNewOrder,
      newOrderCount: newOrderCount ?? this.newOrderCount,
    );
  }

  @override
  List<Object?> get props => [
    selectedIndex,
    cashierName,
    preparationData,
    onTheWayData,
    exceptionsData,
    hasNewOrder,
    newOrderCount,
  ];
}

// dart format on

class CashierTabNotifier extends Notifier<CashierTabState> {
  static const _preparationQueue = 'preparation';
  static const _onTheWayQueue = 'on_the_way';
  static const _exceptionsQueue = 'exceptions';

  final CarouselSliderController carouselController =
      CarouselSliderController();

  final RefreshController preparationRefreshController = RefreshController();
  final RefreshController onTheWayRefreshController = RefreshController();
  final RefreshController exceptionsRefreshController = RefreshController();

  final Set<String> _seenPreparationOrders = {};

  Timer? _pollTimer;

  bool _baselined = false;
  bool _isPreparationPollRunning = false;

  @override
  CashierTabState build() {
    _pollTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      unawaited(_pollPreparationQueue());
    });

    ref.onDispose(() {
      _pollTimer?.cancel();
      preparationRefreshController.dispose();
      onTheWayRefreshController.dispose();
      exceptionsRefreshController.dispose();
    });
    Future.microtask(loadInitial);
    return const CashierTabState();
  }

  void onTabChange(int index) {
    state = state.copyWith(selectedIndex: index);
    carouselController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<void> loadInitial() async {
    await Future.wait([
      _loadFirstPage(_preparationQueue),
      _loadFirstPage(_onTheWayQueue),
      _loadFirstPage(_exceptionsQueue),
      _loadCashierName(),
    ]);
  }

  Future<void> refreshQueue(String queue) async {
    await _loadFirstPage(queue);
    _refreshControllerFor(queue).refreshCompleted();
  }

  void dismissNewOrder() {
    if (!state.hasNewOrder && state.newOrderCount == 0) return;
    state = state.copyWith(hasNewOrder: false, newOrderCount: 0);
  }

  void onViewNewOrder() {
    dismissNewOrder();
    onTabChange(0);
  }

  Future<void> loadMore(String queue) async {
    final data = _dataFor(queue);
    if (!data.hasMore) {
      _refreshControllerFor(queue).loadNoData();
      return;
    }

    final result = await DI().getCashierOrdersUseCase.execute(
      CashierOrdersParams(queue: queue, page: data.page + 1),
    );
    result.fold(
      (failure) {
        _refreshControllerFor(queue).loadFailed();
      },
      (pageData) {
        _setData(
          queue,
          data.copyWith(
            orders: [...data.orders, ...pageData.orders],
            page: data.page + 1,
            hasMore: _morePagesAfter(pageData.meta, data.page + 1),
          ),
        );
        _refreshControllerFor(queue).loadComplete();
      },
    );
  }

  Future<void> _loadFirstPage(String queue) async {
    final result = await DI().getCashierOrdersUseCase.execute(
      CashierOrdersParams(queue: queue, page: 1),
    );
    result.fold(
      (failure) => _setData(
        queue,
        _dataFor(
          queue,
        ).copyWith(reqState: ReqState.error, msgError: failure.displayMessage),
      ),
      (pageData) {
        _setData(queue, _pageDataToState(pageData));
        if (queue == _preparationQueue) {
          _rememberPreparationOrders(pageData.orders);
        }
      },
    );
  }

  /// The greeting header shows the cashier's provisioned name.
  Future<void> _loadCashierName() async {
    final result = await DI().getCashierProfileUseCase.execute(null);
    result.fold(
      (_) {}, // The header simply keeps its placeholder on failure.
      (profile) => state = state.copyWith(cashierName: profile.name ?? ''),
    );
  }

  bool _morePagesAfter(meta, int page) =>
      meta != null && page * meta.pageSize < meta.total;

  Future<void> _pollPreparationQueue() async {
    if (_isPreparationPollRunning) return;

    _isPreparationPollRunning = true;
    try {
      final result = await DI().getCashierOrdersUseCase.execute(
        const CashierOrdersParams(queue: _preparationQueue, page: 1),
      );

      result.fold(
        (_) {},
        (pageData) {
          final preparationData = _pageDataToState(pageData);
          final orderNumbers = _orderNumbersFrom(pageData.orders);

          if (!_baselined) {
            _seenPreparationOrders.addAll(orderNumbers);
            _baselined = true;
            state = state.copyWith(preparationData: preparationData);
            return;
          }

          final newOrders = orderNumbers.difference(_seenPreparationOrders);
          _seenPreparationOrders.addAll(orderNumbers);

          state = state.copyWith(
            preparationData: preparationData,
            hasNewOrder: newOrders.isEmpty ? state.hasNewOrder : true,
            newOrderCount: newOrders.isEmpty
                ? state.newOrderCount
                : state.newOrderCount + newOrders.length,
          );
        },
      );
    } finally {
      _isPreparationPollRunning = false;
    }
  }

  void _rememberPreparationOrders(List<CashierOrder> orders) {
    _seenPreparationOrders.addAll(_orderNumbersFrom(orders));
    _baselined = true;
  }

  Set<String> _orderNumbersFrom(List<CashierOrder> orders) => orders
      .map((order) => order.orderNumber)
      .where((number) => number.isNotEmpty)
      .toSet();

  CashierTapData _pageDataToState(CashierOrdersPage pageData) => CashierTapData(
    reqState: pageData.orders.isEmpty ? ReqState.empty : ReqState.success,
    orders: pageData.orders,
    page: 1,
    hasMore: _morePagesAfter(pageData.meta, 1),
  );

  CashierTapData _dataFor(String queue) => switch (queue) {
    _preparationQueue => state.preparationData,
    _onTheWayQueue => state.onTheWayData,
    _ => state.exceptionsData,
  };

  RefreshController _refreshControllerFor(String queue) => switch (queue) {
    _preparationQueue => preparationRefreshController,
    _onTheWayQueue => onTheWayRefreshController,
    _ => exceptionsRefreshController,
  };

  void _setData(String queue, CashierTapData data) {
    state = switch (queue) {
      _preparationQueue => state.copyWith(preparationData: data),
      _onTheWayQueue => state.copyWith(onTheWayData: data),
      _ => state.copyWith(exceptionsData: data),
    };
  }
}

final cashierTabController =
    NotifierProvider.autoDispose<CashierTabNotifier, CashierTabState>(
      CashierTabNotifier.new,
    );
