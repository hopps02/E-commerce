import 'package:flutter/widgets.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/app/validation/phone_validation.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

/// Validates a phone field and reacts to the outcome for you:
/// focuses [focusNode] when the field is empty, and shows the invalid-number
/// snackbar when it's malformed. Returns `true` only when the number is valid.
///
/// This is the UI-facing wrapper around the pure [validatePhoneNumber]; keep
/// the reactions here so call sites only need to ask "is it valid?".
Future<bool> validatePhoneField({
  required String dialCode,
  required String number,
  required FocusNode focusNode,
}) async {
  switch (await validatePhoneNumber(dialCode: dialCode, number: number)) {
    case EmptyPhone():
      focusNode.requestFocus();
      return false;
    case InvalidPhone():
      DI().snackBarHelper.showMessage(
        Translation.error_invalid_number.tr,
        ErrorMessage.snackBar,
      );
      return false;
    case ValidPhone():
      return true;
  }
}
