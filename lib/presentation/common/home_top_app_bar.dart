import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/forms/simple_form.dart';
import 'package:for_u/presentation/common/general_padding.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';

/// Shared sliver app bar for the cashier and captain home screens.
///
/// The shell (clipped primary header, background shapes, welcome text and the
/// search field) is identical between roles; the role-specific parts are passed
/// in as slots:
/// - [headerActions]: the actions row under the welcome text
///   (e.g. the shared HomeHeaderActions).
/// - [tabsBar]: the tabs row (e.g. CashierTabsBar / CaptainTabsBar).
/// - [headerTrailing]: optional widget shown next to the welcome text
///   (the captain's availability switch); omit it for the cashier.
/// - [tabsAboveSearch]: whether the tabs sit above the search field
///   (cashier) or below it (captain).
class HomeTopAppBar extends StatelessWidget {
  const HomeTopAppBar({
    super.key,
    this.welcomeName = "Ahmed",
    required this.headerActions,
    required this.tabsBar,
    this.headerTrailing,
    this.tabsAboveSearch = true,
  });

  final String welcomeName;
  final Widget headerActions;
  final Widget tabsBar;
  final Widget? headerTrailing;
  final bool tabsAboveSearch;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 0,
      expandedHeight: 255.h,
      backgroundColor: ColorM.transparent,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: _TopSection(
        welcomeName: welcomeName,
        headerActions: headerActions,
        headerTrailing: headerTrailing,
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(128.h),
        child: _BottomSection(
          tabsBar: tabsBar,
          tabsAboveSearch: tabsAboveSearch,
        ),
      ),
    );
  }
}

class _TopSection extends StatelessWidget {
  const _TopSection({
    required this.welcomeName,
    required this.headerActions,
    this.headerTrailing,
  });

  final String welcomeName;
  final Widget headerActions;
  final Widget? headerTrailing;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      background: Padding(
        padding: EdgeInsets.only(bottom: 128.h),
        child: ClipRRect(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24.r),
            bottomRight: Radius.circular(24.r),
          ),
          child: Stack(
            children: [
              SmoothContainer(
                smoothness: 1,
                color: ColorM.primary800,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24.r),
                  bottomRight: Radius.circular(24.r),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset(Assets.svg.backgroundOfShaps.path),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: GeneralPadding(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.topSafeAreaPadding),
                      22.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              Translation.welcome_back.trNamed({
                                "name": welcomeName,
                              }),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: context.labelMedium.copyWith(
                                color: ColorM.white,
                                fontWeight: FontWeightM.semiBold,
                                fontSize: 18.sp,
                                height: 1.1,
                              ),
                            ),
                          ),
                          ?headerTrailing,
                        ],
                      ),
                      21.verticalSpace,
                      headerActions,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomSection extends StatelessWidget {
  const _BottomSection({required this.tabsBar, required this.tabsAboveSearch});

  final Widget tabsBar;
  final bool tabsAboveSearch;

  @override
  Widget build(BuildContext context) {
    // Subscribe to easy_localization's inherited widget so this section
    // rebuilds when the user changes language. Without this line the parent
    // SliverAppBar's `bottom` slot keeps handing us the same const child and
    // Flutter skips the rebuild — leaving the tabs / search hint stale.
    context.locale;

    final search = SimpleForm(
      height: 44.h,
      fontSize: 14.sp,
      borderRadius: 99999,
      removeBorders: false,
      borderColor: ColorM.gray300,
      hintText: Translation.search_hint.tr,
      keyboardType: TextInputType.text,
      controller: TextEditingController(),
      prefixWidget: SvgPicture.asset(
        Assets.svg.search.path,
        width: 18.w,
        height: 18.w,
        colorFilter: const ColorFilter.mode(ColorM.gray600, BlendMode.srcIn),
      ),
    );

    return GeneralPadding(
      child: Column(
        children: tabsAboveSearch
            ? [16.verticalSpace, tabsBar, 16.verticalSpace, search]
            : [search, 14.verticalSpace, tabsBar],
      ),
    );
  }
}
