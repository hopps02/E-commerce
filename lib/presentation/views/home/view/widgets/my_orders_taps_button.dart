import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/presentation/res/translations_manager.dart';
import 'package:jar/presentation/views/home/riverpod/my_orders_tab_controller.dart';
import 'package:jar/presentation/views/home/view/widgets/my_order_tap_button.dart';

class MyOrdersTapsButton extends ConsumerWidget {
  const MyOrdersTapsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myOrdersTabController);
    final notifier = ref.read(myOrdersTabController.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyOrderTapButton(
          title: Translation.ongoing_orders.tr,
          isSelected: state.selectedIndex == 0,
          onTap: () => notifier.onTabChange(0),
        ),
        8.horizontalSpace,
        MyOrderTapButton(
          title: Translation.previous_orders.tr,
          isSelected: state.selectedIndex == 1,
          onTap: () => notifier.onTabChange(1),
        ),
      ],
    );
  }
}
