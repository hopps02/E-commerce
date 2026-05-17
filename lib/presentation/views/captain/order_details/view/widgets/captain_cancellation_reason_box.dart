import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';

class CaptainCancellationReasonBox extends StatelessWidget {
  final String reason;
  const CaptainCancellationReasonBox({super.key, required this.reason});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(6.w),
      decoration: ShapeDecoration(
        color: const Color(0xFFF3F4F6),
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translation.cancellation_reason.tr,
            style: context.labelMedium.copyWith(
              color: ColorM.gray500,
              fontSize: 13.sp,
              fontWeight: FontWeightM.regular,
              height: 1.2,
            ),
          ),
          2.verticalSpace,
          Text(
            reason,
            style: context.labelMedium.copyWith(
              color: ColorM.gray800,
              fontSize: 13.sp,
              fontWeight: FontWeightM.medium,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
