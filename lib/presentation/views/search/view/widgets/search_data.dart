import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/view_extensions.dart';
import 'package:jar/app/ui_components/customized_smart_refresh.dart';
import 'package:jar/app/utils/state_render.dart';
import 'package:jar/presentation/common/fast_state_render.dart';
import 'package:jar/presentation/res/sizes_manager.dart';
import 'package:jar/presentation/views/home/view/widgets/product_card.dart';
import 'package:jar/presentation/views/search/riverpod/search_controller.dart';

class SearchData extends ConsumerWidget {
  const SearchData({super.key, required List<Map<String, dynamic>> allProducts})
    : _allProducts = allProducts;

  final List<Map<String, dynamic>> _allProducts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchController);
    final searchNotifier = ref.read(searchController.notifier);
    return Expanded(
      child: FastStateRender(
        reqState: ReqState.success /* searchState.reqState */,
        child: CustomizedSmartRefresh(
          enableLoading: true,
          controller: searchNotifier.searchRefreshController,
          classicFooterPadding: EdgeInsets.only(bottom: context.bottomSafeAreaPadding),
          onRefresh: () {
            Timer(const Duration(seconds: 2), () {
              searchNotifier.searchRefreshController.refreshCompleted();
            });
          },
          onLoading: () {
            Timer(const Duration(seconds: 2), () {
              searchNotifier.searchRefreshController.loadComplete();
            });
          },
          child: GridView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: SizeM.pagePadding.w,
              vertical: 16.h,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: .8,
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
        ),
      ),
    );
  }
}
