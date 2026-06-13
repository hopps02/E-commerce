import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/extensions/view_extensions.dart';
import 'package:for_u/app/ui_kit/default_app_bar.dart';
import 'package:for_u/app/utils/money.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/cart/riverpod/cart_controller.dart';
import 'package:for_u/presentation/views/user/favorites/riverpod/favorites_controller.dart';
import 'package:for_u/presentation/views/user/product_details/view/screens/product_details_view.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/product_card.dart';
import 'package:for_u/app/extensions/widget_extensions.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(favoritesController.notifier).load());
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoritesController);
    final favoritesNotifier = ref.read(favoritesController.notifier);
    final cart = ref.watch(cartController);
    final cartNotifier = ref.read(cartController.notifier);
    final arabic = context.locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: ColorM.white,
      body: Column(
        children: [
          SizedBox(height: context.topSafeAreaPadding),
          DefaultAppBar(
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: SizeM.pagePadding.w,
            ),
            title: Translation.favorites.tr,
          ).premiumAppear(index: 0),
          Container(height: 6.h, color: ColorM.gray150).premiumAppear(index: 1),
          Expanded(
            child: FastStateRender(
              reqState: favorites.reqState,
              errorMessage: favorites.errorMessage.trim().isEmpty
                  ? Translation.no_favorites.tr
                  : favorites.errorMessage,
              alignment: const Alignment(0, -0.22),
              onRetry: () => favoritesNotifier.load(),
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
                itemCount: favorites.products.length,
                itemBuilder: (context, index) {
                  final product = favorites.products[index];
                  return ProductCard(
                    fitForGridList: true,
                    title: product.name(arabic),
                    imageUrl: product.imageUrl ?? '',
                    price: Money.asRiyals(product.effectivePriceHalalas),
                    oldPrice: product.hasDiscount
                        ? Money.asRiyals(product.priceHalalas)
                        : null,
                    quantity: cart.quantityOf(product.id),
                    maxQuantity: product.available,
                    isFavorite: favorites.contains(product.id),
                    onFavTap: () => favoritesNotifier.toggle(product),
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
                    onQuantityChanged: (quantity) =>
                        cartNotifier.setQuantity(product, quantity),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
