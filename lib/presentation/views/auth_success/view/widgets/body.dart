import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/navigation_extension.dart';
import 'package:jar/app/extensions/theme_extensions.dart';
import 'package:jar/app/ui_components/custom_ink_button.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:jar/presentation/res/routes_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';
import 'package:jar/presentation/common/general_padding.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GeneralPadding(
      padding: EdgeInsets.symmetric(
        horizontal: 40.w,
      ),
      child: Column(
        children: [
          Text(
            "${Translation.welcome_to_jar.tr} 👋 ",
            textAlign: TextAlign.center,
            style: context.displaySmall.copyWith(
              fontWeight: FontWeightM.semiBold,
              color: ColorM.gray900,
              fontSize: 24.sp,
            ),
          ),
          6.verticalSpace,
          Text(
            Translation.account_created_success.tr,
            textAlign: TextAlign.center,
            style: context.bodyMedium.copyWith(
              color: ColorM.gray600,
              fontSize: 15.sp,
            ),
          ),
          31.verticalSpace,
          // Start Shopping Button
          CustomInkButton(
            onTap: () {
              context.pushNamed(RoutesManager.home.route);
            },
            borderRadius: 12.r,
            height: 50.h,
            backgroundColor: ColorM.primary,
            alignment: Alignment.center,
            child: Text(
              Translation.start_shopping.tr,
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
