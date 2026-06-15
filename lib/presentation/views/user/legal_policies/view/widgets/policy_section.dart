import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';

class PolicySection extends StatelessWidget {
  final String title;
  final String description;

  /// True when [description] is the honest "not added yet" placeholder (muted,
  /// italic) rather than real legal copy.
  final bool isPlaceholder;

  const PolicySection({
    super.key,
    required this.title,
    required this.description,
    this.isPlaceholder = false,
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
          style: context.bodyLarge.copyWith(
            color: isPlaceholder ? ColorM.gray500 : ColorM.gray600,
            height: 1.6,
            fontStyle: isPlaceholder ? FontStyle.italic : FontStyle.normal,
          ),
        ),
      ],
    );
  }
}
