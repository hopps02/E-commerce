import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/utils/money.dart';
import 'package:store/app/utils/quantity.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/confirm_order/view/widgets/order_item.dart';

class Orders extends StatelessWidget {
  final List<CartLine> lines;
  const Orders({super.key, required this.lines});

  @override
  Widget build(BuildContext context) {
    final arabic = context.locale.languageCode == 'ar';

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w),
        child: Column(
          spacing: 10,
          crossAxisAlignment: .start,
          children: [
            Text(
              Translation.orders.tr,
              style: context.bodyLarge.copyWith(fontWeight: FontWeightM.bold),
            ).premiumAppear(index: 2),
            Expanded(
              child: ListView.separated(
                itemCount: lines.length,
                separatorBuilder: (context, index) => 16.verticalSpace,
                padding: EdgeInsets.only(bottom: 20.h),
                itemBuilder: (context, index) {
                  final line = lines[index];
                  final product = line.product;
                  return Order(
                    image: product?.imageUrl ?? '',
                    weight: '',
                    title: product?.name(arabic) ?? '',
                    price: Money.amount(line.lineSubtotalHalalas),
                    count: '${line.quantity}',
                  );
                },
              ).premiumAppear(),
            ),
          ],
        ),
      ),
    );
  }
}
