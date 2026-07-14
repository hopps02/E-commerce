import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/app/enums/enums.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/custom_cached_image.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/data/response/cashier/cashier_response.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/translations_manager.dart';
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
        _OnTheWayFooter(status: order.uiStatus, onTapDetails: onTapDetails),
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
    return Container(height: 1, color: ColorM.gray250);
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
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6.h),
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
      width: 67,
      height: 52,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (imageUrls.length > 1)
            Positioned(
              right: 21,
              child: Transform.rotate(
                angle: -19 * (math.pi / 180),
                child: _productThumb(_url(1), offset: Offset(-5, 10)),
              ),
            ),
          if (imageUrls.length > 2)
            Positioned(
              right: 4,
              top: 6,
              child: Transform.rotate(
                angle: 15 * (math.pi / 180),
                child: _productThumb(_url(2), offset: Offset(5, 10)),
              ),
            ),
          Positioned(
            child: CustomCachedImage(
              imageUrl: _url(0),
              width: 38,
              height: 42,
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
        width: 38,
        height: 42,
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
          width: 18,
          height: 18,
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
              width: 16,
              height: 16,
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
              child: CustomCachedImage(imageUrl: '', width: 18, height: 18.w),
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
      height: 42,
      backgroundColor: ColorM.primary50,
      borderRadius: 29.r,
      smoothness: 1,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8.h),
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
  final CashierOrderStatus? status;
  final VoidCallback onTapDetails;
  const _OnTheWayFooter({required this.status, required this.onTapDetails});

  @override
  Widget build(BuildContext context) {
    final (statusColor, statusLabel) = switch (status) {
      CashierOrderStatus.delivered => (
        const Color(0xFF10B981),
        Translation.delivered.tr,
      ),
      CashierOrderStatus.failedDelivery => (
        ColorM.red,
        Translation.delivery_failed.tr,
      ),
      CashierOrderStatus.cancelled => (ColorM.red, Translation.cancelled.tr),
      CashierOrderStatus.rejectedByMerchant => (
        ColorM.red,
        Translation.rejected_by_merchant.tr,
      ),
      _ => (const Color(0xFFF59E0B), Translation.out_for_delivery.tr),
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 7,
              height: 7,
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
          height: 42,
          backgroundColor: ColorM.primary50,
          borderRadius: 29.r,
          smoothness: 1,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8.h),
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
      size: 18,
      color: color,
    );
  }
}
