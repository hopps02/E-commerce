import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/presentation/res/color_manager.dart';

class NotificationsEmptyState extends StatelessWidget {
  const NotificationsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.notifications_none_rounded,
      size: 68,
      color: ColorM.gray300,
    );
  }
}
