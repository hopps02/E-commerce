import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/shapes/gradient_border_side.dart';
import 'package:store/app/ui_kit/forms/otp_field.dart';
import 'package:store/data/response/auth/auth_response.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/spacing_manager.dart';

class Otp extends StatelessWidget {
  final Function(String) onOtp;
  const Otp({super.key, required this.onOtp});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: OtpField(
        length: otpCodeLength,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: SpaceM.s1,
        mainAxisSize: MainAxisSize.max,
        // 6 fields (backend code length) need a slimmer field to fit the row.
        fieldWidth: 48,
        fieldHeight: 48,
        unselectedFieldDecoration: ShapeDecoration(
          shape: SmoothRectangleBorder(
            smoothness: 1,
            borderRadius: BorderRadius.circular(12.r),
            side: GradientBorderSide(color: ColorM.gray200, width: 1.w),
          ),
          color: ColorM.white,
        ),
        selectedFieldDecoration: ShapeDecoration(
          shape: SmoothRectangleBorder(
            smoothness: 1,
            borderRadius: BorderRadius.circular(12.r),
            side: GradientBorderSide(
              gradient: LinearGradient(
                colors: [ColorM.primary, ColorM.greenPrimary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              width: 1,
            ),
          ),
          color: ColorM.gray200,
        ),
        textStyle: context.bodyLarge.copyWith(fontWeight: FontWeightM.semiBold),
        hintStyle: context.bodyLarge.copyWith(
          fontWeight: FontWeightM.semiBold,
          color: ColorM.gray300,
        ),
        hintText: '_',
        onChanged: onOtp,
        onComplete: onOtp,
      ),
    );
  }
}
