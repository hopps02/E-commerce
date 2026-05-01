import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/presentation/res/translations_manager.dart';

class MyOrdersAppBar extends StatelessWidget {
  const MyOrdersAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.topSafeAreaPadding),
        28.verticalSpace,
        Text(
          Translation.my_orders.tr,
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
