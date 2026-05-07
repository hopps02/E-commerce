import 'dart:ui';
import 'package:animated_visibility/animated_visibility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jar/app/extensions/theme_extensions.dart';
import 'package:jar/app/extensions/view_extensions.dart';
import 'package:jar/app/extensions/widget_extensions.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/views/home/riverpod/bottom_navigation_controller.dart';

class NavigationItem {
  final String title;
  final String svgPath;
  final String selectedSvgPath;

  /// Custom action for a the item
  /// if 'null'     it will navigate to the screen with the same index
  /// if 'not null' it will execute the action instead of navigating
  final void Function()? onTap;

  NavigationItem({
    required this.title,
    required this.svgPath,
    required this.selectedSvgPath,
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
    return Padding(
      padding: EdgeInsets.only(bottom: context.bottomSafeAreaPadding + 8.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9999),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 13, sigmaY: 13),
          child: RepaintBoundary(
            child: Container(
              width: 343.w,
              height: 78.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(
                  color: ColorM.white.withValues(alpha: 1),
                  width: 1.w,
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

              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),

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
  });

  final WidgetRef ref;
  final bool isSelected;
  final NavigationItem item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => item.onTap != null
          ? item.onTap!()
          : ref
              .read(bottomNavigationController.notifier)
              .onBottomNavTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastEaseInToSlowEaseOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 37.w : 15.w,
          vertical: isSelected ? 10.h : 15.h,
        ),
        decoration: BoxDecoration(
          color: ColorM.white,
          borderRadius: BorderRadius.circular(isSelected ? 32.r : 32.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              isSelected ? item.selectedSvgPath : item.svgPath,
              width: 20.w,
              height: 20.w,
              colorFilter: ColorFilter.mode(
                isSelected ? ColorM.primary500 : ColorM.gray600,
                BlendMode.srcIn,
              ),
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
                    4.horizontalSpace,
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
