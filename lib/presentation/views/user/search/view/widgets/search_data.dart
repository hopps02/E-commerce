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
import 'package:for_u/presentation/views/user/product_details/view/screens/product_details_view.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/product_card.dart';
import 'package:for_u/presentation/views/user/search/riverpod/search_controller.dart';

class SearchData extends ConsumerWidget {
  const SearchData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchController);
    final searchNotifier = ref.read(searchController.notifier);
    final cart = ref.watch(cartController);
    final cartNotifier = ref.read(cartController.notifier);
    final arabic = context.locale.languageCode == 'ar';

    return Expanded(
      child: FastStateRender(
        reqState: searchState.reqState,
        errorMessage: searchState.errorMessage,
        onRetry: () => searchNotifier.refresh(),
        child: CustomizedSmartRefresh(
          enableLoading: true,
          controller: searchNotifier.searchRefreshController,
          classicFooterPadding: EdgeInsets.only(
            bottom: context.bottomSafeAreaPadding,
          ),
          onRefresh: () => searchNotifier.refresh(),
          onLoading: () => searchNotifier.loadMore(),
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
            itemCount: searchState.products.length,
            itemBuilder: (context, index) {
              final product = searchState.products[index];
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
        ),
      ),
    );
  }
}
