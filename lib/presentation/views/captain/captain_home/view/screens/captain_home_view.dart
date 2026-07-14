import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/presentation/common/home_header_actions.dart';
import 'package:store/presentation/common/home_top_app_bar.dart';
import 'package:store/presentation/common/notification_bell.dart';
import 'package:store/presentation/views/captain/captain_home/riverpod/captain_tab_controller.dart';
import 'package:store/presentation/views/captain/captain_home/view/widgets/captain_availability_switch.dart';
import 'package:store/presentation/views/captain/captain_home/view/widgets/captain_orders_slider.dart';
import 'package:store/presentation/views/captain/captain_home/view/widgets/captain_tabs_bar.dart';

class CaptainHomeView extends ConsumerStatefulWidget {
  const CaptainHomeView({super.key});

  @override
  ConsumerState<CaptainHomeView> createState() => _CaptainHomeViewState();
}

class _CaptainHomeViewState extends ConsumerState<CaptainHomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final captainName = ref.watch(
      captainHomeController.select((s) => s.captainName),
    );
    return Scaffold(
      body: ResponsiveConstrained(
        maxWidth: 450,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              HomeTopAppBar(
                welcomeName: captainName,
                headerActions: const HomeHeaderActions(),
                tabsBar: const CaptainTabsBar(),
                headerTrailing: const _CaptainHeaderTrailing(),
                tabsAboveSearch: false,
              ),
            ];
          },
          body: const CaptainOrdersSlider(),
        ),
      ),
    );
  }
}

class _CaptainHeaderTrailing extends StatelessWidget {
  const _CaptainHeaderTrailing();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const NotificationBell(dark: true),
        12.horizontalSpace,
        const CaptainAvailabilitySwitch(),
      ],
    );
  }
}
