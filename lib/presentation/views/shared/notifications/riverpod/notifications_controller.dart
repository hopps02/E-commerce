import 'dart:math' as math;

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/data/network/envelope.dart';
import 'package:for_u/data/response/notification_response.dart';
import 'package:for_u/domain/usecase/get_notifications_usecase.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationsState extends Equatable {
  final ReqState reqState;
  final String msgError;
  final List<MobileNotification> notifications;
  final int page;
  final bool hasMore;
  final int unreadCount;

  const NotificationsState({
    this.reqState = ReqState.loading,
    this.msgError = '',
    this.notifications = const [],
    this.page = 1,
    this.hasMore = true,
    this.unreadCount = 0,
  });

  NotificationsState copyWith({
    ReqState? reqState,
    String? msgError,
    List<MobileNotification>? notifications,
    int? page,
    bool? hasMore,
    int? unreadCount,
  }) {
    return NotificationsState(
      reqState: reqState ?? this.reqState,
      msgError: msgError ?? this.msgError,
      notifications: notifications ?? this.notifications,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  List<Object?> get props => [
    reqState,
    msgError,
    notifications,
    page,
    hasMore,
    unreadCount,
  ];
}

class NotificationsNotifier extends Notifier<NotificationsState> {
  final RefreshController refreshController = RefreshController();
  final Set<int> _pendingReads = {};

  @override
  NotificationsState build() {
    ref.onDispose(refreshController.dispose);
    return const NotificationsState();
  }

  Future<void> load() async {
    if (await _isGuest()) {
      state = const NotificationsState(reqState: ReqState.empty);
      return;
    }
    state = state.copyWith(
      reqState: ReqState.loading,
      msgError: '',
      page: 1,
      hasMore: true,
    );
    await Future.wait([_loadFirstPage(), refreshUnreadCount()]);
  }

  Future<void> retry() => load();

  Future<void> refresh() async {
    if (await _isGuest()) {
      state = const NotificationsState(reqState: ReqState.empty);
      refreshController.refreshCompleted();
      return;
    }
    await Future.wait([_loadFirstPage(), refreshUnreadCount()]);
    refreshController.refreshCompleted();
  }

  Future<void> loadMore() async {
    if (await _isGuest()) {
      refreshController.loadNoData();
      return;
    }
    if (!state.hasMore) {
      refreshController.loadNoData();
      return;
    }

    final next = state.page + 1;
    final result = await DI().getNotificationsUseCase.execute(
      NotificationsParams(page: next),
    );

    result.fold((failure) => refreshController.loadFailed(), (pageData) {
      state = state.copyWith(
        notifications: [...state.notifications, ...pageData.items],
        page: next,
        hasMore: _morePagesAfter(pageData.meta, next),
      );
      refreshController.loadComplete();
    });
  }

  Future<void> refreshUnreadCount() async {
    if (await _isGuest()) {
      state = state.copyWith(unreadCount: 0);
      return;
    }
    final result = await DI().getUnreadNotificationsCountUseCase.execute(null);
    result.fold(
      (_) {},
      (count) => state = state.copyWith(unreadCount: math.max(0, count)),
    );
  }

  Future<void> markRead(int id) async {
    if (_pendingReads.contains(id)) return;
    final index = state.notifications.indexWhere((item) => item.id == id);
    if (index == -1 || state.notifications[index].read) return;

    _pendingReads.add(id);
    final before = state.notifications[index];
    final optimistic = before.copyWith(read: true);
    _replace(optimistic, unreadDelta: -1);

    try {
      final result = await DI().markNotificationReadUseCase.execute(id);
      result.fold((failure) {
        _replace(before, unreadDelta: 1);
        DI().snackBarHelper.showMessage(
          failure.displayMessage,
          ErrorMessage.snackBar,
        );
      }, (updated) => _replace(updated));
    } finally {
      _pendingReads.remove(id);
    }
  }

  Future<void> markAllRead() async {
    if (state.unreadCount <= 0) return;

    final before = state;
    state = state.copyWith(
      unreadCount: 0,
      notifications: [
        for (final item in state.notifications) item.copyWith(read: true),
      ],
    );

    final result = await DI().markAllNotificationsReadUseCase.execute(null);
    result.fold((failure) {
      state = before;
      DI().snackBarHelper.showMessage(
        failure.displayMessage,
        ErrorMessage.snackBar,
      );
    }, (_) {});
  }

  void clear() => state = const NotificationsState();

  Future<void> _loadFirstPage() async {
    final result = await DI().getNotificationsUseCase.execute(
      const NotificationsParams(page: 1),
    );
    result.fold(
      (failure) => state = state.copyWith(
        reqState: ReqState.error,
        msgError: failure.displayMessage,
      ),
      (pageData) => state = state.copyWith(
        reqState: pageData.items.isEmpty ? ReqState.empty : ReqState.success,
        notifications: pageData.items,
        page: 1,
        hasMore: _morePagesAfter(pageData.meta, 1),
      ),
    );
  }

  void _replace(MobileNotification notification, {int unreadDelta = 0}) {
    state = state.copyWith(
      notifications: [
        for (final item in state.notifications)
          item.id == notification.id ? notification : item,
      ],
      unreadCount: math.max(0, state.unreadCount + unreadDelta),
    );
  }

  bool _morePagesAfter(Meta? meta, int page) =>
      meta != null && page * meta.pageSize < meta.total;

  Future<bool> _isGuest() => DI().sessionService.isGuest;
}

final notificationsController =
    NotifierProvider<NotificationsNotifier, NotificationsState>(
      NotificationsNotifier.new,
    );
