import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/captain/captain_home/riverpod/captain_tab_controller.dart';

class CaptainAvailabilitySwitch extends ConsumerWidget {
  const CaptainAvailabilitySwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAvailable = ref.watch(
      captainHomeController.select((s) => s.isAvailable),
    );
    final notifier = ref.read(captainHomeController.notifier);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          isAvailable ? Translation.available_status.tr : Translation.busy.tr,
          style: context.labelMedium.copyWith(
            color: ColorM.white,
            fontWeight: FontWeightM.semiBold,
            fontSize: 14.sp,
            height: 1,
          ),
        ),
        8.horizontalSpace,
        _Pill(isAvailable: isAvailable, onTap: notifier.toggleAvailability),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  final bool isAvailable;
  final VoidCallback onTap;

  const _Pill({required this.isAvailable, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const trackOn = Color(0xFF22C55E);
    final trackOff = ColorM.white.withValues(alpha: 0.25);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: 42.w,
        height: 24.h,
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: isAvailable ? trackOn : trackOff,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Stack(
          alignment: isAvailable
              ? AlignmentDirectional.centerStart
              : AlignmentDirectional.centerEnd,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              width: 20.w,
              height: 20.w,
              decoration: const BoxDecoration(
                color: ColorM.white,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
