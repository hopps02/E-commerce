import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/presentation/res/color_manager.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .bottomCenter,
      child: IgnorePointer(
        ignoring: true,
        child: Container(
          height: 140.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorM.white.withValues(alpha: 0),
                ColorM.primary700.withValues(alpha: 0.20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
