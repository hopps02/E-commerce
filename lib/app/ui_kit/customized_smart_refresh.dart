import 'package:store/app/extensions/theme_extensions.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomizedSmartRefresh extends StatelessWidget {
  final Widget child;
  final RefreshController controller;
  final ScrollController? scrollController;
  final void Function()? onLoading;
  final void Function()? onRefresh;
  final bool enableLoading;
  final bool enableRefresh;
  final EdgeInsetsGeometry? classicFooterPadding;
  final ScrollPhysics? physics;

  const CustomizedSmartRefresh({
    super.key,
    required this.child,
    required this.controller,
    this.scrollController,
    this.onLoading,
    this.onRefresh,
    this.enableLoading = false,
    this.enableRefresh = true,
    this.classicFooterPadding,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    final refresher = _buildRefresher(context);
    if (!enableLoading) return refresher;

    // Web / desktop infinite scroll: SmartRefresher's pull-up only fires on an
    // overscroll drag, which mouse-wheel scrolling never produces — so lists
    // would stall at the footer. Listen for the scroll approaching the bottom
    // and trigger the load through the package's own requestLoading(), which
    // respects the current footer status (idle only → no double-loads, and it
    // won't fire when there's no more data or a load is in flight).
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;
        if (metrics.axis == Axis.vertical &&
            metrics.hasContentDimensions &&
            metrics.pixels >= metrics.maxScrollExtent - 320 &&
            controller.footerStatus == LoadStatus.idle) {
          controller.requestLoading(needMove: false);
        }
        return false;
      },
      child: refresher,
    );
  }

  Widget _buildRefresher(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      scrollController: scrollController,
      enablePullUp: enableLoading,
      enablePullDown: enableRefresh,
      physics: physics,
      header: ClassicHeader(
        idleIcon: Icon(Icons.arrow_downward, color: ColorM.primary),
        releaseIcon: Icon(Icons.refresh, color: ColorM.primary),
        refreshingIcon: SizedBox(
          width: 25.0,
          height: 50.0,
          child: Center(
            child: SizedBox(
              width: 25.0,
              height: 25.0,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(ColorM.primary),
              ),
            ),
          ),
        ),

        idleText: '',
        refreshingText: '',
        completeText: '',
        failedText: '',
        releaseText: '',
        canTwoLevelText: '',
        textStyle: TextStyle(fontSize: 0, height: 0),
      ),
      footer: ClassicFooter(
        outerBuilder: (child) {
          return Padding(
            padding: classicFooterPadding ?? EdgeInsets.zero,
            child: child,
          );
        },
        textStyle: context.labelSmall.copyWith(
          color: ColorM.gray900.withValues(alpha: .5),
          fontWeight: FontWeightM.medium,
        ),
        loadingText: Translation.loading.tr,
        noDataText: Translation.no_more.tr,
        failedText: Translation.failed_loading.tr,
        idleText: Translation.load_more.tr,
        canLoadingText: Translation.load_more.tr,
        spacing: 12,
        height: 50 + (classicFooterPadding?.vertical ?? 0),
        loadingIcon: SizedBox(
          width: 15,
          height: 15,
          child: CircularProgressIndicator(
            color: ColorM.primary,
            valueColor: AlwaysStoppedAnimation<Color>(ColorM.primary),
            backgroundColor: Colors.transparent,
            strokeWidth: 2.2,
            strokeCap: StrokeCap.round,
          ),
        ),
      ),
      onLoading: onLoading,
      onRefresh: onRefresh != null
          ? () {
              HapticFeedback.mediumImpact();
              onRefresh!();
            }
          : null,
      child: child,
    );
  }
}
