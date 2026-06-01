import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/app/validation/field_rules.dart';
import 'package:for_u/presentation/common/general_padding.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/shared/support/riverpod/support_controller.dart';

class SupportSendButton extends ConsumerWidget {
  const SupportSendButton({super.key});

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
    final notifier = ref.read(supportController.notifier);

    final invalid = validateOnSubmit([
      SubmitField(
        value: notifier.nameController.text,
        focusNode: notifier.nameFocusNode,
        rule: Rules.required(),
      ),
      SubmitField(
        value: notifier.messageController.text,
        focusNode: notifier.messageFocusNode,
        rule: Rules.required(),
      ),
    ]);
    if (invalid != null) return;

    FocusScope.of(context).unfocus();
    notifier.send();
  }
}
