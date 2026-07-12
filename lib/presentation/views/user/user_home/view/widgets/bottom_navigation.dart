import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/view_extensions.dart';
import 'package:store/app/ui_kit/animations/animated_on_appear.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/bottom_navigation_bar.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key, required this.bottomNavItems});

  final List<NavigationItem> bottomNavItems;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .bottomCenter,
      child: AnimatedOnAppear(
        delay: 300,
        animationTypes: {.slide},
        slideDirection: .up,
        slideDistance: context.bottomSafeAreaPadding + 8.h + 78.h,
        child: CustomBottomNavigationBar(items: bottomNavItems),
      ),
    );
  }
}
