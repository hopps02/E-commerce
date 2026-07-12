import 'package:carousel_slider/carousel_controller.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/extensions/failure_display_extension.dart';
import 'package:store/app/ui_kit/indicators/state_render.dart';
import 'package:store/app/utils/snackbar_helper.dart';
import 'package:store/data/response/captain/captain_response.dart';
import 'package:store/domain/usecase/get_captain_orders_usecase.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// dart format off

class CaptainTabData extends Equatable {
  final ReqState reqState;
  final String msgError;
  final List<CaptainOrder> orders;
  final int page;
  final bool hasMore;

  const CaptainTabData({
    this.reqState = ReqState.loading,
    this.msgError = '',
    this.orders = const [],
    this.page = 1,
    this.hasMore = true,
  });

  CaptainTabData copyWith({
    ReqState? reqState,
    String? msgError,
    List<CaptainOrder>? orders,
    int? page,
    bool? hasMore,
  }) {
    return CaptainTabData(
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

class CaptainHomeState extends Equatable {
  final int selectedIndex;
  final bool isAvailable;
  final String captainName;
  final CaptainTabData upcomingData;
  final CaptainTabData inDeliveryData;
  final CaptainTabData completedData;

  const CaptainHomeState({
    this.selectedIndex = 0,
    this.isAvailable = true,
    this.captainName = '',
    this.upcomingData = const CaptainTabData(),
    this.inDeliveryData = const CaptainTabData(),
    this.completedData = const CaptainTabData(),
  });

  CaptainHomeState copyWith({
    int? selectedIndex,
    bool? isAvailable,
    String? captainName,
    CaptainTabData? upcomingData,
    CaptainTabData? inDeliveryData,
    CaptainTabData? completedData,
  }) {
    return CaptainHomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isAvailable: isAvailable ?? this.isAvailable,
      captainName: captainName ?? this.captainName,
      upcomingData: upcomingData ?? this.upcomingData,
      inDeliveryData: inDeliveryData ?? this.inDeliveryData,
      completedData: completedData ?? this.completedData,
    );
  }

  @override
  List<Object?> get props => [
        selectedIndex,
        isAvailable,
        captainName,
        upcomingData,
        inDeliveryData,
        completedData,
      ];
}

// dart format on

class CaptainHomeNotifier extends Notifier<CaptainHomeState> {
  static const upcomingQueue = 'upcoming';
  static const inDeliveryQueue = 'in_delivery';
  static const completedQueue = 'completed';

  final CarouselSliderController carouselController =
      CarouselSliderController();

  final RefreshController upcomingRefreshController = RefreshController();
  final RefreshController inDeliveryRefreshController = RefreshController();
  final RefreshController completedRefreshController = RefreshController();

  @override
  CaptainHomeState build() {
    ref.onDispose(() {
      upcomingRefreshController.dispose();
      inDeliveryRefreshController.dispose();
      completedRefreshController.dispose();
    });
    Future.microtask(loadInitial);
    return const CaptainHomeState();
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
      _loadFirstPage(upcomingQueue),
      _loadFirstPage(inDeliveryQueue),
      _loadFirstPage(completedQueue),
      _loadProfile(),
    ]);
  }

  /// Optimistic toggle; rolls back (and shows the failure) when the backend
  /// refuses — the pill must never lie about the captain's availability.
  Future<void> toggleAvailability() async {
    final before = state.isAvailable;
    final next = !before;
    state = state.copyWith(isAvailable: next);

    final result = await DI().setCaptainAvailabilityUseCase.execute(next);
    result.fold((failure) {
      state = state.copyWith(isAvailable: before);
      DI().snackBarHelper.showMessage(
        failure.displayMessage,
        ErrorMessage.snackBar,
      );
    }, (_) {});
  }

  Future<void> refreshQueue(String queue) async {
    await _loadFirstPage(queue);
    _refreshControllerFor(queue).refreshCompleted();
  }

  Future<void> loadMore(String queue) async {
    final data = _dataFor(queue);
    if (!data.hasMore) {
      _refreshControllerFor(queue).loadNoData();
      return;
    }

    final result = await DI().getCaptainOrdersUseCase.execute(
      CaptainOrdersParams(queue: queue, page: data.page + 1),
    );
    result.fold((failure) => _refreshControllerFor(queue).loadFailed(), (
      pageData,
    ) {
      _setData(
        queue,
        data.copyWith(
          orders: [...data.orders, ...pageData.orders],
          page: data.page + 1,
          hasMore: _morePagesAfter(pageData.meta, data.page + 1),
        ),
      );
      _refreshControllerFor(queue).loadComplete();
    });
  }

  Future<void> _loadFirstPage(String queue) async {
    final result = await DI().getCaptainOrdersUseCase.execute(
      CaptainOrdersParams(queue: queue, page: 1),
    );
    result.fold(
      (failure) => _setData(
        queue,
        _dataFor(
          queue,
        ).copyWith(reqState: ReqState.error, msgError: failure.displayMessage),
      ),
      (pageData) => _setData(
        queue,
        CaptainTabData(
          reqState: pageData.orders.isEmpty ? ReqState.empty : ReqState.success,
          orders: pageData.orders,
          page: 1,
          hasMore: _morePagesAfter(pageData.meta, 1),
        ),
      ),
    );
  }

  /// Greeting name + the real availability state from the backend.
  Future<void> _loadProfile() async {
    final result = await DI().getCaptainProfileUseCase.execute(null);
    result.fold(
      (_) {}, // The header keeps its defaults on failure.
      (profile) => state = state.copyWith(
        captainName: profile.name ?? '',
        isAvailable: profile.isAvailable,
      ),
    );
  }

  bool _morePagesAfter(meta, int page) =>
      meta != null && page * meta.pageSize < meta.total;

  CaptainTabData _dataFor(String queue) => switch (queue) {
    upcomingQueue => state.upcomingData,
    inDeliveryQueue => state.inDeliveryData,
    _ => state.completedData,
  };

  RefreshController _refreshControllerFor(String queue) => switch (queue) {
    upcomingQueue => upcomingRefreshController,
    inDeliveryQueue => inDeliveryRefreshController,
    _ => completedRefreshController,
  };

  void _setData(String queue, CaptainTabData data) {
    state = switch (queue) {
      upcomingQueue => state.copyWith(upcomingData: data),
      inDeliveryQueue => state.copyWith(inDeliveryData: data),
      _ => state.copyWith(completedData: data),
    };
  }
}

final captainHomeController =
    NotifierProvider.autoDispose<CaptainHomeNotifier, CaptainHomeState>(
      CaptainHomeNotifier.new,
    );
