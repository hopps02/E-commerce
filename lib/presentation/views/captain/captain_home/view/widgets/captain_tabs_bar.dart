import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/captain/captain_home/riverpod/captain_tab_controller.dart';
import 'package:store/presentation/views/captain/captain_home/view/widgets/captain_tab_button.dart';

class CaptainTabsBar extends ConsumerWidget {
  const CaptainTabsBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    context.locale;
    final state = ref.watch(captainHomeController);
    final notifier = ref.read(captainHomeController.notifier);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 3.h),
      decoration: BoxDecoration(
        color: ColorM.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: ColorM.primary50, width: 1.w),
      ),
      child: Row(
        children: [
          CaptainTabButton(
            title: Translation.upcoming_orders.tr,
            isSelected: state.selectedIndex == 0,
            onTap: () => notifier.onTabChange(0),
          ),
          4.horizontalSpace,
          CaptainTabButton(
            title: Translation.on_the_way_to_customer.tr,
            isSelected: state.selectedIndex == 1,
            onTap: () => notifier.onTabChange(1),
          ),
          4.horizontalSpace,
          CaptainTabButton(
            title: Translation.completed_orders.tr,
            isSelected: state.selectedIndex == 2,
            onTap: () => notifier.onTabChange(2),
          ),
        ],
      ),
    );
  }
}
