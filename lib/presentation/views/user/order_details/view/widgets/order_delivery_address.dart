import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/shapes/gradient_border_side.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/res/spacing_manager.dart';
import 'package:store/presentation/res/radius_manager.dart';

class OrderDeliveryAddress extends StatelessWidget {
  final String address;
  const OrderDeliveryAddress({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SpaceM.s4, vertical: SpaceM.s4.h),
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(RadiusM.sm.r),
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
          SpaceM.s3.verticalSpace,
          Row(
            children: [
              SvgPicture.asset(
                Assets.svg.borderLocation.path,
                colorFilter: ColorFilter.mode(
                  ColorM.greenSecondary,
                  BlendMode.srcIn,
                ),
              ),
              SpaceM.s2.horizontalSpace,
              Text(
                address,
                style: context.bodyMedium.copyWith(color: ColorM.gray950),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
