import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/extensions/view_extensions.dart';
import 'package:for_u/app/ui_kit/customized_smart_refresh.dart';
import 'package:for_u/app/utils/money.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/views/user/cart/riverpod/cart_controller.dart';
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
    final cart = ref.watch(cartController);
    final cartNotifier = ref.read(cartController.notifier);
    final arabic = context.locale.languageCode == 'ar';

    return Expanded(
      child: FastStateRender(
        reqState: productsState.reqState,
        errorMessage: productsState.errorMessage,
        onRetry: () => productsNotifier.refresh(),
        child: CustomizedSmartRefresh(
          enableLoading: true,
          controller: productsNotifier.refreshController,
          classicFooterPadding: EdgeInsets.only(
            bottom: context.bottomSafeAreaPadding,
          ),
          onRefresh: () => productsNotifier.refresh(),
          onLoading: () => productsNotifier.loadMore(),
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
            itemCount: productsState.products.length,
            itemBuilder: (context, index) {
              final product = productsState.products[index];
              return ProductCard(
                fitForGridList: true,
                title: product.name(arabic),
                imageUrl: product.imageUrl ?? '',
                price: Money.asRiyals(product.effectivePriceHalalas),
                oldPrice: product.hasDiscount
                    ? Money.asRiyals(product.priceHalalas)
                    : null,
                quantity: cart.quantityOf(product.id),
                isFavorite: false,
                onFavTap: () {},
                onTap: () {
                  context.pushNamed(
                    Routes.productDetails,
                    arguments: ProductDetailsViewArgs(
                      productId: product.id,
                      initial: product,
                    ),
                  );
                },
                onQuantityChanged: (quantity) =>
                    cartNotifier.setQuantity(product, quantity),
              );
            },
          ),
        ).premiumAppear(),
      ),
    );
  }
}
