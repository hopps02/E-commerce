import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/presentation/views/cashier/cashier_home/riverpod/cashier_tab_controller.dart';
import 'package:for_u/presentation/views/cashier/cashier_home/view/widgets/cashier_orders_data.dart';

class CashierOrdersSlider extends ConsumerWidget {
  const CashierOrdersSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(cashierTabController.notifier);
    return CarouselSlider(
      carouselController: notifier.carouselController,
      options: CarouselOptions(
        height: double.infinity,
        viewportFraction: 1.0,
        enableInfiniteScroll: false,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index, reason) {
          if (reason == CarouselPageChangedReason.manual) {
            notifier.onTabChange(index);
          }
        },
      ),
      items: const [
        CashierOrdersData(type: CashierOrdersDataType.preparation),
        CashierOrdersData(type: CashierOrdersDataType.onTheWay),
        CashierOrdersData(type: CashierOrdersDataType.exceptions),
      ],
    );
  }
}
