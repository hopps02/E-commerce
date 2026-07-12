import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/presentation/res/sizes_manager.dart';

class GeneralPadding extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const GeneralPadding({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w),
      child: child,
    );
  }
}
