import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/confirm_order/view/widgets/order_item.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w),
        child: Column(
          spacing: 10.h,
          crossAxisAlignment: .start,
          children: [
            Text(
              Translation.orders.tr,
              style: context.bodyLarge.copyWith(fontWeight: FontWeightM.bold),
            ).premiumAppear(index: 2),
            Expanded(
              child: ListView.separated(
                itemCount: 4,
                separatorBuilder: (context, index) => 16.verticalSpace,
                padding: EdgeInsets.only(bottom: 20.h),
                itemBuilder: (context, index) {
                  return Order(
                    image: "",
                    weight: "500 جم",
                    title: "خيار طازج",
                    price: "15.00",
                    count: "2",
                  ).premiumAppear(index: (index % 5) + 2);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
