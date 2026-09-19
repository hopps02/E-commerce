import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/extensions/cart_branch_guard.dart';
import 'package:store/app/extensions/guest_gate.dart';
import 'package:store/app/utils/money.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/cart/riverpod/cart_controller.dart';
import 'package:store/presentation/views/user/favorites/riverpod/favorites_controller.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/products_section.dart';

/// The rest of the category, under the product the shopper is looking at.
///
/// It is the same row the home screen uses, so a card behaves the same
/// wherever it is seen: the heart, the quantity, the price.
class SimilarProducts extends ConsumerWidget {
  final List<BranchProduct> products;

  /// Opening one is the screen's business: it has to reload itself when the
  /// shopper comes back from the product it pushed.
  final void Function(BranchProduct product) onOpen;

  const SimilarProducts({
    super.key,
    required this.products,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (products.isEmpty) return const SizedBox.shrink();

    final arabic = context.locale.languageCode == 'ar';
    final cart = ref.watch(cartController);
    final cartNotifier = ref.read(cartController.notifier);
    final favorites = ref.watch(favoritesController);

    return ProductsSection(
      title: Translation.similar_products.tr,
      onProductTap: (index) => onOpen(products[index]),
      onLimitReached: () => cartNotifier.notifyStockLimit(),
      onQuantityChanged: (index, quantity) {
        final product = products[index];
        if (quantity < cart.quantityOf(product.id)) {
          cartNotifier.setQuantity(product, quantity);
          return;
        }
        addToCartGuarded(context, ref, product, quantity);
      },
      onFavTap: (index) async {
        if (!await requireLogin(context, ref)) return;
        await ref.read(favoritesController.notifier).toggle(products[index]);
      },
      products: [
        for (final product in products)
          {
            'id': product.id,
            'name': product.name(arabic),
            'image': product.imageUrl ?? '',
            'price': Money.amount(product.effectivePriceHalalas),
            'oldPrice': product.hasDiscount
                ? Money.amount(product.priceHalalas)
                : null,
            'quantity': cart.quantityOf(product.id),
            'step': product.quantityStep,
            'unit': product.unitName,
            'available': product.available,
            'isFavorite': favorites.contains(product.id),
          },
      ],
    );
  }
}
