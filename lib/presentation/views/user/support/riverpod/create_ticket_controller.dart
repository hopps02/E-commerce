import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/extensions/failure_display_extension.dart';
import 'package:store/app/utils/snackbar_helper.dart';
import 'package:store/data/request/customer/customer_request.dart';
import 'package:store/data/response/customer/support_response.dart';

class CreateTicketState extends Equatable {
  final bool submitting;

  /// The optional linked order (routes the ticket to that order's merchant).
  /// Null = a general/platform ticket.
  final int? linkedOrderId;
  final String linkedOrderNumber;

  const CreateTicketState({
    this.submitting = false,
    this.linkedOrderId,
    this.linkedOrderNumber = '',
  });

  bool get hasLinkedOrder => linkedOrderId != null;

  @override
  List<Object?> get props => [submitting, linkedOrderId, linkedOrderNumber];
}

class CreateTicketNotifier extends Notifier<CreateTicketState> {
  @override
  CreateTicketState build() => const CreateTicketState();

  /// Links an order to the ticket; pass null to clear (general ticket).
  void selectOrder(int? orderId, String orderNumber) {
    state = CreateTicketState(
      submitting: state.submitting,
      linkedOrderId: orderId,
      linkedOrderNumber: orderId == null ? '' : orderNumber,
    );
  }

  /// Opens the ticket. Returns the created ticket, or null when the failure was
  /// already surfaced.
  Future<Ticket?> submit({
    required String title,
    required String description,
  }) async {
    if (state.submitting) return null;

    state = CreateTicketState(
      submitting: true,
      linkedOrderId: state.linkedOrderId,
      linkedOrderNumber: state.linkedOrderNumber,
    );
    final result = await DI().openTicketUseCase.execute(
      OpenTicketBody(
        title: title,
        description: description,
        orderId: state.linkedOrderId,
      ),
    );
    state = CreateTicketState(
      submitting: false,
      linkedOrderId: state.linkedOrderId,
      linkedOrderNumber: state.linkedOrderNumber,
    );

    return result.fold((failure) {
      DI().snackBarHelper.showMessage(
        failure.displayMessage,
        ErrorMessage.snackBar,
      );
      return null;
    }, (ticket) => ticket);
  }
}

final createTicketController =
    NotifierProvider.autoDispose<CreateTicketNotifier, CreateTicketState>(
      CreateTicketNotifier.new,
    );
