import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/extensions/failure_display_extension.dart';
import 'package:store/app/ui_kit/indicators/state_render.dart';
import 'package:store/app/utils/mixins/auto_refresh_mixin.dart';
import 'package:store/data/response/customer/customer_response.dart';
import 'package:store/domain/usecase/get_customer_orders_usecase.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TapData extends Equatable {
  final ReqState reqState;
  final String msgError;
  final List<CustomerOrder> orders;
  final int page;
  final bool hasMore;

  const TapData({
    this.reqState = ReqState.loading,
    this.msgError = '',
    this.orders = const [],
    this.page = 1,
    this.hasMore = true,
  });

  TapData copyWith({
    ReqState? reqState,
    String? msgError,
    List<CustomerOrder>? orders,
    int? page,
    bool? hasMore,
  }) {
    return TapData(
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

class MyOrdersTabState extends Equatable {
  final int selectedIndex;
  final TapData currentData;
  final TapData previousData;

  const MyOrdersTabState({
    this.selectedIndex = 0,
    this.currentData = const TapData(),
    this.previousData = const TapData(),
  });

  MyOrdersTabState copyWith({
    int? selectedIndex,
    TapData? currentData,
    TapData? previousData,
  }) {
    return MyOrdersTabState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      currentData: currentData ?? this.currentData,
      previousData: previousData ?? this.previousData,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, currentData, previousData];
}

class MyOrdersTabNotifier extends Notifier<MyOrdersTabState>
    with AutoRefreshMixin<MyOrdersTabState> {
  static const currentGroup = 'current';
  static const previousGroup = 'previous';

  final CarouselSliderController carouselController =
      CarouselSliderController();

  final RefreshController currentRefreshController = RefreshController();

  final RefreshController previousRefreshController = RefreshController();

  @override
  MyOrdersTabState build() {
    ref.onDispose(() {
      currentRefreshController.dispose();
      previousRefreshController.dispose();
    });
    Future.microtask(loadInitial);
    return const MyOrdersTabState();
  }

  void onTabChange(int index) {
    state = state.copyWith(selectedIndex: index);
    carouselController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  /// Staff move orders along from the panel while the customer is watching the
  /// list, so the open tab re-reads itself on a timer and the cards follow the
  /// same status the details screen shows. It stops as soon as the customer
  /// leaves the tab.
  void setLive(bool live) {
    if (!live) {
      stopAutoRefresh();
      return;
    }

    startAutoRefresh(const Duration(seconds: 20), refreshVisibleGroup);
  }

  Future<void> refreshVisibleGroup() =>
      _loadFirstPage(state.selectedIndex == 0 ? currentGroup : previousGroup);

  Future<void> loadInitial() async {
    await Future.wait([
      _loadFirstPage(currentGroup),
      _loadFirstPage(previousGroup),
    ]);
  }

  Future<void> refreshGroup(String group) async {
    await _loadFirstPage(group);
    _refreshControllerFor(group).refreshCompleted();
  }

  Future<void> loadMore(String group) async {
    final data = _dataFor(group);
    if (!data.hasMore) {
      _refreshControllerFor(group).loadNoData();
      return;
    }

    final result = await DI().getCustomerOrdersUseCase.execute(
      CustomerOrdersParams(statusGroup: group, page: data.page + 1),
    );
    result.fold((failure) => _refreshControllerFor(group).loadFailed(), (
      pageData,
    ) {
      _setData(
        group,
        data.copyWith(
          orders: [...data.orders, ...pageData.orders],
          page: data.page + 1,
          hasMore: _morePagesAfter(pageData.meta, data.page + 1),
        ),
      );
      _refreshControllerFor(group).loadComplete();
    });
  }

  Future<void> _loadFirstPage(String group) async {
    final result = await DI().getCustomerOrdersUseCase.execute(
      CustomerOrdersParams(statusGroup: group, page: 1),
    );
    result.fold(
      (failure) => _setData(
        group,
        _dataFor(
          group,
        ).copyWith(reqState: ReqState.error, msgError: failure.displayMessage),
      ),
      (pageData) => _setData(
        group,
        TapData(
          reqState: pageData.orders.isEmpty ? ReqState.empty : ReqState.success,
          orders: pageData.orders,
          page: 1,
          hasMore: _morePagesAfter(pageData.meta, 1),
        ),
      ),
    );
  }

  bool _morePagesAfter(meta, int page) =>
      meta != null && page * meta.pageSize < meta.total;

  TapData _dataFor(String group) =>
      group == currentGroup ? state.currentData : state.previousData;

  RefreshController _refreshControllerFor(String group) => group == currentGroup
      ? currentRefreshController
      : previousRefreshController;

  void _setData(String group, TapData data) {
    state = group == currentGroup
        ? state.copyWith(currentData: data)
        : state.copyWith(previousData: data);
  }
}

final myOrdersTabController =
    NotifierProvider.autoDispose<MyOrdersTabNotifier, MyOrdersTabState>(
      MyOrdersTabNotifier.new,
    );
