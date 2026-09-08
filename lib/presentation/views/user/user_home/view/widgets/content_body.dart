import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/extensions/guest_gate.dart';
import 'package:store/app/utils/money.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/presentation/common/fast_state_render.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/cart/riverpod/cart_controller.dart';
import 'package:store/presentation/views/user/favorites/riverpod/favorites_controller.dart';
import 'package:store/presentation/views/user/product_details/view/screens/product_details_view.dart';
import 'package:store/presentation/views/user/user_home/riverpod/home_catalog_controller.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/categories_section.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/new_arrivals_banner.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/offer_banner.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/products_section.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/top_category.dart';
import 'package:store/presentation/views/user/products/view/screens/products_view.dart';

class ContentBody extends ConsumerStatefulWidget {
  final double bottomSafeAreaPadding;
  final Future<void> Function() onChooseAddress;

  const ContentBody({
    super.key,
    required this.bottomSafeAreaPadding,
    required this.onChooseAddress,
  });

  @override
  ConsumerState<ContentBody> createState() => _ContentBodyState();
}

class _ContentBodyState extends ConsumerState<ContentBody> {
  bool _requestedCatalog = false;

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(homeCatalogController);

    // The store has one catalogue and no coverage area, so it loads on first
    // build — an address is only needed to check out.
    if (!_requestedCatalog) {
      _requestedCatalog = true;
      Future.microtask(() {
        if (!mounted) return;
        ref.read(homeCatalogController.notifier).load();
      });
    }

    return FastStateRender(
      reqState: catalog.reqState,
      alignment: const Alignment(0, -0.2),
      errorMessage: catalog.errorMessage,
      onRetry: () => ref.read(homeCatalogController.notifier).load(),
      child: Body(
        bottomSafeAreaPadding: widget.bottomSafeAreaPadding,
        catalog: catalog,
      ),
    );
  }
}



class Body extends ConsumerWidget {
  const Body({
    super.key,
    required this.bottomSafeAreaPadding,
    required this.catalog,
  });

  final double bottomSafeAreaPadding;
  final HomeCatalogState catalog;

  void _openProducts(
    BuildContext context,
    ProductCategory category,
    bool arabic,
  ) {
    context.pushNamed(
      Routes.products,
      arguments: ProductsViewArgs(
        title: category.name(arabic),
        categoryId: category.id,
      ),
    );
  }

  void _openDetails(BuildContext context, BranchProduct product) {
    context.pushNamed(
      Routes.productDetails,
      arguments: ProductDetailsViewArgs(
        productId: product.id,
        initial: product,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arabic = context.locale.languageCode == 'ar';
    final cart = ref.watch(cartController);
    final cartNotifier = ref.read(cartController.notifier);
    final favorites = ref.watch(favoritesController);
    final favoritesNotifier = ref.read(favoritesController.notifier);

    // Seed favorite hearts from the loaded home sections.
    ref.listen(homeCatalogController.select((s) => s.sections), (_, sections) {
      favoritesNotifier.seedFrom([for (final s in sections) ...s.products]);
    });

    return ListView(
      padding: EdgeInsets.only(bottom: bottomSafeAreaPadding),
      children: [
        10.verticalSpace,
        TopCategory().premiumAppear(index: 0, wantKeepAlive: true),
        18.verticalSpace,
        const OfferBanner().premiumAppear(index: 1, wantKeepAlive: true),
        18.verticalSpace,
        CategoriesSection(
          categories: catalog.categories,
        ).premiumAppear(index: 2, wantKeepAlive: true),
        for (final (sectionIndex, section) in catalog.sections.indexed) ...[
          18.verticalSpace,
          if (sectionIndex == 1)
            // The promo banner sits between the two product rows, as designed.
            NewArrivalsBanner(
              onShopNowTap: () =>
                  _openProducts(context, section.category, arabic),
            ).premiumAppear(index: 3 + sectionIndex, wantKeepAlive: true),
          if (sectionIndex == 1) 18.verticalSpace,
          ProductsSection(
            title: section.category.name(arabic),
            subtitle: Translation.quick_choices.tr,
            onViewAllTap: () =>
                _openProducts(context, section.category, arabic),
            onProductTap: (index) =>
                _openDetails(context, section.products[index]),
            onLimitReached: () => cartNotifier.notifyStockLimit(),
            onQuantityChanged: (index, quantity) =>
                _updateSectionProductQuantity(
                  context,
                  ref,
                  cartNotifier,
                  section.products[index],
                  cart.quantityOf(section.products[index].id),
                  quantity,
                ),
            onFavTap: (index) async {
              if (!await requireLogin(context, ref)) return;
              await favoritesNotifier.toggle(section.products[index]);
            },
            products: [
              for (final product in section.products)
                {
                  'id': product.id,
                  'name': product.name(arabic),
                  'image': product.imageUrl ?? '',
                  'price': Money.asRiyals(product.effectivePriceHalalas),
                  'oldPrice': product.hasDiscount
                      ? Money.asRiyals(product.priceHalalas)
                      : null,
                  'quantity': cart.quantityOf(product.id),
                  'available': product.available,
                  'isFavorite': favorites.contains(product.id),
                },
            ],
          ).premiumAppear(index: 4 + sectionIndex, wantKeepAlive: true),
        ],
        18.verticalSpace,
      ],
    );
  }

  void _updateSectionProductQuantity(
    BuildContext context,
    WidgetRef ref,
    CartNotifier cartNotifier,
    BranchProduct product,
    int currentQuantity,
    int quantity,
  ) {
    if (quantity < currentQuantity) {
      cartNotifier.setQuantity(product, quantity);
      return;
    }

    addToCartGuarded(context, ref, product, quantity);
  }
}
