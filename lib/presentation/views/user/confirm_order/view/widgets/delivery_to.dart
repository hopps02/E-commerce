import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store/app/extensions/theme_extensions.dart';
import 'package:store/app/extensions/view_extensions.dart';
import 'package:store/app/ui_kit/shapes/gradient_border_side.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';

class DeliveryTo extends StatelessWidget {
  final String address;
  const DeliveryTo({super.key, required this.address});

  bool get _isEmpty => address.trim().isEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16.h),
      margin: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w),
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(12.r),
          side: GradientBorderSide(
            color: _isEmpty ? ColorM.primary500 : ColorM.gray250,
            width: 1.w,
          ),
        ),
      ),
      alignment: .centerStart,
      child: Column(
        crossAxisAlignment: .start,
        spacing: 8,
        children: [
          Text(
            Translation.deliver_to.tr,
            style: context.labelLarge.copyWith(fontWeight: FontWeightM.medium),
          ),

          Row(
            children: [
              SvgPicture.asset(
                Assets.svg.borderLocation.path,
                colorFilter: ColorFilter.mode(
                  _isEmpty ? ColorM.primary500 : ColorM.greenSecondary,
                  BlendMode.srcIn,
                ),
              ),
              11.horizontalSpace,
              Expanded(
                child: Text(
                  _isEmpty ? Translation.add_address.tr : address,
                  style: context.labelLarge.copyWith(
                    color: _isEmpty ? ColorM.primary500 : null,
                    fontWeight: _isEmpty ? FontWeightM.medium : null,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.arrow_back_ios_new_rounded,
                textDirection: context.isRTL
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                size: 20.r,
                color: _isEmpty ? ColorM.primary500 : ColorM.gray950,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
