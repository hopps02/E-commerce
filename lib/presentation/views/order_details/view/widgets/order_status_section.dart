import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/home/view/widgets/order_card.dart';

class OrderStatusSection extends StatelessWidget {
  final int step;
  const OrderStatusSection({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Translation.order_number.tr,
              style: context.labelLarge.copyWith(color: ColorM.gray600),
            ),
            Text(
              '#GOC-23456757',
              textDirection: TextDirection.ltr,
              style: context.bodyMedium.copyWith(
                fontWeight: FontWeightM.medium,
                color: ColorM.gray400,
              ),
            ),
          ],
        ),
        24.verticalSpace,
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
              ),
            ),
            Expanded(
              child: TimeLineStep(
                title: Translation.delivered.tr,
                isActive: step >= 3,
                isNextActive: false,
                isFirst: false,
                isLast: true,
              ),
            ),
          ],
        ),
        24.verticalSpace,
        Container(height: 1.h, color: ColorM.gray150),
      ],
    );
  }
}
