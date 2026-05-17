import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/ui_components/default_app_bar.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

class SupportAppBar extends StatelessWidget {
  const SupportAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultAppBar(
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: SizeM.pagePadding.w,
      ),
      title: Translation.support.tr,
    );
  }
}
