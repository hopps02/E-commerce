import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/customized_smart_refresh.dart';
import 'package:for_u/presentation/views/user/user_home/riverpod/profile_controller.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/logout_button.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/profile_info.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/profile_settings.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TapProfileView extends ConsumerStatefulWidget {
  final double bottomSafeAreaPadding;
  const TapProfileView({super.key, required this.bottomSafeAreaPadding});

  @override
  ConsumerState<TapProfileView> createState() => _TapProfileViewState();
}

class _TapProfileViewState extends ConsumerState<TapProfileView>
    with AutomaticKeepAliveClientMixin {
  final RefreshController _refreshController = RefreshController();

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomizedSmartRefresh(
        controller: _refreshController,
        onRefresh: () =>
            ref.read(profileController.notifier).refresh(_refreshController),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: context.topSafeAreaPadding),
                  28.verticalSpace,
                  // App Bar equivalent
                  ProfileInfo().premiumAppear(index: 0),
                  24.verticalSpace,

                  // Menu Container
                  ProfileSettings().premiumAppear(index: 1),

                  16.verticalSpace,

                  // Logout Button
                  LogoutButton().premiumAppear(index: 2),

                  SizedBox(height: widget.bottomSafeAreaPadding),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
