import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/enums/enums.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_components/custom_cached_image.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/cashier/order_details/riverpod/cashier_order_details_controller.dart';

class OrderInfoPanel extends StatelessWidget {
  final CashierOrderDetailsState state;
  const OrderInfoPanel({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      color: ColorM.gray100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _InfoRow(
            label: Translation.location_label.tr,
            valueIcon: Assets.svg.borderLocation.path,
            value: state.location,
          ),
          10.verticalSpace,
          _InfoRow(
            label: Translation.order_time_label.tr,
            valueIcon: Assets.svg.calendar.path,
            value: easy.DateFormat(
              'd MMMM yyyy',
              context.locale.languageCode,
            ).format(state.orderTime),
          ),
          if (state.status.showsCaptainRow && state.captainName != null) ...[
            10.verticalSpace,
            _CaptainRow(
              name: state.captainName!,
              avatarUrl: state.captainAvatarUrl ?? '',
            ),
          ],
          if (state.status.showsCaptainRow) ...[
            9.verticalSpace,
            _StatusBadge(status: state.status),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String valueIcon;
  final String value;

  const _InfoRow({
    required this.label,
    required this.valueIcon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 64.w,
          child: Text(
            label,
            style: context.labelLarge.copyWith(
              color: ColorM.gray600,
              fontSize: 12.sp,
              height: 16 / 12,
            ),
          ),
        ),
        6.horizontalSpace,
        SvgPicture.asset(
          valueIcon,
          width: 16.w,
          height: 16.w,
          colorFilter: const ColorFilter.mode(
            ColorM.gray600,
            BlendMode.srcIn,
          ),
        ),
        6.horizontalSpace,
        Expanded(
          child: Text(
            value,
            softWrap: true,
            maxLines: 100,
            style: context.labelLarge.copyWith(
              color: ColorM.gray600,
              height: 16 / 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _CaptainRow extends StatelessWidget {
  final String name;
  final String avatarUrl;
  const _CaptainRow({required this.name, required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 64.w,
          child: Text(
            Translation.captain_label.tr,
            style: context.labelLarge.copyWith(
              color: ColorM.gray600,
              fontSize: 12.sp,
              height: 16 / 12,
            ),
          ),
        ),
        6.horizontalSpace,
        ClipOval(
          child: CustomCachedImage(
            imageUrl: avatarUrl,
            width: 21.w,
            height: 21.w,
          ),
        ),
        6.horizontalSpace,
        Expanded(
          child: Text(
            name,
            style: context.labelLarge.copyWith(
              color: ColorM.gray600,
              height: 16 / 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final CashierOrderStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      CashierOrderStatus.inDelivery => (
          const Color(0xFFF59E0B),
          Translation.out_for_delivery.tr,
        ),
      CashierOrderStatus.delivered => (
          const Color(0xFF10B981),
          Translation.delivered.tr,
        ),
      _ => (Colors.transparent, ''),
    };

    if (label.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 34.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(26.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: context.labelLarge.copyWith(
              color: color,
              fontWeight: FontWeightM.medium,
              height: 1.2,
            ),
          ),
          3.horizontalSpace,
          Container(
            width: 7.w,
            height: 7.w,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}
