import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/data/response/customer/support_response.dart';
import 'package:for_u/domain/usecase/reply_ticket_usecase.dart';
import 'package:for_u/presentation/views/user/support/riverpod/tickets_controller.dart';

class TicketDetailState extends Equatable {
  final ReqState reqState;
  final String msgError;
  final int ticketId;
  final Ticket? ticket;

  /// True while a reply is being sent — drives the in-button spinner.
  final bool sending;

  const TicketDetailState({
    this.reqState = ReqState.loading,
    this.msgError = '',
    this.ticketId = 0,
    this.ticket,
    this.sending = false,
  });

  TicketDetailState copyWith({
    ReqState? reqState,
    String? msgError,
    int? ticketId,
    Ticket? ticket,
    bool? sending,
  }) {
    return TicketDetailState(
      reqState: reqState ?? this.reqState,
      msgError: msgError ?? this.msgError,
      ticketId: ticketId ?? this.ticketId,
      ticket: ticket ?? this.ticket,
      sending: sending ?? this.sending,
    );
  }

  @override
  List<Object?> get props => [reqState, msgError, ticketId, ticket, sending];
}

class TicketDetailNotifier extends Notifier<TicketDetailState> {
  @override
  TicketDetailState build() => const TicketDetailState();

  Future<void> load(int id) async {
    state = state.copyWith(reqState: ReqState.loading, ticketId: id);
    final result = await DI().getTicketUseCase.execute(id);
    result.fold(
      (failure) => state = state.copyWith(
        reqState: ReqState.error,
        msgError: failure.displayMessage,
      ),
      (ticket) => state = state.copyWith(
        reqState: ReqState.success,
        ticket: ticket,
      ),
    );
  }

  Future<void> retry() => load(state.ticketId);

  /// Sends a reply and replaces the thread with the backend's updated ticket
  /// (the new message is appended server-side). Returns the updated ticket, or
  /// null when the failure was already surfaced (e.g. a closed ticket).
  Future<Ticket?> reply(String body) async {
    final id = state.ticketId;
    if (id == 0 || state.sending) return null;

    state = state.copyWith(sending: true);
    final result = await DI().replyTicketUseCase.execute(
      ReplyTicketParams(id: id, body: body),
    );
    state = state.copyWith(sending: false);

    return result.fold((failure) {
      DI().snackBarHelper.showMessage(
        failure.displayMessage,
        ErrorMessage.snackBar,
      );
      return null;
    }, (ticket) {
      state = state.copyWith(reqState: ReqState.success, ticket: ticket);
      // Keep the list row in sync (status/last activity) so going back doesn't
      // show a stale ticket. No-op if the list isn't holding this ticket.
      ref.read(ticketsController.notifier).upsert(ticket);
      return ticket;
    });
  }
}

final ticketDetailController =
    NotifierProvider.autoDispose<TicketDetailNotifier, TicketDetailState>(
      TicketDetailNotifier.new,
    );
