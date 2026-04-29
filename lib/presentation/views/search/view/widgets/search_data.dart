import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/presentation/res/sizes_manager.dart';
import 'package:jar/presentation/views/home/view/widgets/product_card.dart';

class SearchData extends StatelessWidget {
  const SearchData({
    super.key,
    required List<Map<String, dynamic>> allProducts,
  }) : _allProducts = allProducts;

  final List<Map<String, dynamic>> _allProducts;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: SizeM.pagePadding.w,
          vertical: 16.h,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: .85,
        ),
        itemCount: _allProducts.length,
        itemBuilder: (context, index) {
          final p = _allProducts[index];
          return ProductCard(
            fitForGridList: true,
            title: p['name'],
            imageUrl: p['image'],
            price: p['price'],
            oldPrice: p['oldPrice'],
            quantity: p['quantity'],
            isFavorite: p['isFavorite'] ?? false,
            onFavTap: () {},
            onQuantityChanged: (_) {},
          );
        },
      ),
    );
  }
}
