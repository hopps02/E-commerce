import 'dart:ui';
import 'package:animated_visibility/animated_visibility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/app/extensions/theme_extensions.dart';
import 'package:store/app/extensions/view_extensions.dart';
import 'package:store/app/extensions/widget_extensions.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/views/user/cart/riverpod/cart_controller.dart';
import 'package:store/presentation/views/user/user_home/riverpod/bottom_navigation_controller.dart';
import 'package:store/presentation/res/spacing_manager.dart';

class NavigationItem {
  final String title;
  final String svgPath;
  final String selectedSvgPath;
  final bool isCart;
  final void Function()? onTap;

  NavigationItem({
    required this.title,
    required this.svgPath,
    required this.selectedSvgPath,
    this.isCart = false,
    this.onTap,
  });
}

class CustomBottomNavigationBar extends ConsumerStatefulWidget {
  final List<NavigationItem> items;
  const CustomBottomNavigationBar({super.key, required this.items});

  @override
  ConsumerState<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState
    extends ConsumerState<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final bottomNavState = ref.watch(bottomNavigationController);
    final cartCount = ref.watch(cartController.select((s) => s.itemsCount));
    return Padding(
      padding: EdgeInsets.only(bottom: context.bottomSafeAreaPadding + 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9999),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 13, sigmaY: 13),
          child: RepaintBoundary(
            child: Container(
              width: 343,
              height: 78,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(
                  color: ColorM.white.withValues(alpha: 1),
                  width: 1,
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    ColorM.white.withValues(alpha: 0.2),
                    ColorM.white.withValues(alpha: 0.05),
                    ColorM.gray800.withValues(alpha: 0.05),
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),

              padding: EdgeInsets.symmetric(horizontal: SpaceM.s3, vertical: SpaceM.s4),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(widget.items.length, (index) {
                  final item = widget.items[index];
                  final isSelected = bottomNavState.selectedIndex == index;

                  return Button(
                    ref: ref,
                    isSelected: isSelected,
                    item: item,
                    index: index,
                    badgeCount: item.isCart ? cartCount : 0,
                  ).pluseAnimation(index + 8);
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.ref,
    required this.isSelected,
    required this.item,
    required this.index,
    this.badgeCount = 0,
  });

  final WidgetRef ref;
  final bool isSelected;
  final NavigationItem item;
  final int index;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => item.onTap != null
          ? item.onTap!()
          : ref.read(bottomNavigationController.notifier).onBottomNavTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastEaseInToSlowEaseOut,
        // The same height whichever tab is on: only the width and the
        // colour change. A taller unselected pill used to push past the bar.
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? SpaceM.s10 : SpaceM.s4,
          vertical: SpaceM.s3,
        ),
        decoration: BoxDecoration(
          color: ColorM.white,
          borderRadius: BorderRadius.circular(isSelected ? 32.r : 32.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(
                  isSelected ? item.selectedSvgPath : item.svgPath,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    isSelected ? ColorM.primary500 : ColorM.gray600,
                    BlendMode.srcIn,
                  ),
                ),
                if (badgeCount > 0)
                  PositionedDirectional(
                    top: -7,
                    end: -9,
                    child: Container(
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: SpaceM.s1),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorM.primary500,
                        borderRadius: BorderRadius.circular(9999),
                        border: Border.all(color: ColorM.white, width: 1.5),
                      ),
                      child: Text(
                        badgeCount > 99 ? '99+' : '$badgeCount',
                        style: context.labelLarge.copyWith(
                          color: ColorM.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            AnimatedVisibility(
              visible: isSelected,
              enterDuration: const Duration(milliseconds: 300),
              exitDuration: const Duration(milliseconds: 300),
              enter:
                  fadeIn(curve: Curves.fastEaseInToSlowEaseOut) +
                  expandHorizontally(curve: Curves.fastEaseInToSlowEaseOut),
              exit:
                  fadeOut(curve: Curves.fastEaseInToSlowEaseOut) +
                  shrinkHorizontally(curve: Curves.fastEaseInToSlowEaseOut),
              child: Align(
                alignment: .centerStart,
                child: Row(
                  mainAxisSize: .min,
                  children: [
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      item.title,
                      style: context.labelLarge.copyWith(
                        color: ColorM.primary500,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
