import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/app/ui_components/custom_ink_button.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:jar/presentation/res/sizes_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';

class VerifyOtpButton extends StatelessWidget {
  final VoidCallback onTap;
  const VerifyOtpButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: onTap,
      borderRadius: SizeM.commonBorderRadius.r,
      height: 56.h,
      alignment: Alignment.center,
      child: Text(
        Translation.confirm.tr,
        style: context.bodyLarge.copyWith(
          fontWeight: FontWeightM.medium,
          color: ColorM.white,
        ),
      ),
    );
  }
}
