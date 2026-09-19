import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/app/ui_kit/animations/animated_on_appear.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/shapes/gradient_border_side.dart';
import 'package:store/presentation/common/general_padding.dart';
import 'package:store/presentation/common/notification_bell.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/presentation/common/riverpod/location_controller.dart';
import 'package:store/presentation/views/user/addresses/view/widgets/address_picker_bottom_sheet.dart';
import 'package:store/presentation/views/user/cart/riverpod/cart_controller.dart';
import 'package:store/presentation/views/user/cart/riverpod/checkout_controller.dart';
import 'package:store/presentation/res/spacing_manager.dart';
import 'package:store/presentation/res/radius_manager.dart';

class HomeTapAppBar extends StatelessWidget {
  const HomeTapAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 0,
      expandedHeight: context.bySize(
        mobile: 125,
        tablet: 150.0,
        desktop: 170.0,
        largeDesktop: 175.0,
      ),
      backgroundColor: ColorM.transparent,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: const TopAppBarContent().slide,
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: const BottomAppBarContent().slide,
      ),
    );
  }
}

class TopAppBarContent extends ConsumerWidget {
  const TopAppBarContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationCity = ref.watch(
      locationController.select((s) => s.locationCity),
    );

    return GeneralPadding(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: context.topSafeAreaPadding + 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(Translation.deliver_to.tr, style: context.labelLarge),
                  SpaceM.s2.verticalSpace,
                  CustomInkButton(
                    onTap: () async {
                      final picked = await AddressPickerBottomSheet.show(
                        context,
                        ref,
                      );
                      if (picked == null) return;
                      if (ref.read(cartController).isEmpty) {
                        await ref
                            .read(locationController.notifier)
                            .setSelectedAddress(picked);
                        return;
                      }
                      await ref
                          .read(checkoutController.notifier)
                          .selectAddress(picked);
                    },
                    padding: EdgeInsets.symmetric(vertical: SpaceM.s2, horizontal: SpaceM.s1),
                    borderRadius: RadiusM.xs.r,
                    backgroundColor: ColorM.gray100,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: SpaceM.s1,
                      children: [
                        SvgPicture.asset(
                          Assets.svg.location.path,
                          width: 18,
                          height: 18,
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            locationCity ?? Translation.select_your_location.tr,
                            maxLines: 1,
                            style: context.labelMedium.copyWith(
                              color: ColorM.gray600,
                            ),
                          ),
                        ),
                        RotatedBox(
                          quarterTurns: 2,
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 16,
                            color: ColorM.gray600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                textDirection: TextDirection.ltr,
                children: [
                  const NotificationBell(),
                  SpaceM.s3.horizontalSpace,
                  SvgPicture.asset(
                    Assets.svg.logo.path,
                    width: 20,
                    fit: BoxFit.cover,
                    // colorFilter: ColorFilter.mode(
                    //   ColorM.primary700,
                    //   BlendMode.srcIn,
                    // ),
                  ),
                ],
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
      padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding, vertical: SpaceM.s1),
      child: CustomInkButton(
        onTap: () {
          context.pushNamed(Routes.search);
        },
        height: 45,
        padding: EdgeInsets.symmetric(horizontal: SpaceM.s4.w),
        backgroundColor: ColorM.white,
        borderRadius: RadiusM.md.r,
        side: GradientBorderSide(color: ColorM.gray300, width: 1.w),
        child: Row(
          spacing: SpaceM.s2,
          children: [
            SvgPicture.asset(
              Assets.svg.search.path,
              width: 18,
              height: 18,
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
    slideDistance: 125,
    child: this,
  );
}
