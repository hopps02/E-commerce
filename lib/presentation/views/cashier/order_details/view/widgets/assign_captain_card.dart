import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/custom_cached_image.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/app/ui_kit/shapes/gradient_border_side.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/data/response/cashier/cashier_response.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

class AssignCaptainCard extends StatelessWidget {
  final AvailableCaptain captain;
  final bool isSelected;
  final VoidCallback onTap;

  const AssignCaptainCard({
    super.key,
    required this.captain,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: onTap,
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      borderRadius: 16.r,
      smoothness: 1,
      backgroundColor: isSelected ? ColorM.primary50 : ColorM.white,
      side: GradientBorderSide(
        color: isSelected ? ColorM.primary500 : ColorM.primary50,
        width: 1.w,
      ),
      tap: const ButtonAnimationSettings(
        ButtonAnimation.scaleTap,
        intensity: 0.15,
      ),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          ClipOval(
            // No captain avatars exist in the backend; the cached image's
            // own placeholder renders for the empty URL.
            child: CustomCachedImage(imageUrl: '', width: 45.w, height: 45.w),
          ),
          6.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        captain.name ?? '',
                        style: context.labelLarge.copyWith(
                          color: const Color(0xFF231F20),
                          fontWeight: FontWeightM.semiBold,
                          height: 20 / 14,
                        ),
                      ),
                    ),
                  ],
                ),
                4.verticalSpace,
                Text(
                  Translation.completed_today.trNamed({
                    'count': '${captain.completedToday}',
                  }),
                  style: context.labelLarge.copyWith(
                    color: const Color(0xFF6A7282),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          8.horizontalSpace,
          Text(
            captain.phone ?? '',
            textDirection: TextDirection.ltr,
            style: context.labelMedium.copyWith(
              color: const Color(0xFF6A7282),
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
