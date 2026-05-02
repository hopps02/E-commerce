import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/app/ui_components/animations/animated_on_appear.dart';
import 'package:jar/app/ui_components/custom_ink_button.dart';
import 'package:jar/app/ui_components/gradient_border_side.dart';
import 'package:jar/presentation/common/general_padding.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';
import 'package:jar/presentation/res/routes_manager.dart';
import 'package:jar/presentation/res/sizes_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';

class HomeTapAppBar extends StatelessWidget {
  const HomeTapAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 0,
      expandedHeight: 125.h,
      backgroundColor: ColorM.transparent,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: TopAppBarContent().slide,
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(55.h),
        child: BottomAppBarContent().slide,
      ),
    );
  }
}

class TopAppBarContent extends StatelessWidget {
  const TopAppBarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralPadding(
      child: Align(
        alignment: .topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: context.topSafeAreaPadding + 4.h),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .center,
            children: [
              Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  Text(Translation.deliver_to.tr, style: context.labelLarge),
                  8.verticalSpace,
                  CustomInkButton(
                    onTap: () {},
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 4.w,
                    ),
                    borderRadius: 8.r,
                    backgroundColor: ColorM.gray100,
                    child: Row(
                      mainAxisSize: .min,
                      spacing: 4.w,
                      children: [
                        SvgPicture.asset(
                          Assets.svg.location.path,
                          width: 18.sp,
                          height: 18.sp,
                        ),
                        Text(
                          "السوق القديم , تبوك",
                          style: context.labelMedium.copyWith(
                            color: ColorM.gray600,
                          ),
                        ),
                        RotatedBox(
                          quarterTurns: 2,
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 16.sp,
                            color: ColorM.gray600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(
                Assets.svg.appLogo.path,
                width: 22.w,
                height: 49.h,
                fit: .cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomAppBarContent extends StatelessWidget {
  const BottomAppBarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeM.pagePadding.w,
        vertical: 3.h,
      ),
      child: CustomInkButton(
        onTap: () {
          context.pushNamed(RoutesManager.search.route);
        },
        height: 45.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        backgroundColor: ColorM.white,
        borderRadius: 14.r,
        side: GradientBorderSide(
          color: ColorM.gray300,
          width: 1.w,
        ),
        child: Row(
          spacing: 8.w,
          children: [
            SvgPicture.asset(
              Assets.svg.search.path,
              width: 18.w,
              height: 18.w,
              colorFilter: ColorFilter.mode(ColorM.gray600, BlendMode.srcIn),
            ),
            Text(
              Translation.search_hint.tr,
              style: context.bodyMedium.copyWith(color: ColorM.gray600),
            ),
          ],
        ),
      ),
    );
  }
}

extension _Delay on Widget {
  Widget get slide => AnimatedOnAppear(
    delay: 300,
    animationTypes: {.slide},
    slideDirection: .down,
    slideDistance: 125.h,
    child: this,
  );
}
