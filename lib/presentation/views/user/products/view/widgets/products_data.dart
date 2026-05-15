import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/extensions/view_extensions.dart';
import 'package:for_u/app/ui_components/customized_smart_refresh.dart';
import 'package:for_u/app/utils/state_render.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/product_card.dart';
import 'package:for_u/presentation/views/user/product_details/view/screens/product_details_view.dart';
import 'package:for_u/presentation/views/user/products/riverpod/products_controller.dart';
import 'package:for_u/app/extensions/widget_extensions.dart';

class ProductsData extends ConsumerWidget {
  const ProductsData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productsController);
    final productsNotifier = ref.read(productsController.notifier);
    return Expanded(
      child: FastStateRender(
        reqState: ReqState.success /* productsState.reqState */,
        child: CustomizedSmartRefresh(
          enableLoading: true,
          controller: productsNotifier.refreshController,
          classicFooterPadding: EdgeInsets.only(
            bottom: context.bottomSafeAreaPadding,
          ),
          onRefresh: () {
            Timer(const Duration(seconds: 2), () {
              productsNotifier.refreshController.refreshCompleted();
            });
          },
          onLoading: () {
            Timer(const Duration(seconds: 2), () {
              productsNotifier.refreshController.loadComplete();
            });
          },
          child: GridView.builder(
            padding:
                EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w) +
                EdgeInsets.only(
                  top: 16.h,
                  bottom: context.bottomPadding + SizeM.pagePadding.w,
                ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: .8,
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.pushNamed(
                    Routes.productDetails,
                    arguments: ProductDetailsViewArgs(productId: ''),
                  );
                },
                child: ProductCard(
                  fitForGridList: true,
                  title: 'الكرنب الأخضر',
                  imageUrl: '',
                  price: 10.0,
                  oldPrice: 12.0,
                  quantity: 1,
                  isFavorite: false,
                  onFavTap: () {},
                  onQuantityChanged: (_) {},
                ),
              ).premiumAppear(index: (index % 2) + 1);
            },
          ),
        ),
      ),
    );
  }
}
