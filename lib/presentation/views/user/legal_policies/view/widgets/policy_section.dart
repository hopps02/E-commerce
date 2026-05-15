import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';

class PolicySection extends StatelessWidget {
  final String title;
  final String description;

  const PolicySection({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.titleLarge.copyWith(
            fontWeight: FontWeightM.bold,
            color: ColorM.gray900,
          ),
        ),
        16.verticalSpace,
        Text(
          description,
          style: context.bodyLarge.copyWith(color: ColorM.gray600, height: 1.6),
        ),
      ],
    );
  }
}
