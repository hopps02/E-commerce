import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/my_orders_app_bar.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/my_orders_slider.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/my_orders_taps_button.dart';
import 'package:for_u/app/extensions/widget_extensions.dart';

class TapMyOrdersView extends ConsumerStatefulWidget {
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
