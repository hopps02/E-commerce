import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/logout_bottom_sheet.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            LogoutBottomSheet.show(context);
          },
          borderRadius: BorderRadius.circular(20.r),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              color: ColorM.red.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: ColorM.red.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.svg.logout.svg(
                  width: 22.w,
                  height: 22.w,
                  colorFilter: const ColorFilter.mode(
                    ColorM.red,
                    BlendMode.srcIn,
                  ),
                ),
                12.horizontalSpace,
                Text(
                  Translation.log_out.tr,
                  style: context.titleMedium.copyWith(
                    color: ColorM.red,
                    fontWeight: FontWeightM.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
