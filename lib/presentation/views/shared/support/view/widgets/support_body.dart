import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/presentation/common/general_padding.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/shared/support/view/widgets/support_form.dart';
import 'package:store/presentation/views/shared/support/view/widgets/support_icon.dart';

class SupportBody extends StatelessWidget {
  const SupportBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: 40.h,
        bottom: context.bottomViewInsets + 24.h,
      ),
      child: Column(
        children: [
          const SupportIcon().premiumAppear(index: 1),
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
          const GeneralPadding(child: SupportForm()).premiumAppear(index: 3),
        ],
      ),
    );
  }
}
