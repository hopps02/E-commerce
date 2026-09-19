import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/ui_kit/default_app_bar.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/presentation/res/spacing_manager.dart';

class OrderDetailsAppBar extends StatelessWidget {
  const OrderDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultAppBar(
      padding:
          EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w) +
          EdgeInsets.only(top: SpaceM.s4.h + context.topSafeAreaPadding, bottom: SpaceM.s10.h),
      title: Translation.order_details.tr,
      titleColor: ColorM.white,
      backButtonIconColor: ColorM.white,
    );
  }
}
