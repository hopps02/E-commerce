import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/category_grid_item.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/section_header.dart';
import 'package:store/presentation/views/user/products/view/screens/products_view.dart';

const int _categoryRowsPerPage = 3;
const int _categoryColumnsPerPage = 4;
const int _categoryItemsPerPage =
    _categoryRowsPerPage * _categoryColumnsPerPage;
const double _categoryViewportFraction = 1.0;
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
        _CategoriesCarousel(categories: categories, arabic: arabic),
      ],
    );
  }
}

class _CategoriesCarousel extends StatefulWidget {
  final List<ProductCategory> categories;
  final bool arabic;

  const _CategoriesCarousel({required this.categories, required this.arabic});

  @override
  State<_CategoriesCarousel> createState() => _CategoriesCarouselState();
}

class _CategoriesCarouselState extends State<_CategoriesCarousel> {
  late final PageController _pageController;
  int _currentPage = 0;

  int get _pageCount =>
      (widget.categories.length + _categoryItemsPerPage - 1) ~/
      _categoryItemsPerPage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: _categoryViewportFraction,
    );
  }

  @override
  void didUpdateWidget(covariant _CategoriesCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    final pageCount = _pageCount;
    if (pageCount == 0) {
      _currentPage = 0;
      return;
    }

    if (_currentPage >= pageCount) {
      _currentPage = pageCount - 1;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || !_pageController.hasClients) {
          return;
        }
        _pageController.jumpToPage(_currentPage);
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) {
      return const SizedBox.shrink();
    }

    final pageCount = _pageCount;
    final tileHeight =
        _categoryTileImageSize.w +
        _categoryTileLabelGap.h +
        _categoryTileLabelHeight.h;
    final pageHeight =
        (tileHeight * _categoryRowsPerPage) +
        (_categoryRowGap.h * (_categoryRowsPerPage - 1));

    return Column(
      children: [
        SizedBox(
          height: pageHeight,
          child: PageView.builder(
            controller: _pageController,
            padEnds: false,
            pageSnapping: true,
            physics: const PageScrollPhysics(),
            itemCount: pageCount,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, pageIndex) {
              final start = pageIndex * _categoryItemsPerPage;
              final end = start + _categoryItemsPerPage;
              final pageCategories = widget.categories.sublist(
                start,
                end > widget.categories.length ? widget.categories.length : end,
              );

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding),
                child: _CategoryCarouselPage(
                  categories: pageCategories,
                  arabic: widget.arabic,
                  tileHeight: tileHeight,
                ),
              );
            },
          ),
        ),
        if (pageCount > 1) ...[
          12.verticalSpace,
          _CategoryCarouselDots(
            pageCount: pageCount,
            currentPage: _currentPage,
          ),
        ],
      ],
    );
  }
}

class _CategoryCarouselPage extends StatelessWidget {
  final List<ProductCategory> categories;
  final bool arabic;
  final double tileHeight;

  const _CategoryCarouselPage({
    required this.categories,
    required this.arabic,
    required this.tileHeight,
  });

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var rowIndex = 0; rowIndex < _categoryRowsPerPage; rowIndex++) {
      rows.add(
        Expanded(
          child: _CategoryCarouselRow(
            categories: categories,
            arabic: arabic,
            startIndex: rowIndex * _categoryColumnsPerPage,
            tileHeight: tileHeight,
          ),
        ),
      );

      if (rowIndex < _categoryRowsPerPage - 1) {
        rows.add(_categoryRowGap.verticalSpace);
      }
    }

    return Column(children: rows);
  }
}

class _CategoryCarouselRow extends StatelessWidget {
  final List<ProductCategory> categories;
  final bool arabic;
  final int startIndex;
  final double tileHeight;

  const _CategoryCarouselRow({
    required this.categories,
    required this.arabic,
    required this.startIndex,
    required this.tileHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List<Widget>.generate(_categoryColumnsPerPage, (columnIndex) {
        final categoryIndex = startIndex + columnIndex;
        if (categoryIndex >= categories.length) {
          return SizedBox(width: _categoryTileImageSize, height: tileHeight);
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

class _CategoryCarouselDots extends StatelessWidget {
  final int pageCount;
  final int currentPage;

  const _CategoryCarouselDots({
    required this.pageCount,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(pageCount, (index) {
        final isActive = index == currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          width: isActive ? 20.w : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? ColorM.primary : ColorM.gray300,
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}
