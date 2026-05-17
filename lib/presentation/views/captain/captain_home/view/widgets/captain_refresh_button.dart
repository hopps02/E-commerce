import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

class CaptainRefreshButton extends StatelessWidget {
  final VoidCallback onTap;
  const CaptainRefreshButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.refresh_rounded, size: 18.w, color: ColorM.primary400),
            6.horizontalSpace,
            Text(
              Translation.refresh.tr,
              style: context.labelMedium.copyWith(
                color: ColorM.primary400,
                fontSize: 15.sp,
                fontWeight: FontWeightM.regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
