import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/common/general_padding.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/cashier/support/view/widgets/cashier_support_form.dart';
import 'package:for_u/presentation/views/cashier/support/view/widgets/cashier_support_icon.dart';

class CashierSupportBody extends StatelessWidget {
  const CashierSupportBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: 40.h,
        bottom: context.bottomViewInsets + 24.h,
      ),
      child: Column(
        children: [
          const CashierSupportIcon().premiumAppear(index: 1),
          18.verticalSpace,
          Text(
            Translation.request_support.tr,
            style: context.bodyLarge.copyWith(
              fontWeight: FontWeightM.semiBold,
              color: ColorM.gray1000,
              height: 24 / 18,
              fontSize: 18.sp,
            ),
          ).premiumAppear(index: 2),
          40.verticalSpace,
          const GeneralPadding(child: CashierSupportForm()).premiumAppear(index: 3),
        ],
      ),
    );
  }
}
