import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/spacing_manager.dart';

/// A label sitting above a form field, both stretched start-aligned so the
/// label lands on the start side (right in RTL).
class LabeledField extends StatelessWidget {
  final String label;
  final Widget child;

  const LabeledField({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.labelLarge.copyWith(
            color: ColorM.gray800,
            fontWeight: FontWeightM.medium,
            height: 22 / 14,
          ),
        ),
        SpaceM.s2.verticalSpace,
        child,
      ],
    );
  }
}
