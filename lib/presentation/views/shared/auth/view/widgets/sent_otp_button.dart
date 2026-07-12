import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/theme_extensions.dart' show ThemeSettings;
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/shared/auth/riverpod/sign_up_controller.dart';

class SentOtpButton extends ConsumerWidget {
  const SentOtpButton({super.key, required this.onSendOtpCode});

  final VoidCallback onSendOtpCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Disabled (and visibly greyed) until the number is valid.
    final enabled = ref.watch(authController.select((s) => s.phoneValid));
    return CustomInkButton(
      onTap: onSendOtpCode,
      enabled: enabled,
      borderRadius: SizeM.commonBorderRadius.r,
      height: 56.h,
      alignment: Alignment.center,
      child: Text(
        Translation.send_verification_code.tr,
        style: context.bodyLarge.copyWith(
          fontWeight: FontWeightM.medium,
          color: ColorM.white,
        ),
      ),
    );
  }
}
