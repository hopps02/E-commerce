import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/extensions/guest_gate.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/user_home/riverpod/bottom_navigation_controller.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/bottom_navigation.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/bottom_navigation_bar.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/gradient_background.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/page_slider.dart';

class UserHomeView extends ConsumerStatefulWidget {
  const UserHomeView({super.key});

  @override
  ConsumerState<UserHomeView> createState() => _UserHomeViewState();
}

class _UserHomeViewState extends ConsumerState<UserHomeView>
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
        isCart: true,
        onTap: () {
          context.pushNamed(Routes.cart);
        },
      ),
      NavigationItem(
        title: Translation.my_orders.tr,
        svgPath: Assets.svg.borderReceipt.path,
        selectedSvgPath: Assets.svg.fillReceipt.path,
        onTap: () async {
          if (!await requireLogin(context, ref)) return;
          ref.read(bottomNavigationController.notifier).onBottomNavTap(2);
        },
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

              BottomNavigation(
                bottomNavItems: bottomNavItems,
              ).containerSlideUp(),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
