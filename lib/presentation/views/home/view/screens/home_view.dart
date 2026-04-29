import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';
import 'package:jar/presentation/res/sizes_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';
import 'package:jar/presentation/views/home/view/widgets/bottom_navigation.dart';
import 'package:jar/presentation/views/home/view/widgets/bottom_navigation_bar.dart';
import 'package:jar/presentation/views/home/view/widgets/gradient_background.dart';
import 'package:jar/presentation/views/home/view/widgets/page_slider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  late List<NavigationItem> bottomNavItems;

  void initializeBottomNavItems() {
    bottomNavItems = [
      NavigationItem(
        title: Translation.home.tr,
        svgPath: Assets.svg.borderHome.path,
        selectedSvgPath: Assets.svg.fillHome.path,
      ),
      NavigationItem(
        title: Translation.cart.tr,
        svgPath: Assets.svg.borderBag.path,
        selectedSvgPath: Assets.svg.borderBag.path,
      ),
      NavigationItem(
        title: Translation.my_orders.tr,
        svgPath: Assets.svg.borderReceipt.path,
        selectedSvgPath: Assets.svg.fillReceipt.path,
      ),
      NavigationItem(
        title: Translation.profile.tr,
        svgPath: Assets.svg.borderUser.path,
        selectedSvgPath: Assets.svg.borderUser.path,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final double bottomSafeAreaPadding =
        context.bottomSafeAreaPadding + 8.h + 78.h + SizeM.pagePadding.h;

    initializeBottomNavItems();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Stack(
            children: [
              PageSlider(bottomSafeAreaPadding: bottomSafeAreaPadding),

              GradientBackground(),

              BottomNavigation(bottomNavItems: bottomNavItems),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
