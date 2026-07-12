import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';

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
