import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/extensions/guest_gate.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/app/ui_kit/default_app_bar.dart';
import 'package:store/app/utils/money.dart';
import 'package:store/presentation/common/fast_state_render.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/cart/riverpod/cart_controller.dart';
import 'package:store/presentation/views/user/favorites/riverpod/favorites_controller.dart';
import 'package:store/presentation/views/user/product_details/view/screens/product_details_view.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/product_card.dart';
import 'package:store/presentation/res/spacing_manager.dart';

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
      body: ResponsiveConstrained(
        maxWidth: 450,
        child: Column(
          children: [
            SizedBox(height: context.topSafeAreaPadding),
            DefaultAppBar(
              padding: EdgeInsets.symmetric(
                vertical: SpaceM.s4,
                horizontal: SizeM.pagePadding,
              ),
              title: Translation.favorites.tr,
            ).premiumAppear(index: 0),
            Container(height: 6, color: ColorM.gray150).premiumAppear(index: 1),
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
                        top: SpaceM.s4,
                        bottom: context.bottomPadding + SizeM.pagePadding,
                      ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: .8,
                  ),
                  itemCount: favorites.products.length,
                  itemBuilder: (context, index) {
                    final product = favorites.products[index];
                    return ProductCard(
                      fitForGridList: true,
                      title: product.name(arabic),
                      imageUrl: product.imageUrl ?? '',
                      price: Money.amount(product.effectivePriceHalalas),
                      oldPrice: product.hasDiscount
                          ? Money.amount(product.priceHalalas)
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
