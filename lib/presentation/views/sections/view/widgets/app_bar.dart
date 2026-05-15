import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/ui_components/default_app_bar.dart';

class TopAppBar extends StatelessWidget {
  final String title;
  const TopAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 17.h),
      child: DefaultAppBar(title: title),
    );
  }
}
