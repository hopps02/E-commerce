import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/data/network/envelope.dart';
import 'package:for_u/data/response/customer/support_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TicketsState extends Equatable {
  final ReqState reqState;
  final String msgError;
  final List<Ticket> tickets;
  final int page;
  final bool hasMore;

  const TicketsState({
    this.reqState = ReqState.loading,
    this.msgError = '',
    this.tickets = const [],
    this.page = 1,
    this.hasMore = true,
  });

  TicketsState copyWith({
    ReqState? reqState,
    String? msgError,
    List<Ticket>? tickets,
    int? page,
    bool? hasMore,
  }) {
    return TicketsState(
      reqState: reqState ?? this.reqState,
      msgError: msgError ?? this.msgError,
      tickets: tickets ?? this.tickets,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [reqState, msgError, tickets, page, hasMore];
}

/// The customer's support tickets list (newest first), with pull-to-refresh and
/// paging. A freshly opened ticket is prepended so it shows without a reload.
class TicketsNotifier extends Notifier<TicketsState> {
  final RefreshController refreshController = RefreshController();

  @override
  TicketsState build() {
    ref.onDispose(refreshController.dispose);
    Future.microtask(_loadFirstPage);
    return const TicketsState();
  }

  Future<void> _loadFirstPage() async {
    final result = await DI().getTicketsUseCase.execute(1);
    result.fold(
      (failure) => state = state.copyWith(
        reqState: ReqState.error,
        msgError: failure.displayMessage,
      ),
      (pageData) => state = TicketsState(
        reqState: pageData.items.isEmpty ? ReqState.empty : ReqState.success,
        tickets: pageData.items,
        page: 1,
        hasMore: _morePagesAfter(pageData.meta, 1),
      ),
    );
  }

  Future<void> retry() async {
    state = state.copyWith(reqState: ReqState.loading);
    await _loadFirstPage();
  }

  Future<void> refresh() async {
    await _loadFirstPage();
    refreshController.refreshCompleted();
  }

  Future<void> loadMore() async {
    if (!state.hasMore) {
      refreshController.loadNoData();
      return;
    }
    final next = state.page + 1;
    final result = await DI().getTicketsUseCase.execute(next);
    result.fold((failure) => refreshController.loadFailed(), (pageData) {
      state = state.copyWith(
        tickets: [...state.tickets, ...pageData.items],
        page: next,
        hasMore: _morePagesAfter(pageData.meta, next),
      );
      refreshController.loadComplete();
    });
  }

  /// Puts a just-opened ticket at the top of the list (no reload).
  void prepend(Ticket ticket) {
    state = state.copyWith(
      reqState: ReqState.success,
      tickets: [ticket, ...state.tickets.where((t) => t.id != ticket.id)],
    );
  }

  /// Refreshes a ticket already in the list (e.g. after a reply changed status).
  void upsert(Ticket ticket) {
    if (!state.tickets.any((t) => t.id == ticket.id)) return;
    state = state.copyWith(
      tickets: state.tickets.map((t) => t.id == ticket.id ? ticket : t).toList(),
    );
  }

  bool _morePagesAfter(Meta? meta, int page) =>
      meta != null && page * meta.pageSize < meta.total;
}

final ticketsController =
    NotifierProvider.autoDispose<TicketsNotifier, TicketsState>(
      TicketsNotifier.new,
    );
