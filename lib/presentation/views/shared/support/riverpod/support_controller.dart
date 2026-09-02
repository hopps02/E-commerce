
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/extensions/failure_display_extension.dart';
import 'package:store/app/utils/snackbar_helper.dart';

import 'package:store/data/request/customer/customer_request.dart';


import 'package:store/presentation/res/translations_manager.dart';

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


    final body = OpenTicketBody(title: title, description: description);

    final request = DI().openTicketUseCase.execute(body);

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
