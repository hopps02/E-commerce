import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_components/custom_cached_image.dart';
import 'package:for_u/app/ui_components/custom_ink_button.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';

class CashierPreparationCard extends StatelessWidget {
  final bool requiresCaptain;
  final VoidCallback onTapAction;

  const CashierPreparationCard({
    super.key,
    required this.requiresCaptain,
    required this.onTapAction,
  });

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      children: [
        const _OrderHeader(),
        12.verticalSpace,
        const _Divider(),
        12.verticalSpace,
        const _ProductsRow(),
        12.verticalSpace,
        const _LocationRow(),
        12.verticalSpace,
        const _Divider(),
        12.verticalSpace,
        _PrimaryActionButton(
          title: requiresCaptain
              ? Translation.assign_captain.tr
              : Translation.prepare_order.tr,
          onTap: onTapAction,
        ),
      ],
    );
  }
}

class CashierOnTheWayCard extends StatelessWidget {
  final VoidCallback onTapDetails;

  const CashierOnTheWayCard({super.key, required this.onTapDetails});

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      children: [
        const _OrderHeader(),
        12.verticalSpace,
        const _Divider(),
        12.verticalSpace,
        const _ProductsRow(),
        12.verticalSpace,
        const _CaptainAndLocationRow(),
        12.verticalSpace,
        const _Divider(),
        12.verticalSpace,
        _OnTheWayFooter(onTapDetails: onTapDetails),
      ],
    );
  }
}

class _CardShell extends StatelessWidget {
  final List<Widget> children;
  const _CardShell({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(15.r),
          side: BorderSide(color: ColorM.gray250, width: 1.w),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

class _OrderHeader extends StatelessWidget {
  const _OrderHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '#6757',
          textDirection: TextDirection.ltr,
          style: context.bodyMedium.copyWith(
            fontWeight: FontWeightM.medium,
            color: ColorM.gray400,
          ),
        ),

        Text(
          easy.DateFormat(
            "MMMM d, yyyy h:mm a",
            context.locale.languageCode,
          ).format(DateTime.now()),
          style: context.labelMedium.copyWith(color: ColorM.gray600),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(height: 1.h, color: ColorM.gray250);
  }
}

class _ProductsRow extends StatelessWidget {
  const _ProductsRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: ShapeDecoration(
        color: ColorM.primary50.withValues(alpha: 0.4),
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Translation.product_count.trNamed({'count': '2'}),
                  style: context.bodyMedium.copyWith(
                    color: ColorM.gray900,
                    fontWeight: FontWeightM.medium,
                  ),
                ),
                Text(
                  'جزر أصفر (Hills Farm) · جزر شانتينيه',
                  style: context.labelLarge.copyWith(color: ColorM.gray700),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          12.horizontalSpace,
          const _ProductImagesStack(),
        ],
      ),
    );
  }
}

class _ProductImagesStack extends StatelessWidget {
  const _ProductImagesStack();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 67.w,
      height: 52.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: 21.w,
            child: Transform.rotate(
              angle: -19 * (math.pi / 180),
              child: _productThumb(
                'https://picsum.photos/100',
                offset: Offset(-5, 10),
              ),
            ),
          ),
          Positioned(
            right: 4.w,
            top: 6.h,
            child: Transform.rotate(
              angle: 15 * (math.pi / 180),
              child: _productThumb(
                'https://picsum.photos/400',
                offset: Offset(5, 10),
              ),
            ),
          ),
          Positioned(
            child: CustomCachedImage(
              imageUrl: 'https://picsum.photos/300',
              width: 38.w,
              height: 42.h,
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productThumb(String url, {required Offset offset}) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        boxShadow: [
          BoxShadow(
            color: ColorM.gray1000.withValues(alpha: 0.1),
            blurRadius: 3,
            offset: offset,
          ),
        ],
      ),
      child: CustomCachedImage(
        imageUrl: url,
        width: 38.w,
        height: 42.h,
        borderRadius: BorderRadius.circular(6.r),
      ),
    );
  }
}

class _LocationRow extends StatelessWidget {
  const _LocationRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          Assets.svg.location.path,
          width: 18.w,
          height: 18.w,
          colorFilter: const ColorFilter.mode(ColorM.gray950, BlendMode.srcIn),
        ),
        6.horizontalSpace,
        Expanded(
          child: Text(
            'شارع 14 , تبوك',
            style: context.labelLarge.copyWith(color: ColorM.gray950),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _CaptainAndLocationRow extends StatelessWidget {
  const _CaptainAndLocationRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 10.w,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                Assets.svg.borderLocation.path,
                width: 18.w,
                height: 18.w,
                colorFilter: const ColorFilter.mode(
                  ColorM.gray950,
                  BlendMode.srcIn,
                ),
              ),
              6.horizontalSpace,
              Flexible(
                child: Text(
                  'شارع 14 , تبوك',
                  style: context.labelLarge.copyWith(color: ColorM.gray950),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Translation.captain_label.tr,
                style: context.labelLarge.copyWith(color: ColorM.gray950),
              ),
              6.horizontalSpace,
              ClipOval(
                child: CustomCachedImage(
                  imageUrl: 'https://i.pravatar.cc/100?img=12',
                  width: 21.w,
                  height: 21.w,
                ),
              ),
              6.horizontalSpace,
              Flexible(
                child: Text(
                  'عماد مجدي ',
                  style: context.labelLarge.copyWith(color: ColorM.gray700),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrimaryActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const _PrimaryActionButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: onTap,
      height: 42.h,
      backgroundColor: ColorM.primary50,
      borderRadius: 29.r,
      smoothness: 1,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      tap: const ButtonAnimationSettings(
        ButtonAnimation.scaleTap,
        intensity: 0.2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: context.labelLarge.copyWith(
              color: ColorM.primary500,
              fontWeight: FontWeightM.semiBold,
            ),
          ),
          4.horizontalSpace,
          _LeadingArrow(color: ColorM.primary500),
        ],
      ),
    );
  }
}

class _OnTheWayFooter extends StatelessWidget {
  final VoidCallback onTapDetails;
  const _OnTheWayFooter({required this.onTapDetails});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 7.w,
              height: 7.w,
              decoration: const BoxDecoration(
                color: Color(0xFFF59E0B),
                shape: BoxShape.circle,
              ),
            ),
            6.horizontalSpace,
            Text(
              Translation.out_for_delivery.tr,
              style: context.labelLarge.copyWith(
                color: const Color(0xFFF59E0B),
                fontWeight: FontWeightM.medium,
              ),
            ),
          ],
        ),
        CustomInkButton(
          onTap: onTapDetails,
          height: 42.h,
          backgroundColor: ColorM.primary50,
          borderRadius: 29.r,
          smoothness: 1,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          tap: const ButtonAnimationSettings(
            ButtonAnimation.scaleTap,
            intensity: 0.2,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Translation.view_details.tr,
                style: context.labelLarge.copyWith(
                  color: ColorM.primary500,
                  fontWeight: FontWeightM.medium,
                ),
              ),
              4.horizontalSpace,
              _LeadingArrow(color: ColorM.primary500),
            ],
          ),
        ),
        
      ],
    );
  }
}

class _LeadingArrow extends StatelessWidget {
  final Color color;
  const _LeadingArrow({required this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_circle_left_rounded,
      size: 18.w,
      color: color,
    );
  }
}
