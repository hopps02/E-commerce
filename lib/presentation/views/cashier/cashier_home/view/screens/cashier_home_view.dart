import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/services/new_order_alarm_service.dart';
import 'package:for_u/presentation/common/home_header_actions.dart';
import 'package:for_u/presentation/common/home_top_app_bar.dart';
import 'package:for_u/presentation/common/notification_bell.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/views/cashier/cashier_home/riverpod/cashier_tab_controller.dart';
import 'package:for_u/presentation/views/cashier/cashier_home/view/widgets/cashier_orders_slider.dart';
import 'package:for_u/presentation/views/cashier/cashier_home/view/widgets/cashier_tabs_bar.dart';
import 'package:for_u/presentation/views/cashier/cashier_home/view/widgets/new_order_alert_banner.dart';

class CashierHomeView extends ConsumerStatefulWidget {
  const CashierHomeView({super.key});

  @override
  ConsumerState<CashierHomeView> createState() => _CashierHomeViewState();
}

class _CashierHomeViewState extends ConsumerState<CashierHomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    NewOrderAlarmService().stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ref.listen(
      cashierTabController.select((s) => s.hasNewOrder),
      (previous, next) {
        if (next) {
          NewOrderAlarmService().start();
          return;
        }
        NewOrderAlarmService().stop();
      },
    );

    final cashierName = ref.watch(
      cashierTabController.select((s) => s.cashierName),
    );
    final alertState = ref.watch(
      cashierTabController.select(
        (s) => (hasNewOrder: s.hasNewOrder, newOrderCount: s.newOrderCount),
      ),
    );
    final notifier = ref.read(cashierTabController.notifier);

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                HomeTopAppBar(
                  welcomeName: cashierName,
                  headerActions: const HomeHeaderActions(),
                  tabsBar: const CashierTabsBar(),
                  headerTrailing: const NotificationBell(dark: true),
                  tabsAboveSearch: true,
                ),
              ];
            },
            body: const CashierOrdersSlider(),
          ),
          if (alertState.hasNewOrder)
            PositionedDirectional(
              top: context.topSafeAreaPadding + 92.h,
              start: SizeM.pagePadding.w,
              end: SizeM.pagePadding.w,
              child: NewOrderAlertBanner(
                newOrderCount: alertState.newOrderCount,
                onViewOrders: notifier.onViewNewOrder,
                onDismiss: notifier.dismissNewOrder,
              ),
            ),
        ],
      ),
    );
  }
}
