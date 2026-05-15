import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:for_u/app/ui_components/custom_ink_button.dart';
import 'package:for_u/app/ui_components/gradient_border_side.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

class CashierHeaderActions extends StatelessWidget {
  final VoidCallback? onLogout;
  final VoidCallback? onLanguage;
  final VoidCallback? onSupport;

  const CashierHeaderActions({
    super.key,
    this.onLogout,
    this.onLanguage,
    this.onSupport,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _GlassButton(
            title: Translation.support.tr,
            iconPath: Assets.svg.messages.path,
            onTap: onSupport ?? () {},
          ),
        ),
        8.horizontalSpace,
        Expanded(
          flex: 2,
          child: _GlassButton(
            title: Translation.language.tr,
            iconPath: Assets.svg.language2.path,
            onTap: onLanguage ?? () {},
          ),
        ),
        8.horizontalSpace,
        Expanded(
          flex: 3,
          child: _GlassButton(
            title: Translation.log_out.tr,
            iconPath: Assets.svg.logout2.path,
            onTap: onLogout ?? () {},
          ),
        ),
      ],
    );
  }
}

class _GlassButton extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  const _GlassButton({
    required this.title,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: onTap,
      height: 33.h,
      borderRadius: 14.r,
      backgroundColor: ColorM.white.withValues(alpha: 0.12),
      glassBlur: 10,
      keepBorderCrisp: true,
      tap: const ButtonAnimationSettings(
        ButtonAnimation.scaleTap,
        intensity: 0.3,
      ),
      side: GradientBorderSide.glassyOutline(width: 1.w),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 18.w,
            height: 18.w,
            colorFilter: const ColorFilter.mode(ColorM.white, BlendMode.srcIn),
          ),
          5.horizontalSpace,
          Flexible(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: FontsM.ibmPlexSansArabic.name,
                fontSize: 14.sp,
                fontWeight: FontWeightM.regular,
                color: ColorM.white,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
