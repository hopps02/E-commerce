import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/extensions/navigation_extension.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/logout_bottom_sheet.dart';
import 'package:store/presentation/res/spacing_manager.dart';
import 'package:store/presentation/res/radius_manager.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  Future<void> _logout(BuildContext context) async {
    final confirmed = await LogoutBottomSheet.show(context);
    if (confirmed != true) return;

    DI().loadingService.show();
    await DI().sessionService.logout();
    DI().loadingService.hide();

    if (context.mounted) context.goNamed(Routes.auth);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SpaceM.s4.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _logout(context),
          borderRadius: BorderRadius.circular(RadiusM.lg.r),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: SpaceM.s4.h),
            decoration: BoxDecoration(
              color: ColorM.red.withOpacity(0.05),
              borderRadius: BorderRadius.circular(RadiusM.lg.r),
              border: Border.all(
                color: ColorM.red.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.svg.logout.svg(
                  width: 22,
                  height: 22,
                  colorFilter: ColorFilter.mode(
                    ColorM.red,
                    BlendMode.srcIn,
                  ),
                ),
                SpaceM.s3.horizontalSpace,
                Text(
                  Translation.log_out.tr,
                  style: context.titleMedium.copyWith(
                    color: ColorM.red,
                    fontWeight: FontWeightM.bold,
                    fontSize: 16,
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
