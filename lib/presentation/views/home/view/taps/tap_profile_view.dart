import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';
import 'package:jar/presentation/res/translations_manager.dart';
import 'package:jar/presentation/views/home/view/widgets/delete_account_bottom_sheet.dart';
import 'package:jar/presentation/views/home/view/widgets/logout_bottom_sheet.dart';
import 'package:jar/presentation/views/home/view/widgets/logout_button.dart';
import 'package:jar/presentation/views/home/view/widgets/profile_info.dart';
import 'package:jar/presentation/views/home/view/widgets/profile_menu_item.dart';
import 'package:jar/presentation/views/home/view/widgets/profile_settings.dart';

class TapProfileView extends ConsumerStatefulWidget {
  final double bottomSafeAreaPadding;
  const TapProfileView({super.key, required this.bottomSafeAreaPadding});

  @override
  ConsumerState<TapProfileView> createState() => _TapProfileViewState();
}

class _TapProfileViewState extends ConsumerState<TapProfileView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
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
    );
  }
}
