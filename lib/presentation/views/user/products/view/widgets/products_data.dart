import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/extensions/guest_gate.dart';
import 'package:store/app/ui_kit/customized_smart_refresh.dart';
import 'package:store/app/utils/money.dart';
import 'package:store/presentation/common/fast_state_render.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/views/user/cart/riverpod/cart_controller.dart';
import 'package:store/presentation/views/user/favorites/riverpod/favorites_controller.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/product_card.dart';
import 'package:store/presentation/views/user/product_details/view/screens/product_details_view.dart';
import 'package:store/presentation/views/user/products/riverpod/products_controller.dart';
import 'package:store/presentation/res/spacing_manager.dart';

class ProductsData extends ConsumerWidget {
  const ProductsData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productsController);
    final productsNotifier = ref.read(productsController.notifier);
    final cart = ref.watch(cartController);
    final cartNotifier = ref.read(cartController.notifier);
    final favorites = ref.watch(favoritesController);
    final favoritesNotifier = ref.read(favoritesController.notifier);
    final arabic = context.locale.languageCode == 'ar';

    // Seed favorite hearts from each loaded page's is_favorite flags.
    ref.listen(productsController.select((s) => s.products), (_, products) {
      favoritesNotifier.seedFrom(products);
    });

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
                  top: SpaceM.s4,
                  bottom: context.bottomPadding + SizeM.pagePadding,
                ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
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
                step: product.quantityStep,
                unitLabel: product.unitName,
                maxQuantity: product.available,
                isFavorite: favorites.contains(product.id),
                onFavTap: () async {
                  if (!await requireLogin(context, ref)) return;
                  await favoritesNotifier.toggle(product);
                },
                onTap: () {
                  context.pushNamed(
                    Routes.productDetails,
                    arguments: ProductDetailsViewArgs(
                      productId: product.id,
                      initial: product,
                    ),
                  );
                },
                onLimitReached: () => cartNotifier.notifyStockLimit(),
                onQuantityChanged: (quantity) {
                  final currentQuantity = cart.quantityOf(product.id);
                  if (quantity < currentQuantity) {
                    cartNotifier.setQuantity(product, quantity);
                    return;
                  }

                  addToCartGuarded(context, ref, product, quantity);
                },
              );
            },
          ),
        ).premiumAppear(),
      ),
    );
  }
}
