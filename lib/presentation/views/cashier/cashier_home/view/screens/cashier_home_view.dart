import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/presentation/views/cashier/cashier_home/view/widgets/cashier_orders_slider.dart';
import 'package:for_u/presentation/views/cashier/cashier_home/view/widgets/top_app_bar.dart';

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
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [TopAppBar()];
        },
        body: const CashierOrdersSlider(),
      ),
    );
  }
}
