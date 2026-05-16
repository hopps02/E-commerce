import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/cashier/cashier_home/riverpod/cashier_tab_controller.dart';
import 'package:for_u/presentation/views/cashier/cashier_home/view/widgets/cashier_tab_button.dart';

class CashierTabsBar extends ConsumerStatefulWidget {
  const CashierTabsBar({super.key});

  @override
  ConsumerState<CashierTabsBar> createState() => _CashierTabsBarState();
}

class _CashierTabsBarState extends ConsumerState<CashierTabsBar> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cashierTabController);
    final notifier = ref.read(cashierTabController.notifier);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: ColorM.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: ColorM.primary50, width: 1.w),
      ),
      child: Row(
        children: [
          CashierTabButton(
            title: Translation.preparation.tr,
            count: 3,
            isSelected: state.selectedIndex == 0,
            onTap: () => notifier.onTabChange(0),
          ),
          4.horizontalSpace,
          CashierTabButton(
            title: Translation.on_the_way_to_customer.tr,
            count: 3,
            isSelected: state.selectedIndex == 1,
            onTap: () => notifier.onTabChange(1),
          ),
        ],
      ),
    );
  }
}
