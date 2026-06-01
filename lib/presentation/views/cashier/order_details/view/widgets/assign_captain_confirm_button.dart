import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/cashier/order_details/riverpod/assign_captain_controller.dart';

class AssignCaptainConfirmButton extends StatelessWidget {
  final PickedCaptain? selected;
  final VoidCallback onConfirm;

  const AssignCaptainConfirmButton({
    super.key,
    required this.selected,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = selected != null;
    return CustomInkButton(
      onTap: enabled ? onConfirm : null,
      enabled: enabled,
      height: 56.h,
      width: double.infinity,
      borderRadius: SizeM.commonBorderRadius.r,
      backgroundColor:
          enabled ? ColorM.primary500 : const Color(0xFF9CA3AF),
      alignment: Alignment.center,
      tap: const ButtonAnimationSettings(
        ButtonAnimation.scaleTap,
        intensity: 0.2,
      ),
      child: Text(
        enabled
            ? Translation.assign_name.trNamed({'name': selected!.name})
            : Translation.select_captain.tr,
        style: context.bodyLarge.copyWith(
          color: ColorM.white,
          fontWeight: FontWeightM.medium,
          height: 1.5,
        ),
      ),
    );
  }
}
