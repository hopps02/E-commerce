import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/theme_extensions.dart' show ThemeSettings;
import 'package:jar/app/ui_components/custom_ink_button.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:jar/presentation/res/sizes_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';

class SentOtpButton extends StatelessWidget {
  const SentOtpButton({
    super.key,
    required this.onSendOtpCode,
  });

  final VoidCallback onSendOtpCode;

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: onSendOtpCode,
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
