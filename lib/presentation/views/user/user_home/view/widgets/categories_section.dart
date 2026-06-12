import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/data/models/customer/catalog_models.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/section_header.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/category_grid_item.dart';
import 'package:for_u/presentation/views/user/products/view/screens/products_view.dart';

class CategoriesSection extends StatelessWidget {
  final List<ProductCategory> categories;
  const CategoriesSection({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final arabic = context.locale.languageCode == 'ar';

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w),
          child: SectionHeader(
            title: Translation.categories.tr,
            onViewAllTap: () {
              context.pushNamed(Routes.sections);
            },
          ),
        ),
        16.verticalSpace,

        Wrap(
          spacing: 15.w,
          runSpacing: 16.h,
          alignment: WrapAlignment.start,
          children: categories.map((category) {
            final title = category.name(arabic);
            return CategoryGridItem(
              title: title,
              imageUrl: '',
              onTap: () {
                context.pushNamed(
                  Routes.products,
                  arguments: ProductsViewArgs(
                    title: title,
                    categoryId: category.id,
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
