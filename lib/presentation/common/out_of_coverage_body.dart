import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

class OutOfCoverageBody extends StatelessWidget {
  final VoidCallback? onRetry;

  const OutOfCoverageBody({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w),
          child: Column(
            children: [
              24.verticalSpace,
              const _UnavailablePill(),
              32.verticalSpace,
              SvgPicture.asset(
                Assets.svg.locationMap.path,
                width: 288.w,
                height: 208.h,
                fit: BoxFit.fitWidth,
              ),
              // 32.verticalSpace,
              Text(
                Translation.out_of_delivery_range.tr,
                textAlign: TextAlign.center,
                style: context.headlineSmall.copyWith(
                  color: ColorM.gray950,
                  fontWeight: FontWeightM.bold,
                  letterSpacing: -0.6,
                ),
              ),
              16.verticalSpace,
              Text(
                Translation.out_of_delivery_range_desc.tr,
                textAlign: TextAlign.center,
                style: context.bodyMedium.copyWith(
                  color: ColorM.gray600,
                  height: 1.5,
                ),
              ),
              24.verticalSpace,
              _RetryButton(onTap: onRetry),
              24.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}

class _UnavailablePill extends StatelessWidget {
  const _UnavailablePill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorM.gray150,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: const BoxDecoration(
              color: ColorM.primary,
              shape: BoxShape.circle,
            ),
          ),
          8.horizontalSpace,

          Flexible(
            child: Text(
              Translation.service_unavailable_in_area.tr,
              textAlign: TextAlign.center,
              style: context.labelMedium.copyWith(
                color: ColorM.primary,
                fontWeight: FontWeightM.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RetryButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _RetryButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: () => onTap?.call(),
      enabled: onTap != null,
      height: 50.h,
      width: double.infinity,
      borderRadius: SizeM.commonBorderRadius.r,
      backgroundColor: ColorM.primary500,
      alignment: Alignment.center,
      tap: const ButtonAnimationSettings(
        ButtonAnimation.scaleTap,
        intensity: 0.2,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.refresh_rounded, color: ColorM.white, size: 20.sp),
          8.horizontalSpace,
          Text(
            Translation.retry_button.tr,
            style: context.bodyLarge.copyWith(
              color: ColorM.white,
              fontWeight: FontWeightM.medium,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
