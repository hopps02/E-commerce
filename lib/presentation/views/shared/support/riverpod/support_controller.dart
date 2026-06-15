import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/data/request/customer/customer_request.dart';
import 'package:for_u/data/response/auth/auth_response.dart';
import 'package:for_u/data/response/customer/support_response.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

class SupportState extends Equatable {
  /// True while the ticket is being opened — drives the in-button spinner.
  final bool submitting;

  /// True once the ticket was opened — the view pops the page.
  final bool success;

  const SupportState({this.submitting = false, this.success = false});

  @override
  List<Object?> get props => [submitting, success];
}

/// Opens a support ticket for the signed-in staff member (cashier/captain).
/// Open-ticket only — staff have no thread/list in v1; the ticket is handled in
/// the admin/merchant panel.
class SupportNotifier extends Notifier<SupportState> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final FocusNode titleFocusNode = FocusNode();
  final FocusNode messageFocusNode = FocusNode();

  @override
  SupportState build() {
    ref.onDispose(() {
      titleController.dispose();
      messageController.dispose();
      titleFocusNode.dispose();
      messageFocusNode.dispose();
    });
    return const SupportState();
  }

  Future<void> send() async {
    if (state.submitting) return;

    final title = titleController.text.trim();
    final description = messageController.text.trim();

    state = const SupportState(submitting: true);

    final role = await DI().sessionService.storedRole();
    final body = OpenTicketBody(title: title, description: description);

    // Staff open-ticket is cashier- or captain-only; the backend routes to a
    // different endpoint per role. Anything else (customer/null) has no staff
    // ticket endpoint, so fail loudly instead of silently using the cashier one.
    final Future<Either<Failure, Ticket>> request;
    switch (role) {
      case MobileRole.cashier:
        request = DI().openCashierTicketUseCase.execute(body);
      case MobileRole.captain:
        request = DI().openCaptainTicketUseCase.execute(body);
      default:
        DI().snackBarHelper.showMessage(
          Translation.something_is_wrong.tr,
          ErrorMessage.snackBar,
        );
        state = const SupportState(submitting: false);
        return;
    }

    final result = await request;

    result.fold(
      (failure) {
        DI().snackBarHelper.showMessage(
          failure.displayMessage,
          ErrorMessage.snackBar,
        );
        state = const SupportState(submitting: false);
      },
      (_) {
        titleController.clear();
        messageController.clear();
        DI().snackBarHelper.showMessage(
          Translation.ticket_submitted.tr,
          ErrorMessage.snackBar,
        );
        state = const SupportState(submitting: false, success: true);
      },
    );
  }
}

final supportController =
    NotifierProvider.autoDispose<SupportNotifier, SupportState>(
      SupportNotifier.new,
    );
