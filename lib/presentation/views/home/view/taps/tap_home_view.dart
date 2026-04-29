import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jar/app/ui_components/customized_smart_refresh.dart';
import 'package:jar/presentation/views/home/riverpod/tap_home_contaroller.dart';
import 'package:jar/presentation/views/home/view/widgets/content_body.dart';
import 'package:jar/presentation/views/home/view/widgets/home_tap_app_bar.dart';

class TapHomeView extends ConsumerStatefulWidget {
  final double bottomSafeAreaPadding;
  const TapHomeView({super.key, required this.bottomSafeAreaPadding});

  @override
  ConsumerState<TapHomeView> createState() => _TapHomeViewState();
}

class _TapHomeViewState extends ConsumerState<TapHomeView>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final tapHomeState = ref.watch(tapHomeController);
    final tapHomeNotifier = ref.read(tapHomeController.notifier);
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [HomeTapAppBar()];
      },
      body: ContentBody(bottomSafeAreaPadding: widget.bottomSafeAreaPadding,),
      // slivers: [
      //   HomeTapAppBar(),
      //   ContentBody(),
      //   SliverToBoxAdapter(
      //     child: SizedBox(height: widget.bottomSafeAreaPadding),
      //   ),
      // ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
