import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/shapes/gradient_border_side.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/translations_manager.dart';

/// Weight/size selector chips — "حجم العبوة" section from Figma.
///
/// Unused since sizes were folded into product names (each size is its own
/// bank product); kept as the built design artifact with local-only state.
class ProductWeightSelector extends StatefulWidget {
  final List<String> weights;

  const ProductWeightSelector({
    super.key,
    this.weights = const ['500 جم', '1 كجم', '2 كجم'],
  });

  @override
  State<ProductWeightSelector> createState() => _ProductWeightSelectorState();
}

class _ProductWeightSelectorState extends State<ProductWeightSelector> {
  int selectedIndex = 0;

  List<String> get weights => widget.weights;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translation.package_size.tr,
            style: context.bodyLarge.copyWith(
              color: ColorM.gray800,
              fontWeight: FontWeightM.medium,
            ),
          ),
          11.verticalSpace,
          Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(weights.length, (index) {
              final isSelected = selectedIndex == index;
              return _WeightChip(
                label: weights[index],
                isSelected: isSelected,
                onTap: () => setState(() => selectedIndex = index),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _WeightChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _WeightChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: onTap,
      borderRadius: 12.r,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8.h),
      backgroundColor: ColorM.transparent,
      side: GradientBorderSide(
        color: isSelected ? ColorM.primary : ColorM.gray200,
        width: 1,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          SizedBox(
            width: 14,
            height: 14,
            child: isSelected
                ? SvgPicture.asset(
                    Assets.svg.circleCheck.path,
                    colorFilter: ColorFilter.mode(
                      ColorM.primary,
                      BlendMode.srcIn,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorM.gray300, width: 1.w),
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
          ),

          Text(
            label,
            style: context.labelMedium.copyWith(
              color: ColorM.gray700,
              fontWeight: FontWeightM.medium,
            ),
          ),
        ],
      ),
    );
  }
}
