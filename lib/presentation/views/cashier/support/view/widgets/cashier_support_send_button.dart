import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_components/custom_ink_button.dart';
import 'package:for_u/presentation/common/general_padding.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/cashier/support/riverpod/cashier_support_controller.dart';

class CashierSupportSendButton extends ConsumerWidget {
  const CashierSupportSendButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GeneralPadding(
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: CustomInkButton(
          onTap: () => _onSend(context, ref),
          height: 56.h,
          width: double.infinity,
          borderRadius: SizeM.commonBorderRadius.r,
          backgroundColor: ColorM.primary500,
          alignment: Alignment.center,
          tap: const ButtonAnimationSettings(
            ButtonAnimation.scaleTap,
            intensity: 0.2,
          ),
          child: Text(
            Translation.send.tr,
            style: context.bodyLarge.copyWith(
              color: ColorM.white,
              fontWeight: FontWeightM.medium,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  void _onSend(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(cashierSupportController.notifier);

    if (notifier.nameController.text.trim().isEmpty) {
      notifier.nameFocusNode.requestFocus();
      return;
    }
    if (notifier.messageController.text.trim().isEmpty) {
      notifier.messageFocusNode.requestFocus();
      return;
    }

    FocusScope.of(context).unfocus();
    notifier.send();
  }
}
