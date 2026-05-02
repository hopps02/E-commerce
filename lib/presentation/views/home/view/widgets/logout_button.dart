import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';
import 'package:jar/presentation/res/translations_manager.dart';
import 'package:jar/presentation/views/home/view/widgets/logout_bottom_sheet.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        LogoutBottomSheet.show(context);
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 40.w,
          vertical: 12.h,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.svg.logout.svg(
              width: 24.w,
              height: 24.w,
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
                fontWeight: FontWeightM.medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
