import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:store/app/ui_kit/shapes/gradient_border_side.dart'
    as gradient_border;
import 'package:store/presentation/res/spacing_manager.dart';
import 'package:store/presentation/res/radius_manager.dart';

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({super.key});

  static Future<bool?> show(BuildContext context) async {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) => const LogoutBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.all(SizeM.pagePadding.dg) +
          EdgeInsets.only(
            bottom: context.bottomViewInsets + context.bottomSafeAreaPadding,
          ),
      width: double.infinity,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(RadiusM.xl.r),
            topRight: Radius.circular(RadiusM.xl.r),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: ColorM.gray300,
              borderRadius: BorderRadius.circular(RadiusM.pill.r),
            ),
          ),

          SpaceM.s8.verticalSpace,

          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: ColorM.gray50,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Assets.svg.logout.svg(
              width: 32,
              height: 32,
              colorFilter: ColorFilter.mode(ColorM.red, BlendMode.srcIn),
            ),
          ),

          SpaceM.s6.verticalSpace,

          Text(
            Translation.are_you_sure_log_out.tr,
            style: context.titleMedium.copyWith(
              fontWeight: FontWeightM.medium,
              color: ColorM.gray900,
            ),
            textAlign: TextAlign.center,
          ),

          SpaceM.s8.verticalSpace,

          Row(
            children: [
              Expanded(
                child: CustomInkButton(
                  onTap: () => Navigator.pop(context, true),
                  backgroundColor: ColorM.red,
                  height: 54,
                  borderRadius: RadiusM.md.r,
                  alignment: Alignment.center,
                  child: Text(
                    Translation.log_out.tr,
                    style: context.titleMedium.copyWith(
                      color: ColorM.white,
                      fontWeight: FontWeightM.medium,
                    ),
                  ),
                ),
              ),
              SpaceM.s4.horizontalSpace,
              Expanded(
                child: CustomInkButton(
                  onTap: () => Navigator.pop(context, false),
                  backgroundColor: ColorM.transparent,
                  side: const gradient_border.GradientBorderSide(
                    color: ColorM.gray900,
                    width: 1,
                  ),
                  height: 54,
                  borderRadius: RadiusM.md.r,
                  alignment: Alignment.center,
                  child: Text(
                    Translation.back.tr,
                    style: context.titleMedium.copyWith(
                      color: ColorM.gray900,
                      fontWeight: FontWeightM.medium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
