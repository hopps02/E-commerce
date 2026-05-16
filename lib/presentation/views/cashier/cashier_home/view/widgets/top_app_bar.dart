import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_components/custom_form_field/simple_form.dart';
import 'package:for_u/presentation/common/general_padding.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/cashier/cashier_home/view/widgets/cashier_header_actions.dart';
import 'package:for_u/presentation/views/cashier/cashier_home/view/widgets/cashier_tabs_bar.dart';
import 'package:smooth_corner/smooth_corner.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 0,
      expandedHeight: 255.h,
      backgroundColor: ColorM.transparent,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: const _TopSection(),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(128.h),
        child: const _BottomSection(),
      ),
    );
  }
}

class _TopSection extends StatelessWidget {
  const _TopSection();

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
                      Text(
                        Translation.welcome_back.trNamed({"name": "Ahmed"}),
                        style: context.labelMedium.copyWith(
                          color: ColorM.white,
                          fontWeight: FontWeightM.semiBold,
                          fontSize: 18.sp,
                        ),
                      ),
                      21.verticalSpace,
                      const CashierHeaderActions(),
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
  const _BottomSection();

  @override
  Widget build(BuildContext context) {
    return GeneralPadding(
      child: Column(
        children: [
          16.verticalSpace,
          const CashierTabsBar(),
          16.verticalSpace,
          SimpleForm(
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
              colorFilter: const ColorFilter.mode(
                ColorM.gray600,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
