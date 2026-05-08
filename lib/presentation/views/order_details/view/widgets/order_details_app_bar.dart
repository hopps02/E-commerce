import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/ui_components/default_app_bar.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/sizes_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';
import 'package:jar/app/extensions/extensions.dart';

class OrderDetailsAppBar extends StatelessWidget {
  const OrderDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultAppBar(
      padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w) + EdgeInsets.only(
        top: 17.h + context.topSafeAreaPadding,
        bottom: 36.h,
      ),
      title: Translation.order_details.tr,
      titleColor: ColorM.white,
      backButtonIconColor: ColorM.white,
    );
  }
}
