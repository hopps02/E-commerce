import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/app/ui_components/custom_ink_button.dart';
import 'package:jar/app/ui_components/gradient_border_side.dart' as gbs;
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';
import 'package:jar/presentation/res/translations_manager.dart';
import 'package:jar/presentation/views/product_details/riverpod/product_details_controller.dart';

/// Weight/size selector chips — "حجم العبوة" section from Figma
class ProductWeightSelector extends ConsumerWidget {
  final List<String> weights;

  const ProductWeightSelector({
    super.key,
    this.weights = const ['500 جم', '1 كجم', '2 كجم'],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(
      productDetailsController.select((s) => s.selectedWeightIndex),
    );
    final notifier = ref.read(productDetailsController.notifier);

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
            spacing: 10.w,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(weights.length, (index) {
              final isSelected = selectedIndex == index;
              return _WeightChip(
                label: weights[index],
                isSelected: isSelected,
                onTap: () => notifier.selectWeight(index),
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
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      backgroundColor: ColorM.transparent,
      side: gbs.BorderSide(
        color: isSelected ? ColorM.primary : ColorM.gray200,
        width: 1.w,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4.w,
        children: [
          SizedBox(
            width: 14.w,
            height: 14.w,
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
