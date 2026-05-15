import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_components/gradient_border_side.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

class OrderDeliveryAddress extends StatelessWidget {
  const OrderDeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(12.r),
          side: GradientBorderSide(color: ColorM.gray200, width: 1.w),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${Translation.deliver_to.tr} :",
            style: context.bodyMedium.copyWith(
              fontWeight: FontWeightM.bold,
              color: ColorM.gray950,
            ),
          ),
          12.verticalSpace,
          Row(
            children: [
              SvgPicture.asset(
                Assets.svg.borderLocation.path,
                colorFilter: ColorFilter.mode(
                  ColorM.greenSecondary,
                  BlendMode.srcIn,
                ),
              ),
              8.horizontalSpace,
              Text(
                "شارع 14 , تبوك",
                style: context.bodyMedium.copyWith(color: ColorM.gray950),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
