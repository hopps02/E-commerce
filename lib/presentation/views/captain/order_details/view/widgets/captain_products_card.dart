import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/captain/order_details/riverpod/captain_order_details_controller.dart';
import 'package:smooth_corner/smooth_corner.dart';

class CaptainProductsCard extends StatelessWidget {
  final List<CaptainOrderItem> items;
  final double totalAmount;

  const CaptainProductsCard({
    super.key,
    required this.items,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
      decoration: ShapeDecoration(
        color: ColorM.gray100,
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Header(itemsCount: items.length),
          8.verticalSpace,
          _Divider(),
          8.verticalSpace,
          for (int i = 0; i < items.length; i++) ...[
            _ProductRow(item: items[i]),
            if (i != items.length - 1) 10.verticalSpace,
          ],
          8.verticalSpace,
          _Divider(),
          8.verticalSpace,
          _TotalRow(total: totalAmount),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final int itemsCount;
  const _Header({required this.itemsCount});

  @override
  Widget build(BuildContext context) {
    return Row(
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
                color: ColorM.primary50,
                shape: SmoothRectangleBorder(
                  smoothness: 1,
                  borderRadius: BorderRadius.circular(11.r),
                ),
              ),
              child: SvgPicture.asset(
                Assets.svg.box.path,
                width: 16.w,
                height: 16.w,
                colorFilter: const ColorFilter.mode(
                  ColorM.primary500,
                  BlendMode.srcIn,
                ),
              ),
            ),
            3.horizontalSpace,
            Text(
              Translation.products_list.tr,
              style: context.bodyLarge.copyWith(
                color: ColorM.gray800,
                fontWeight: FontWeightM.medium,
                fontSize: 16.sp,
                height: 1.2,
              ),
            ),
          ],
        ),
        Text(
          Translation.items_count.trNamed({'count': '$itemsCount'}),
          style: context.labelMedium.copyWith(
            color: ColorM.primary400,
            fontWeight: FontWeightM.medium,
            fontSize: 11.sp,
            height: 16.5 / 11,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 1.h, color: ColorM.gray250);
  }
}

class _ProductRow extends StatelessWidget {
  final CaptainOrderItem item;
  const _ProductRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20.w,
              height: 20.w,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: const Color(0xFFF3F4F6),
                shape: SmoothRectangleBorder(
                  smoothness: 1,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              child: Text(
                '×${item.quantity}',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeightM.medium,
                  color: ColorM.gray700,
                  height: 1.2,
                ),
              ),
            ),
            4.horizontalSpace,
            Text(
              item.name,
              style: context.labelMedium.copyWith(
                color: ColorM.gray700,
                fontWeight: FontWeightM.medium,
                fontSize: 12.sp,
                height: 1.2,
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.price.toStringAsFixed(0),
              style: context.labelSmall.copyWith(
                color: ColorM.gray700,
                fontWeight: FontWeightM.semiBold,
                fontSize: 10.7.sp,
                height: 1.2,
              ),
            ),
            1.5.horizontalSpace,
            SvgPicture.asset(
              Assets.svg.saudiRiyalSymbol.path,
              width: 7.7.w,
              height: 8.5.h,
              colorFilter: const ColorFilter.mode(
                ColorM.gray700,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TotalRow extends StatelessWidget {
  final double total;
  const _TotalRow({required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          Translation.total_amount.tr,
          style: context.bodyLarge.copyWith(
            color: ColorM.gray900,
            fontWeight: FontWeightM.medium,
            fontSize: 14.sp,
            height: 1.5,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              total.toStringAsFixed(0),
              style: context.bodyLarge.copyWith(
                color: ColorM.primary700,
                fontWeight: FontWeightM.semiBold,
                fontSize: 16.45.sp,
                height: 1.2,
              ),
            ),
            3.horizontalSpace,
            SvgPicture.asset(
              Assets.svg.saudiRiyalSymbol.path,
              width: 12.w,
              height: 13.2.h,
              colorFilter: const ColorFilter.mode(
                ColorM.primary700,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
