import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/presentation/views/user/user_home/riverpod/bottom_navigation_controller.dart';
import 'package:for_u/presentation/views/user/user_home/view/taps/tap_user_home_view.dart';
import 'package:for_u/presentation/views/user/user_home/view/taps/tap_cart_view.dart';
import 'package:for_u/presentation/views/user/user_home/view/taps/tap_my_orders_view.dart';

import 'package:for_u/presentation/views/user/user_home/view/taps/tap_profile_view.dart';

class PageSlider extends ConsumerWidget {
  const PageSlider({super.key, required this.bottomSafeAreaPadding});

  final double bottomSafeAreaPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNavNotifier = ref.read(bottomNavigationController.notifier);

    return CarouselSlider(
      items: [
        TapHomeView(bottomSafeAreaPadding: bottomSafeAreaPadding),
        TapCartView(bottomSafeAreaPadding: bottomSafeAreaPadding),
        TapMyOrdersView(bottomSafeAreaPadding: bottomSafeAreaPadding),
        TapProfileView(bottomSafeAreaPadding: bottomSafeAreaPadding), // Profile
      ],
      options: CarouselOptions(
        viewportFraction: 1,
        aspectRatio: 1,
        height: double.infinity,
        enableInfiniteScroll: false,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        padEnds: false,
        animateToClosest: false,
        onPageChanged: (tapIndex, carouselPageChangedReason) {
          if (carouselPageChangedReason == CarouselPageChangedReason.manual) {
            bottomNavNotifier.onBottomNavTap(tapIndex);
          }
        },
      ),
      carouselController: bottomNavNotifier.bottomNavBarSliderController,
    );
  }
}
