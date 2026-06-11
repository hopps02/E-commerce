import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';

enum CaptainOrderStatus {
  upcoming,
  inDelivery,
  delivered,
  cancelled;

  bool get isUpcoming => this == upcoming;
  bool get isInDelivery => this == inDelivery;
  bool get isDelivered => this == delivered;
  bool get isCancelled => this == cancelled;
}

class CaptainOrderCard extends StatelessWidget {
  final CaptainOrderStatus status;
  final String orderId;
  final String address;
  final String customerName;
  final VoidCallback onTapOpen;
  final VoidCallback onTapCall;

  const CaptainOrderCard({
    super.key,
    required this.status,
    required this.orderId,
    required this.address,
    required this.customerName,
    required this.onTapOpen,
    required this.onTapCall,
  });

  @override
  Widget build(BuildContext context) {
    context.locale;
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
        children: [
          _OrderHeader(orderId: orderId),
          10.verticalSpace,
          const _Divider(),
          10.verticalSpace,
          _LocationRow(address: address),
          10.verticalSpace,
          _CustomerRow(customerName: customerName, onTapCall: onTapCall),
          10.verticalSpace,
          const _Divider(),
          10.verticalSpace,
          _Footer(status: status, onTapOpen: onTapOpen),
        ],
      ),
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

class _OrderHeader extends StatelessWidget {
  final String orderId;
  const _OrderHeader({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: ColorM.primary50,
                shape: SmoothRectangleBorder(
                  smoothness: 1,
                  borderRadius: BorderRadius.circular(11.r),
                ),
              ),
              child: SvgPicture.asset(
                Assets.svg.box.path,
                width: 18.w,
                height: 18.w,
                colorFilter: const ColorFilter.mode(
                  ColorM.primary500,
                  BlendMode.srcIn,
                ),
              ),
            ),
            9.horizontalSpace,
            Text(
              orderId,
              textDirection: TextDirection.ltr,
              style: context.bodyMedium.copyWith(
                fontWeight: FontWeightM.medium,
                color: ColorM.gray400,
              ),
            ),
          ],
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

class _CustomerRow extends StatelessWidget {
  final String customerName;
  final VoidCallback onTapCall;

  const _CustomerRow({required this.customerName, required this.onTapCall});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: ShapeDecoration(
        color: const Color(0xFFF3F4F6),
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(13.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  color: ColorM.gray100,
                  shape: SmoothRectangleBorder(
                    smoothness: 1,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: SvgPicture.asset(
                  Assets.svg.user.path,
                  width: 14.w,
                  height: 14.w,
                  colorFilter: const ColorFilter.mode(
                    ColorM.gray700,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              6.horizontalSpace,
              Text(
                customerName,
                style: context.labelMedium.copyWith(
                  color: ColorM.gray700,
                  fontWeight: FontWeightM.medium,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onTapCall,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 32.w,
              height: 32.w,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: const Color(0xFFDCFCE7),
                shape: SmoothRectangleBorder(
                  smoothness: 1,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: SvgPicture.asset(
                Assets.svg.callCalling.path,
                width: 14.w,
                height: 14.w,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF16A34A),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final CaptainOrderStatus status;
  final VoidCallback onTapOpen;

  const _Footer({required this.status, required this.onTapOpen});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _StatusLabel(status: status),
        _OpenButton(onTap: onTapOpen),
      ],
    );
  }
}

class _OpenButton extends StatelessWidget {
  final VoidCallback onTap;
  const _OpenButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: onTap,
      height: 36.h,
      width: 115.w,
      backgroundColor: ColorM.primary500,
      borderRadius: 29.r,
      smoothness: 1,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      tap: const ButtonAnimationSettings(
        ButtonAnimation.scaleTap,
        intensity: 0.2,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Translation.open.tr,
            style: context.labelLarge.copyWith(
              color: ColorM.white,
              fontWeight: FontWeightM.medium,
            ),
          ),
          4.horizontalSpace,
          Icon(
            context.isLTR
                ? Icons.arrow_circle_right_rounded
                : Icons.arrow_circle_left_rounded,
            size: 14.w,
            color: ColorM.white,
          ),
        ],
      ),
    );
  }
}

class _StatusLabel extends StatelessWidget {
  final CaptainOrderStatus status;
  const _StatusLabel({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      CaptainOrderStatus.upcoming => (
        Translation.upcoming_order.tr,
        const Color(0xFFA394FF),
      ),
      CaptainOrderStatus.inDelivery => (
        Translation.out_for_delivery.tr,
        const Color(0xFFF59E0B),
      ),
      CaptainOrderStatus.delivered => (
        Translation.delivered.tr,
        const Color(0xFF22C55E),
      ),
      CaptainOrderStatus.cancelled => (Translation.cancelled.tr, ColorM.red),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7.w,
          height: 7.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        6.horizontalSpace,
        Text(
          label,
          style: context.labelLarge.copyWith(
            color: color,
            fontWeight: FontWeightM.medium,
          ),
        ),
      ],
    );
  }
}
