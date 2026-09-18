import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/product_card.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/section_header.dart';

class ProductsSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onViewAllTap;
  final void Function(int index)? onProductTap;
  final void Function(int index, double quantity)? onQuantityChanged;
  final void Function(int index)? onFavTap;
  final VoidCallback? onLimitReached;

  final List<Map<String, dynamic>> products;
  const ProductsSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.products,
    this.onViewAllTap,
    this.onProductTap,
    this.onQuantityChanged,
    this.onFavTap,
    this.onLimitReached,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: .min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w),
                child: SectionHeader(
                  title: title,
                  subtitle: subtitle,
                  onViewAllTap: onViewAllTap,
                ),
              ),
              16.verticalSpace,
              SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding),
                  itemCount: products.length,
                  separatorBuilder: (context, index) => 12.horizontalSpace,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      title: products[index]['name'],
                      imageUrl: products[index]['image'],
                      price: products[index]['price'],
                      oldPrice: products[index]['oldPrice'],
                      quantity: products[index]['quantity'],
                      step: products[index]['step'] ?? 1,
                      unitLabel: products[index]['unit'] ?? '',
                      maxQuantity: products[index]['available'],
                      isFavorite: products[index]['isFavorite'] == true,
                      onFavTap: onFavTap == null
                          ? null
                          : () => onFavTap!(index),
                      onTap: onProductTap == null
                          ? null
                          : () => onProductTap!(index),
                      onLimitReached: onLimitReached,
                      onQuantityChanged: (value) =>
                          onQuantityChanged?.call(index, value),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
