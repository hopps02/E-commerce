import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/shared/auth/view/widgets/otp_bottom_sheet.dart';

class OtpBottomSheetTitle extends StatelessWidget {
  const OtpBottomSheetTitle({super.key, required this.widget});

  final OtpBottomSheet widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.h,
      crossAxisAlignment: .start,
      children: [
        Text(
          Translation.confirm_mobile_number.tr,
          style: context.headlineSmall.copyWith(
            fontWeight: FontWeightM.semiBold,
          ),
        ),
        RichText(
          textScaler: context.textScaler,
          text: TextSpan(
            style: context.bodyMedium.copyWith(
              color: ColorM.gray500,
              fontSize: 13.sp,
            ),
            children: [
              TextSpan(text: Translation.verification_code_sent_part1.tr),
              TextSpan(
                text: ' ${widget.mobileNumber} ',
                style: TextStyle(
                  color: ColorM.primary,
                  fontWeight: FontWeightM.medium,
                ),
              ),
              TextSpan(text: Translation.verification_code_sent_part2.tr),
            ],
          ),
        ),
      ],
    );
  }
}
