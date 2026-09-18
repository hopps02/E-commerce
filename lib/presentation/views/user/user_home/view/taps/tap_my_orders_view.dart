import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/my_orders_app_bar.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/my_orders_slider.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/my_orders_taps_button.dart';
import 'package:store/app/extensions/widget_extensions.dart';
import 'package:store/presentation/views/user/user_home/riverpod/bottom_navigation_controller.dart';
import 'package:store/presentation/views/user/user_home/riverpod/my_orders_tab_controller.dart';

class TapMyOrdersView extends ConsumerStatefulWidget {
  static const int navIndex = 2;

  final double bottomSafeAreaPadding;
  const TapMyOrdersView({super.key, required this.bottomSafeAreaPadding});

  @override
  ConsumerState<TapMyOrdersView> createState() => _TapMyOrdersViewState();
}

class _TapMyOrdersViewState extends ConsumerState<TapMyOrdersView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // The tab is kept alive, so re-selecting it would otherwise show whatever
    // the orders were the first time it opened. Staff move orders along from
    // the panel; this is when the customer sees that.
    ref.listen(bottomNavigationController.select((s) => s.selectedIndex), (
      _,
      next,
    ) {
      final notifier = ref.read(myOrdersTabController.notifier);

      if (next == TapMyOrdersView.navIndex) {
        notifier.loadInitial();
        notifier.setLive(true);
        return;
      }

      notifier.setLive(false);
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          MyOrdersAppBar().premiumAppear(index: 0),
          34.verticalSpace,
          MyOrdersTapsButton().premiumAppear(index: 1),
          16.verticalSpace,
          MyOrdersSlider(bottomSafeAreaPadding: widget.bottomSafeAreaPadding),
        ],
      ),
    );
  }
}
