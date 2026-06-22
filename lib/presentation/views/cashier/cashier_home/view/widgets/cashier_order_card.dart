import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/enums/enums.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/custom_cached_image.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/data/response/cashier/cashier_response.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';

class CashierPreparationCard extends StatelessWidget {
  final CashierOrder order;
  final VoidCallback onTapAction;

  const CashierPreparationCard({
    super.key,
    required this.order,
    required this.onTapAction,
  });

  bool get _requiresCaptain =>
      order.uiStatus == CashierOrderStatus.readyForCaptain;

  @override
  Widget build(BuildContext context) {
    context.locale;
    return _CardShell(
      children: [
        _OrderHeader(
          orderNumber: order.orderNumber,
          createdAt: order.createdAt,
        ),
        12.verticalSpace,
        const _Divider(),
        12.verticalSpace,
        _ProductsRow(order: order),
        12.verticalSpace,
        _LocationRow(address: order.addressLine),
        12.verticalSpace,
        const _Divider(),
        12.verticalSpace,
        _PrimaryActionButton(
          title: _requiresCaptain
              ? Translation.assign_captain.tr
              : Translation.prepare_order.tr,
          onTap: onTapAction,
        ),
      ],
    );
  }
}

class CashierOnTheWayCard extends StatelessWidget {
  final CashierOrder order;
  final VoidCallback onTapDetails;

  const CashierOnTheWayCard({
    super.key,
    required this.order,
    required this.onTapDetails,
  });

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      children: [
        _OrderHeader(
          orderNumber: order.orderNumber,
          createdAt: order.createdAt,
        ),
        12.verticalSpace,
        const _Divider(),
        12.verticalSpace,
        _ProductsRow(order: order),
        12.verticalSpace,
        _CaptainAndLocationRow(
          address: order.addressLine,
          captainName: order.captain?.name ?? '',
        ),
        12.verticalSpace,
        const _Divider(),
        12.verticalSpace,
        _OnTheWayFooter(
          delivered: order.uiStatus == CashierOrderStatus.delivered,
          onTapDetails: onTapDetails,
        ),
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
  final String orderNumber;
  final DateTime? createdAt;

  const _OrderHeader({required this.orderNumber, required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '#$orderNumber',
          textDirection: TextDirection.ltr,
          style: context.bodyMedium.copyWith(
            fontWeight: FontWeightM.medium,
            color: ColorM.gray400,
          ),
        ),

        Text(
          createdAt == null
              ? ''
              : easy.DateFormat(
                  "MMMM d, yyyy h:mm a",
                  context.locale.languageCode,
                ).format(createdAt!.toLocal()),
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
  final CashierOrder order;
  const _ProductsRow({required this.order});

  @override
  Widget build(BuildContext context) {
    final arabic = context.locale.languageCode == 'ar';
    final items = order.activeItems;
    final summary = items.map((item) => item.name(arabic)).join(' · ');
    final count = order.itemsCount ?? items.length;

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
                  Translation.product_count.trNamed({'count': '$count'}),
                  style: context.bodyMedium.copyWith(
                    color: ColorM.gray900,
                    fontWeight: FontWeightM.medium,
                  ),
                ),
                Text(
                  summary,
                  style: context.labelLarge.copyWith(color: ColorM.gray700),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          12.horizontalSpace,
          _ProductImagesStack(
            imageUrls: [for (final item in items.take(3)) item.imageUrl ?? ''],
          ),
        ],
      ),
    );
  }
}

class _ProductImagesStack extends StatelessWidget {
  final List<String> imageUrls;
  const _ProductImagesStack({required this.imageUrls});

  String _url(int index) => index < imageUrls.length ? imageUrls[index] : '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 67.w,
      height: 52.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (imageUrls.length > 1)
            Positioned(
              right: 21.w,
              child: Transform.rotate(
                angle: -19 * (math.pi / 180),
                child: _productThumb(_url(1), offset: Offset(-5, 10)),
              ),
            ),
          if (imageUrls.length > 2)
            Positioned(
              right: 4.w,
              top: 6.h,
              child: Transform.rotate(
                angle: 15 * (math.pi / 180),
                child: _productThumb(_url(2), offset: Offset(5, 10)),
              ),
            ),
          Positioned(
            child: CustomCachedImage(
              imageUrl: _url(0),
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
  final String address;
  const _LocationRow({required this.address});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          Assets.svg.borderLocation.path,
          width: 18.w,
          height: 18.w,
          colorFilter: const ColorFilter.mode(ColorM.gray950, BlendMode.srcIn),
        ),
        6.horizontalSpace,
        Expanded(
          child: Text(
            address,
            style: context.labelLarge.copyWith(color: ColorM.gray950),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _CaptainAndLocationRow extends StatelessWidget {
  final String address;
  final String captainName;

  const _CaptainAndLocationRow({
    required this.address,
    required this.captainName,
  });

  @override
  Widget build(BuildContext context) {
    // Stacked full-width rows (not side-by-side) so a long address or a long
    // captain name truncates cleanly on its own line instead of wrapping into
    // a cramped two-column layout.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              Assets.svg.borderLocation.path,
              width: 16.w,
              height: 16.w,
              colorFilter: const ColorFilter.mode(
                ColorM.gray950,
                BlendMode.srcIn,
              ),
            ),
            6.horizontalSpace,
            Expanded(
              child: Text(
                address,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.labelMedium.copyWith(color: ColorM.gray950),
              ),
            ),
          ],
        ),
        8.verticalSpace,
        Row(
          children: [
            Text(
              Translation.captain_label.tr,
              style: context.labelMedium.copyWith(color: ColorM.gray600),
            ),
            6.horizontalSpace,
            ClipOval(
              child: CustomCachedImage(imageUrl: '', width: 18.w, height: 18.w),
            ),
            6.horizontalSpace,
            Expanded(
              child: Text(
                captainName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.labelMedium.copyWith(
                  color: ColorM.gray900,
                  fontWeight: FontWeightM.medium,
                ),
              ),
            ),
          ],
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
  final bool delivered;
  final VoidCallback onTapDetails;
  const _OnTheWayFooter({required this.delivered, required this.onTapDetails});

  @override
  Widget build(BuildContext context) {
    final statusColor = delivered
        ? const Color(0xFF10B981)
        : const Color(0xFFF59E0B);
    final statusLabel = delivered
        ? Translation.delivered.tr
        : Translation.out_for_delivery.tr;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 7.w,
              height: 7.w,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
            6.horizontalSpace,
            Text(
              statusLabel,
              style: context.labelLarge.copyWith(
                color: statusColor,
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
      context.isLTR
          ? Icons.arrow_circle_right_rounded
          : Icons.arrow_circle_left_rounded,
      size: 18.w,
      color: color,
    );
  }
}
