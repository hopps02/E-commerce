import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';

/// The known details a product can carry, in the shopper's language. Anything
/// the panel invented beyond these keeps its own name.
const Map<String, String> _labels = {
  'weight': 'الوزن',
  'dimensions': 'الأبعاد',
  'color': 'اللون',
  'size': 'المقاس',
  'material': 'الخامة',
  'origin': 'بلد المنشأ',
  'supplier': 'المورد',
  'warranty': 'الضمان',
  'expiry': 'تاريخ الصلاحية',
  'storage': 'طريقة التخزين',
};

/// "المواصفات" — whatever the panel filled in for this product, and nothing
/// else. An empty set draws nothing at all.
class ProductSpecs extends StatelessWidget {
  final Map<String, String> attributes;

  const ProductSpecs({super.key, required this.attributes});

  @override
  Widget build(BuildContext context) {
    final rows = attributes.entries
        .where((entry) => entry.value.trim().isNotEmpty)
        .toList();

    if (rows.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'المواصفات',
            style: context.bodyLarge.copyWith(
              color: ColorM.gray800,
              fontWeight: FontWeightM.medium,
            ),
          ),
          11.verticalSpace,
          for (final row in rows) ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 110,
                    child: Text(
                      _labels[row.key] ?? row.key,
                      style: context.bodyMedium.copyWith(
                        color: ColorM.gray500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row.value,
                      style: context.bodyMedium.copyWith(
                        color: ColorM.gray900,
                        fontWeight: FontWeightM.medium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (row.key != rows.last.key)
              Container(height: 1, color: ColorM.gray150),
          ],
        ],
      ),
    );
  }
}
