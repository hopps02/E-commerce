import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jar/app/extensions/theme_extensions.dart';
import 'package:jar/app/extensions/view_extensions.dart';
import 'package:jar/app/ui_components/gradient_border_side.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';
import 'package:jar/presentation/res/sizes_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';

class DeliveryTo extends StatelessWidget {
  const DeliveryTo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      margin: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w),
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(12.r),
          side: GradientBorderSide(color: ColorM.gray250, width: 1.w),
        ),
      ),
      alignment: .centerStart,
      child: Column(
        crossAxisAlignment: .start,
        spacing: 8.h,
        children: [
          Text(
            Translation.deliver_to.tr,
            style: context.labelLarge.copyWith(
              fontWeight: FontWeightM.medium,
            ),
          ),
    
          Row(
            children: [
              SvgPicture.asset(
                Assets.svg.borderLocation.path,
                colorFilter: ColorFilter.mode(
                  ColorM.greenSecondary,
                  BlendMode.srcIn,
                ),
              ),
              11.horizontalSpace,
              Text("شارع 14 , تبوك", style: context.labelLarge),
              const Spacer(),
              Icon(
                Icons.arrow_back_ios_new_rounded,
                textDirection: context.isRTL
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                size: 20.r,
                color: ColorM.gray950,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
