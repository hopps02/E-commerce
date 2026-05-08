import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/ui_components/default_app_bar.dart';
import 'package:jar/presentation/res/sizes_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';

class HelpSupportAppBar extends StatelessWidget {
  const HelpSupportAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultAppBar(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: SizeM.pagePadding.w),
      title: Translation.help_and_support.tr,
    );
  }
}
