import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/di/dependency_injection.dart';

class CashierSupportNotifier extends Notifier<bool> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode messageFocusNode = FocusNode();

  @override
  bool build() {
    ref.onDispose(() {
      nameController.dispose();
      messageController.dispose();
      nameFocusNode.dispose();
      messageFocusNode.dispose();
    });
    return false;
  }

  Future<void> send() async {
    DI().loadingService.show();
    await Future.delayed(const Duration(seconds: 1), () {
      DI().loadingService.hide();
    });
    state = true;
  }
}


// true for success sending request
// and with true state should close the page
final cashierSupportController =
    NotifierProvider.autoDispose<CashierSupportNotifier, bool>(
      CashierSupportNotifier.new,
    );
