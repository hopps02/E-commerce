import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jar/presentation/views/home/riverpod/my_orders_tab_controller.dart';
import 'package:jar/presentation/views/home/view/widgets/my_orders_data.dart';

class MyOrdersSlider extends ConsumerWidget {
  const MyOrdersSlider({super.key, required this.bottomSafeAreaPadding});
  final double bottomSafeAreaPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(myOrdersTabController.notifier);
    return Expanded(
      child: CarouselSlider(
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
        items: [
          MyOrdersData(
            bottomSafeAreaPadding: bottomSafeAreaPadding,
            myOrdersDataType: MyOrdersDataType.current,
          ),
          MyOrdersData(
            bottomSafeAreaPadding: bottomSafeAreaPadding,
            myOrdersDataType: MyOrdersDataType.previous,
          ),
        ],
      ),
    );
  }
}
