import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onViewAllTap;
  final String? viewAllText;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onViewAllTap,
    this.viewAllText = "عرض الكل",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.bodyLarge.copyWith(
                fontWeight: FontWeightM.semiBold,
              ),
            ),
            if (onViewAllTap != null)
              GestureDetector(
                onTap: onViewAllTap,
                child: Text(
                  viewAllText!,
                  style: context.labelLarge.copyWith(
                    color: ColorM.primary500,
                  ),
                ),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
        if (subtitle != null) ...[
          6.verticalSpace,
          Text(
            subtitle!,
            softWrap: true,
            style: context.labelSmall.copyWith(
              color: ColorM.gray700,
              fontWeight: FontWeightM.medium,
              fontSize: 10.sp,
            ),
          ),
        ],
      ],
    );
  }
}
