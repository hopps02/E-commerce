import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/category_grid_item.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/section_header.dart';
import 'package:for_u/presentation/views/user/products/view/screens/products_view.dart';

const int _categoryRows = 2;
const int _categoryColumns = 4;
const int _categoryItemsToShow = _categoryRows * _categoryColumns;
const double _categoryTileImageSize = 70;
const double _categoryTileLabelGap = 8;
const double _categoryTileLabelHeight = 44;
const double _categoryRowGap = 16;

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
        _CategoriesGrid(categories: categories, arabic: arabic),
      ],
    );
  }
}

class _CategoriesGrid extends StatelessWidget {
  final List<ProductCategory> categories;
  final bool arabic;

  const _CategoriesGrid({required this.categories, required this.arabic});

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }

    final tileHeight =
        _categoryTileImageSize.w +
        _categoryTileLabelGap.h +
        _categoryTileLabelHeight.h;

    // Only the first two rows are displayed (no carousel / scrolling).
    final visibleCategories = categories.length > _categoryItemsToShow
        ? categories.sublist(0, _categoryItemsToShow)
        : categories;

    final rows = <Widget>[];
    for (var rowIndex = 0; rowIndex < _categoryRows; rowIndex++) {
      final startIndex = rowIndex * _categoryColumns;
      if (startIndex >= visibleCategories.length) {
        break;
      }

      rows.add(
        _CategoryRow(
          categories: visibleCategories,
          arabic: arabic,
          startIndex: startIndex,
          tileHeight: tileHeight,
        ),
      );

      if (rowIndex < _categoryRows - 1 &&
          startIndex + _categoryColumns < visibleCategories.length) {
        rows.add(_categoryRowGap.verticalSpace);
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w),
      child: Column(children: rows),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final List<ProductCategory> categories;
  final bool arabic;
  final int startIndex;
  final double tileHeight;

  const _CategoryRow({
    required this.categories,
    required this.arabic,
    required this.startIndex,
    required this.tileHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List<Widget>.generate(_categoryColumns, (columnIndex) {
        final categoryIndex = startIndex + columnIndex;
        if (categoryIndex >= categories.length) {
          return SizedBox(width: _categoryTileImageSize.w, height: tileHeight);
        }

        final category = categories[categoryIndex];
        final title = category.name(arabic);

        return CategoryGridItem(
          title: title,
          imageUrl: category.imageUrl ?? '',
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
      }),
    );
  }
}
