import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/navigation_extension.dart';
import 'package:for_u/app/extensions/theme_extensions.dart';
import 'package:for_u/app/ui_components/custom_ink_button.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/common/general_padding.dart';
import 'package:for_u/app/enums/enums.dart';

import '../../../../../app/ui_components/gradient_border_side.dart';

class Body extends StatelessWidget {
  final SuccessViewType successViewType;
  const Body({super.key, required this.successViewType});

  @override
  Widget build(BuildContext context) {
    return GeneralPadding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        children: [
          Text(
            successViewType.isAuth
                ? "${Translation.welcome_to_jar.tr} 👋 "
                : Translation.order_placed_successfully.tr,
            textAlign: TextAlign.center,
            style: context.displaySmall.copyWith(
              fontWeight: FontWeightM.semiBold,
              color: successViewType.isAuth ? ColorM.gray900 : ColorM.white,
              fontSize: successViewType.isAuth ? 24.sp : 28.sp,
            ),
          ),
          8.verticalSpace,
          Text(
            successViewType.isAuth
                ? Translation.account_created_success.tr
                : "${Translation.order_number.tr} #GOC-23456757",
            textAlign: TextAlign.center,
            style: context.bodyMedium.copyWith(
              color: successViewType.isAuth ? ColorM.gray600 : ColorM.white,
              fontSize: 15.sp,
            ),
          ),
          31.verticalSpace,
          // Start Shopping Button
          CustomInkButton(
            onTap: () {
              if (successViewType.isOrder) {
                context.popUntilNamed(Routes.home);
              } else {
                context.goNamed(Routes.home);
              }
            },
            borderRadius: 12.r,
            height: 50.h,
            backgroundColor: successViewType.isAuth
                ? ColorM.primary
                : ColorM.transparent,
            alignment: Alignment.center,
            side: successViewType.isAuth
                ? GradientBorderSide.none
                : GradientBorderSide(color: ColorM.white, width: 1.r),
            child: Text(
              successViewType.isAuth
                  ? Translation.start_shopping.tr
                  : Translation.view_order.tr,
              style: context.bodyLarge.copyWith(
                fontWeight: FontWeightM.semiBold,
                color: ColorM.white,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
