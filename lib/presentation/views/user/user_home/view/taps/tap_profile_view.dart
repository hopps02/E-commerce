import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/extensions/guest_gate.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/customized_smart_refresh.dart';
import 'package:store/presentation/common/general_padding.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/user_home/riverpod/profile_controller.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/logout_button.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/profile_info.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/profile_settings.dart';
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
    final isGuest = ref.watch(isGuestProvider);

    return isGuest.when(
      data: (guest) => guest ? _buildGuestScaffold() : _buildCustomerScaffold(),
      loading: _buildLoadingScaffold,
      error: (_, _) => _buildLoadingScaffold(),
    );
  }

  Widget _buildCustomerScaffold() {
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
                  ProfileInfo().premiumAppear(index: 0),
                  24.verticalSpace,
                  ProfileSettings().premiumAppear(index: 1),
                  16.verticalSpace,
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

  Widget _buildGuestScaffold() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: context.topSafeAreaPadding),
                28.verticalSpace,
                Text(
                  Translation.profile.tr,
                  style: context.titleLarge.copyWith(
                    fontWeight: FontWeightM.bold,
                    color: ColorM.gray900,
                  ),
                ).premiumAppear(index: 0),
                28.verticalSpace,
                _GuestProfileState().premiumAppear(index: 1),
                28.verticalSpace,
                const ProfileSettings(guestMode: true).premiumAppear(index: 2),
                SizedBox(height: widget.bottomSafeAreaPadding),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingScaffold() {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(child: CircularProgressIndicator(color: ColorM.primary500)),
    );
  }
}

class _GuestProfileState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralPadding(
      child: Column(
        children: [
          Container(
            height: 86,
            width: 86,
            decoration: BoxDecoration(
              color: ColorM.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: ColorM.primary200.withValues(alpha: 0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: ColorM.primary100, width: 2),
            ),
            alignment: Alignment.center,
            child: Container(
              height: 76,
              width: 76,
              decoration: const BoxDecoration(
                color: ColorM.primary50,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.lock_person_rounded,
                color: ColorM.primary600,
                size: 36,
              ),
            ),
          ),
          20.verticalSpace,
          Text(
            Translation.guest_profile_title.tr,
            textAlign: TextAlign.center,
            style: context.headlineSmall.copyWith(
              fontWeight: FontWeightM.bold,
              color: ColorM.gray900,
            ),
          ),
          8.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              Translation.guest_profile_subtitle.tr,
              textAlign: TextAlign.center,
              style: context.bodyMedium.copyWith(color: ColorM.gray500),
            ),
          ),
          24.verticalSpace,
          CustomInkButton(
            onTap: () => context.goNamed(Routes.auth),
            backgroundColor: ColorM.primary500,
            borderRadius: SizeM.commonBorderRadius.r,
            height: 56,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              Translation.login.tr,
              style: context.bodyLarge.copyWith(
                color: ColorM.white,
                fontWeight: FontWeightM.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
