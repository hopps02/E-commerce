import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/utils/money.dart';
import 'package:store/data/response/customer/customer_response.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/custom_cached_image.dart';
import 'package:smooth_corner/smooth_corner.dart';

class OrderCard extends StatelessWidget {
  final CustomerOrder order;
  final VoidCallback onTapDetails;
  const OrderCard({super.key, required this.order, required this.onTapDetails});

  String _imageUrl(int index) {
    final items = order.activeItems;
    return index < items.length ? (items[index].imageUrl ?? '') : '';
  }

  @override
  Widget build(BuildContext context) {
    final arabic = context.locale.languageCode == 'ar';
    final items = order.activeItems;
    final summary = items.map((item) => item.name(arabic)).join(' · ');
    final step = order.timelineStep;
    return Container(
      width: 343.w,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#${order.orderNumber}',
                textDirection: TextDirection.ltr,
                style: context.bodyMedium.copyWith(
                  fontWeight: FontWeightM.medium,
                  color: ColorM.gray400,
                ),
              ),
              Text(
                order.createdAt == null
                    ? ''
                    : easy.DateFormat(
                        "MMMM d, yyyy h:mm a",
                        context.locale.languageCode,
                      ).format(order.createdAt!.toLocal()),
                style: context.labelMedium.copyWith(color: ColorM.gray600),
              ),
            ],
          ),
          12.verticalSpace,
          Container(height: 1.h, color: ColorM.gray250),
          12.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            decoration: ShapeDecoration(
              color: ColorM.primary50.withValues(alpha: 0.4),
              shape: SmoothRectangleBorder(
                smoothness: 1,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Row(
              spacing: 12.w,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Translation.product_count.trNamed({
                          'count': '${order.itemsCount ?? items.length}',
                        }),
                        style: context.bodyMedium.copyWith(
                          color: ColorM.gray900,
                          fontWeight: FontWeightM.medium,
                        ),
                      ),
                      Text(
                        summary,
                        style: context.labelLarge.copyWith(
                          color: ColorM.gray700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 67.w,
                  height: 52.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (items.length > 1)
                        Positioned(
                          right: 21.w,
                          child: Transform.rotate(
                            angle: -19 * (3.14159 / 180),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorM.gray1000.withValues(
                                      alpha: 0.1,
                                    ),
                                    blurRadius: 3,
                                    spreadRadius: 0,
                                    offset: Offset(-5, 10),
                                  ),
                                ],
                              ),
                              child: CustomCachedImage(
                                imageUrl: _imageUrl(1),
                                width: 38.w,
                                height: 42.h,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                            ),
                          ),
                        ),
                      if (items.length > 2)
                        Positioned(
                          right: 4.w,
                          top: 6.h,
                          child: Transform.rotate(
                            angle: 15 * (3.14159 / 180),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorM.gray1000.withValues(
                                      alpha: 0.1,
                                    ),
                                    blurRadius: 3,
                                    spreadRadius: 0,
                                    offset: Offset(5, 10),
                                  ),
                                ],
                              ),
                              child: CustomCachedImage(
                                imageUrl: _imageUrl(2),
                                width: 38.w,
                                height: 42.h,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        child: CustomCachedImage(
                          imageUrl: _imageUrl(0),
                          width: 38.w,
                          height: 42.h,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          12.verticalSpace,
          Row(
            children: [
              Expanded(
                child: TimeLineStep(
                  title: Translation.preparing.tr,
                  isActive: step >= 1,
                  isNextActive: step >= 2,
                  isFirst: true,
                  isLast: false,
                ),
              ),
              Expanded(
                child: TimeLineStep(
                  title: Translation.out_for_delivery.tr,
                  isActive: step >= 2,
                  isNextActive: step >= 3,
                  isFirst: false,
                  isLast: false,
                  nextFailed: order.isFailedDelivery,
                ),
              ),
              Expanded(
                child: TimeLineStep(
                  title: order.isFailedDelivery
                      ? Translation.delivery_failed.tr
                      : Translation.delivered.tr,
                  isActive: order.isFailedDelivery || step >= 3,
                  isFailed: order.isFailedDelivery,
                  isNextActive: false,
                  isFirst: false,
                  isLast: true,
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Container(height: 1.h, color: ColorM.gray250),
          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomInkButton(
                backgroundColor: ColorM.primary600,
                borderRadius: 10.r,
                smoothness: 1,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                onTap: onTapDetails,
                child: Text(
                  Translation.view_details.tr,
                  style: context.labelMedium.copyWith(
                    color: ColorM.white,
                    fontWeight: FontWeightM.medium,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Translation.total.tr,
                    style: context.labelMedium.copyWith(color: ColorM.gray400),
                  ),
                  Row(
                    children: [
                      Text(
                        Money.amount(order.displayTotalHalalas),
                        style: context.titleMedium.copyWith(
                          color: ColorM.primary700,
                          fontWeight: FontWeightM.semiBold,
                        ),
                      ),
                      2.horizontalSpace,
                      SvgPicture.asset(
                        Assets.svg.saudiRiyalSymbol.path,
                        height: 13.h,
                        colorFilter: const ColorFilter.mode(
                          ColorM.primary700,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TimeLineStep extends StatelessWidget {
  final String title;
  final bool isActive;
  final bool isNextActive;
  final bool isFirst;
  final bool isLast;

  /// A terminal failure ('failed_delivery') paints this node red instead of the
  /// usual green, so a failed order never reads as delivered.
  final bool isFailed;

  /// The next node is the failed one — paint the connector leaving this node red
  /// so the failure leg reads as a single red line out of "out for delivery".
  final bool nextFailed;
  const TimeLineStep({
    super.key,
    required this.title,
    required this.isActive,
    this.isNextActive = false,
    required this.isFirst,
    required this.isLast,
    this.isFailed = false,
    this.nextFailed = false,
  });

  @override
  Widget build(BuildContext context) {
    final nodeColor = isFailed
        ? ColorM.red
        : (isActive ? ColorM.primary600 : ColorM.gray250);
    return Align(
      alignment: isLast
          ? AlignmentDirectional.centerEnd
          : isFirst
          ? AlignmentDirectional.centerStart
          : AlignmentDirectional.center,
      child: Column(
        crossAxisAlignment: isFirst
            ? CrossAxisAlignment.start
            : isLast
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              if (!isFirst)
                Expanded(
                  child: Container(
                    height: 1.h,
                    color: nodeColor,
                  ),
                ),
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: nodeColor,
                    width: 1.5.w,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 14.w,
                    height: 14.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: nodeColor,
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    height: 1.h,
                    color: nextFailed
                        ? ColorM.red
                        : (isNextActive ? ColorM.primary600 : ColorM.gray250),
                  ),
                ),
            ],
          ),
          8.verticalSpace,
          Text(
            title,
            style: context.labelSmall.copyWith(
              color: isFailed
                  ? ColorM.red
                  : (isActive ? ColorM.gray900 : ColorM.gray700),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
