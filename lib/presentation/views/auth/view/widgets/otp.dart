import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/app/ui_components/gradient_border_side.dart' as gradient_border;
import 'package:jar/app/ui_components/otp_field.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';

class Otp extends StatelessWidget {
  final Function(String) onOtp;
  const Otp({super.key, required this.onOtp});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: OtpField(
        length: 5,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 5.w,
        mainAxisSize: MainAxisSize.max,
        fieldWidth: 54.w,
        fieldHeight: 54.w,
        unselectedFieldDecoration: ShapeDecoration(
          shape: gradient_border.SmoothRectangleBorder(
            smoothness: 1,
            borderRadius: BorderRadius.circular(12.r),
            side: gradient_border.BorderSide(color: ColorM.gray200, width: 1.w),
          ),
          color: ColorM.white,
        ),
        selectedFieldDecoration: ShapeDecoration(
          shape: gradient_border.SmoothRectangleBorder(
            smoothness: 1,
            borderRadius: BorderRadius.circular(12.r),
            side: gradient_border.BorderSide(
              gradient: LinearGradient(
                colors: [ColorM.primary, ColorM.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              width: 1.w,
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
