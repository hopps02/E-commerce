import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/enums/enums.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';

class CaptainCustomerCard extends StatelessWidget {
  final String customerName;
  final String address;
  final CaptainOrderStatus status;
  final VoidCallback onTapCall;

  const CaptainCustomerCard({
    super.key,
    required this.customerName,
    required this.address,
    required this.status,
    required this.onTapCall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.w),
      decoration: ShapeDecoration(
        color: ColorM.primary100,
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CustomerRow(customerName: customerName, onTapCall: onTapCall),
          8.verticalSpace,
          _AddressRow(address: address),
          if (status.showsStatusPill) ...[
            8.verticalSpace,
            _StatusPill(status: status),
          ],
        ],
      ),
    );
  }
}

class _CustomerRow extends StatelessWidget {
  final String customerName;
  final VoidCallback onTapCall;

  const _CustomerRow({required this.customerName, required this.onTapCall});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _IconBox(
              backgroundColor: ColorM.gray100,
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
            8.horizontalSpace,
            Text(
              customerName,
              style: context.labelMedium.copyWith(
                color: ColorM.gray700,
                fontWeight: FontWeightM.medium,
                fontSize: 12.sp,
                height: 18 / 12,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: onTapCall,
          behavior: HitTestBehavior.opaque,
          child: _IconBox(
            backgroundColor: const Color(0xFFDCFCE7),
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
    );
  }
}

class _AddressRow extends StatelessWidget {
  final String address;
  const _AddressRow({required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: ShapeDecoration(
        color: ColorM.primary50,
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(13.r),
        ),
      ),
      child: Row(
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
          Expanded(
            child: Text(
              address,
              style: context.labelLarge.copyWith(color: ColorM.gray950),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final CaptainOrderStatus status;
  const _StatusPill({required this.status});

  @override
  Widget build(BuildContext context) {
    final spec = _specFor(status);
    return Container(
      height: 34.h,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: ShapeDecoration(
        color: spec.background,
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(26.r),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (spec.iconBuilder != null) ...[
            spec.iconBuilder!(),
            4.horizontalSpace,
          ],
          if (spec.trailingDot) ...[
            Container(
              width: 7.w,
              height: 7.w,
              decoration: BoxDecoration(
                color: spec.foreground,
                shape: BoxShape.circle,
              ),
            ),
            4.horizontalSpace,
          ],
          Text(
            spec.label,
            style: context.labelLarge.copyWith(
              color: spec.foreground,
              fontWeight: FontWeightM.medium,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  _StatusPillSpec _specFor(CaptainOrderStatus status) {
    switch (status) {
      case CaptainOrderStatus.inDelivery:
        return _StatusPillSpec(
          label: Translation.out_for_delivery.tr,
          background: ColorM.white,
          foreground: const Color(0xFFF59E0B),
          trailingDot: true,
        );
      case CaptainOrderStatus.delivered:
        return _StatusPillSpec(
          label: Translation.delivered.tr,
          background: const Color(0xFF109641),
          foreground: ColorM.white,
          iconBuilder: () => Icon(
            Icons.check_circle_outline_rounded,
            size: 16.w,
            color: ColorM.white,
          ),
        );
      case CaptainOrderStatus.cancelled:
        return _StatusPillSpec(
          label: Translation.cancelled.tr,
          background: const Color(0xFFE7000B),
          foreground: ColorM.white,
          iconBuilder: () =>
              Icon(Icons.cancel_outlined, size: 16.w, color: ColorM.white),
        );
      default:
        return _StatusPillSpec(
          label: '',
          background: Colors.transparent,
          foreground: Colors.transparent,
        );
    }
  }
}

class _StatusPillSpec {
  final String label;
  final Color background;
  final Color foreground;
  final bool trailingDot;
  final Widget Function()? iconBuilder;

  const _StatusPillSpec({
    required this.label,
    required this.background,
    required this.foreground,
    this.trailingDot = false,
    this.iconBuilder,
  });
}

class _IconBox extends StatelessWidget {
  final Color backgroundColor;
  final Widget child;

  const _IconBox({required this.backgroundColor, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32.w,
      height: 32.w,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: child,
    );
  }
}
