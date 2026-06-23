import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/presentation/common/home_header_actions.dart';
import 'package:for_u/presentation/common/home_top_app_bar.dart';
import 'package:for_u/presentation/common/notification_bell.dart';
import 'package:for_u/presentation/views/cashier/cashier_home/riverpod/cashier_tab_controller.dart';
import 'package:for_u/presentation/views/cashier/cashier_home/view/widgets/cashier_orders_slider.dart';
import 'package:for_u/presentation/views/cashier/cashier_home/view/widgets/cashier_tabs_bar.dart';

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
  Widget build(BuildContext context) {
    super.build(context);
    final cashierName = ref.watch(
      cashierTabController.select((s) => s.cashierName),
    );
    return Scaffold(
      body: NestedScrollView(
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
    );
  }
}
