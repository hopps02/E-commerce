import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/presentation/views/captain/captain_home/view/widgets/captain_orders_slider.dart';
import 'package:for_u/presentation/views/captain/captain_home/view/widgets/top_app_bar.dart';

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
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [const TopAppBar()];
        },
        body: const CaptainOrdersSlider(),
      ),
    );
  }
}
