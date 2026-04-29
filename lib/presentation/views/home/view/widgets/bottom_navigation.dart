import 'package:flutter/material.dart';
import 'package:jar/presentation/views/home/view/widgets/bottom_navigation_bar.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.bottomNavItems,
  });

  final List<NavigationItem> bottomNavItems;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .bottomCenter,
      child: CustomBottomNavigationBar(items: bottomNavItems),
    );
  }
}
