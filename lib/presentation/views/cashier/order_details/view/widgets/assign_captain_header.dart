import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';

class AssignCaptainHeader extends StatelessWidget {
  final VoidCallback onClose;
  final String? title;
  const AssignCaptainHeader({super.key, required this.onClose, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Row(
            children: [
              CustomInkButton(
                onTap: onClose,
                width: 28.w,
                height: 28.w,
                padding: EdgeInsets.zero,
                borderRadius: 999,
                backgroundColor: const Color(0xFFFEE2E2),
                alignment: Alignment.center,
                tap: const ButtonAnimationSettings(
                  ButtonAnimation.scaleTap,
                  intensity: 0.2,
                ),
                child: Icon(
                  Icons.close_rounded,
                  size: 16.sp,
                  color: const Color(0xFFDC2626),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      title ?? Translation.assign_captain.tr,
                      style: context.bodyLarge.copyWith(
                        color: const Color(0xFF231F20),
                        fontWeight: FontWeightM.medium,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Container(height: 1.h, color: ColorM.primary50),
        ],
      ),
    );
  }
}
