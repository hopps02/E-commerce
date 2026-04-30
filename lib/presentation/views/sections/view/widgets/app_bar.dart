import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/ui_components/default_app_bar.dart';
import 'package:jar/presentation/res/translations_manager.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 17.h),
      child: DefaultAppBar(title: Translation.categories.tr),
    );
  }
}
