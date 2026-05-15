import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/view_extensions.dart';
import 'package:for_u/app/ui_components/customized_smart_refresh.dart';
import 'package:for_u/app/utils/state_render.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/views/home/view/widgets/product_card.dart';
import 'package:for_u/presentation/views/search/riverpod/search_controller.dart';
import 'package:for_u/app/extensions/widget_extensions.dart';

class SearchData extends ConsumerWidget {
  const SearchData({super.key});

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
          classicFooterPadding: EdgeInsets.only(
            bottom: context.bottomSafeAreaPadding,
          ),
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
            itemCount: 20,
            itemBuilder: (context, index) {
              return ProductCard(
                fitForGridList: true,
                title: "الكرنب الأخضر",
                imageUrl: "",
                price: 12,
                oldPrice: 18,
                quantity: 0,
                isFavorite: false,
                onFavTap: () {},
                onQuantityChanged: (_) {},
              ).premiumAppear(index: (index % 2) + 1);
            },
          ),
        ),
      ),
    );
  }
}
