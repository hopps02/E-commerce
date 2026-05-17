import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/presentation/views/captain/captain_home/riverpod/captain_tab_controller.dart';
import 'package:for_u/presentation/views/captain/captain_home/view/widgets/captain_orders_data.dart';

class CaptainOrdersSlider extends ConsumerWidget {
  const CaptainOrdersSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(captainHomeController.notifier);
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
        CaptainOrdersData(type: CaptainOrdersDataType.upcoming),
        CaptainOrdersData(type: CaptainOrdersDataType.inDelivery),
        CaptainOrdersData(type: CaptainOrdersDataType.completed),
      ],
    );
  }
}
