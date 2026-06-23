import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

/// Replaces the rate CTA the moment a rating is accepted, so the customer sees
/// their feedback was received along with the stars they gave.
class OrderRatedConfirmation extends StatelessWidget {
  final int overall;

  const OrderRatedConfirmation({super.key, required this.overall});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16.w,
        16.h,
        16.w,
        context.bottomSafeAreaPadding + 16.h,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: ColorM.lightGreen,
          borderRadius: BorderRadius.circular(SizeM.commonBorderRadius.r),
          border: Border.all(color: ColorM.primary100, width: 1.w),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: ColorM.primary600,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check_rounded, color: ColorM.white, size: 22.sp),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Translation.rating_submitted.tr,
                    style: context.bodyMedium.copyWith(
                      color: ColorM.greenPrimary,
                      fontWeight: FontWeightM.semiBold,
                      height: 1.2,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    Translation.rating_thanks.tr,
                    style: context.labelMedium.copyWith(
                      color: ColorM.gray600,
                      height: 1.2,
                    ),
                  ),
                  8.verticalSpace,
                  _Stars(filled: overall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Read-only star row, forced LTR so it always fills left-to-right like the
/// rating sheet.
class _Stars extends StatelessWidget {
  final int filled;

  const _Stars({required this.filled});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        return Padding(
          padding: EdgeInsets.only(right: i == 4 ? 0.0 : 4.w),
          child: SvgPicture.asset(
            Assets.svg.star.path,
            width: 16.sp,
            height: 16.sp,
            colorFilter: ColorFilter.mode(
              i < filled ? ColorM.gold : ColorM.gray300,
              BlendMode.srcIn,
            ),
          ),
        );
      }),
    );
  }
}
