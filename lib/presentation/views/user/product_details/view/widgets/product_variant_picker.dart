import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/views/user/product_details/view/widgets/product_specs.dart';
import 'package:store/presentation/res/spacing_manager.dart';

/// The sizes or colours the product comes in. Picking one swaps the price,
/// what is left on the shelf, and what the cart button adds — nothing else
/// on the screen moves.
class ProductVariantPicker extends StatelessWidget {
  final List<ProductVariant> variants;
  final int selectedId;
  final ValueChanged<int> onPick;

  const ProductVariantPicker({
    super.key,
    required this.variants,
    required this.selectedId,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    if (variants.length < 2) return const SizedBox.shrink();

    // They all differ in the same thing, so the first one names it.
    final keys = variants.first.attributes.keys;
    final key = keys.isEmpty ? '' : keys.first;
    final title = specLabels[key] ?? (key.isEmpty ? 'اختر النسخة' : key);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SpaceM.s4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.bodyLarge.copyWith(
              color: ColorM.gray800,
              fontWeight: FontWeightM.medium,
            ),
          ),
          SpaceM.heading.verticalSpace,
          Wrap(
            spacing: SpaceM.s2.w,
            runSpacing: SpaceM.s2.h,
            children: [
              for (final variant in variants)
                _VariantChip(
                  label: variant.name.isEmpty ? "—" : variant.name,
                  selected: variant.id == selectedId,
                  soldOut: !variant.inStock,
                  onTap: () => onPick(variant.id),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// One choice. A size with nothing left of it is shown, not hidden: the
/// shopper should see it exists and that it ran out.
class _VariantChip extends StatelessWidget {
  final String label;
  final bool selected;
  final bool soldOut;
  final VoidCallback onTap;

  const _VariantChip({
    required this.label,
    required this.selected,
    required this.soldOut,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: soldOut ? null : onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: SpaceM.s4.w, vertical: SpaceM.s2.h),
        decoration: BoxDecoration(
          color: selected ? ColorM.lightPrimary : ColorM.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? ColorM.primary : ColorM.gray200,
            width: selected ? 1.4 : 1,
          ),
        ),
        child: Text(
          label,
          style: context.bodyMedium.copyWith(
            color: soldOut
                ? ColorM.gray400
                : selected
                ? ColorM.primary
                : ColorM.gray800,
            fontWeight: selected ? FontWeightM.medium : FontWeightM.regular,
            decoration: soldOut ? TextDecoration.lineThrough : null,
          ),
        ),
      ),
    );
  }
}
