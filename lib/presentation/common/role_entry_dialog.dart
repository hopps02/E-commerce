import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:smooth_corner/smooth_corner.dart';

/// Dev-only role switcher. Pops the dialog and returns the chosen home route,
/// or `null` if the user dismisses. Call once at the natural "enter the app"
/// junctions (onboarding "next", auth-success CTA) so we can jump into any
/// role's home without rewiring real role-based routing.
class RoleEntryDialog {
  static Future<Routes?> show(BuildContext context) {
    return showDialog<Routes>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.4),
      builder: (_) => const _RoleEntryDialog(),
    );
  }
}

class _RoleEntryDialog extends StatelessWidget {
  const _RoleEntryDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: ShapeDecoration(
          color: ColorM.white,
          shape: SmoothRectangleBorder(
            smoothness: 1,
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter as',
              textAlign: TextAlign.center,
              style: context.titleMedium.copyWith(
                color: ColorM.gray900,
                fontWeight: FontWeightM.semiBold,
                fontSize: 18.sp,
              ),
            ),
            6.verticalSpace,
            Text(
              'Pick which role\'s home you want to land in',
              textAlign: TextAlign.center,
              style: context.labelMedium.copyWith(
                color: ColorM.gray600,
                fontSize: 12.sp,
              ),
            ),
            18.verticalSpace,
            _RoleButton(
              label: 'User',
              route: Routes.home,
              backgroundColor: ColorM.primary500,
            ),
            10.verticalSpace,
            _RoleButton(
              label: 'Cashier',
              route: Routes.cashierHome,
              backgroundColor: const Color(0xFF109642),
            ),
            10.verticalSpace,
            _RoleButton(
              label: 'Captain',
              route: Routes.captainHome,
              backgroundColor: const Color(0xFFF59E0B),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleButton extends StatelessWidget {
  final String label;
  final Routes route;
  final Color backgroundColor;

  const _RoleButton({
    required this.label,
    required this.route,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: () => Navigator.of(context).pop(route),
      height: 48.h,
      borderRadius: 14.r,
      smoothness: 1,
      backgroundColor: backgroundColor,
      alignment: Alignment.center,
      tap: const ButtonAnimationSettings(
        ButtonAnimation.scaleTap,
        intensity: 0.2,
      ),
      child: Text(
        label,
        style: context.bodyLarge.copyWith(
          color: ColorM.white,
          fontWeight: FontWeightM.medium,
          fontSize: 15.sp,
        ),
      ),
    );
  }
}
