import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/product_card.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/section_header.dart';

class ProductsSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onViewAllTap;

  final List<Map<String, dynamic>> products;
  const ProductsSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.products,
    this.onViewAllTap,
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
                height: 200.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeM.pagePadding.w,
                  ),
                  itemCount: products.length,
                  separatorBuilder: (context, index) => 12.horizontalSpace,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      title: products[index]['name'],
                      imageUrl: products[index]['image'],
                      price: products[index]['price'],
                      oldPrice: products[index]['oldPrice'],
                      quantity: products[index]['quantity'],
                      onFavTap: () {},
                      onQuantityChanged: (value) {
                        print("quantity: $value");
                      },
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
