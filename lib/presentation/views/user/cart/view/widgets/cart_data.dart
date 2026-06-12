import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/app/utils/money.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/views/user/cart/riverpod/cart_controller.dart';
import 'package:for_u/presentation/views/user/cart/riverpod/checkout_controller.dart';
import 'package:for_u/presentation/views/user/cart/view/widgets/cart_item_card.dart';
import 'package:for_u/app/extensions/widget_extensions.dart';

class CartData extends ConsumerWidget {
  const CartData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartController);
    final checkout = ref.watch(checkoutController);
    final arabic = context.locale.languageCode == 'ar';

    return Expanded(
      child: FastStateRender(
        reqState: cart.isEmpty ? ReqState.empty : checkout.reqState,
        alignment: const Alignment(0, -0.22),
        errorMessage: checkout.errorMessage,
        onRetry: () => ref.read(checkoutController.notifier).retry(),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: SizeM.pagePadding.w,
            vertical: 16.h,
          ),
          physics: const BouncingScrollPhysics(),
          itemCount: cart.lines.length,
          separatorBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Divider(color: ColorM.gray200, height: 1),
          ),
          itemBuilder: (context, index) {
            final line = cart.lines[index];
            final product = line.product;
            return CartItemCard(
              title: product?.name(arabic) ?? '',
              weight: '',
              price: Money.asRiyals(product?.effectivePriceHalalas ?? 0),
              imageUrl: product?.imageUrl ?? '',
              initialQuantity: line.quantity,
              maxQuantity: product?.available,
              onLimitReached: () =>
                  ref.read(cartController.notifier).notifyStockLimit(),
              onQuantityChanged: (quantity) {
                if (product == null) return;
                ref.read(cartController.notifier).setQuantity(
                  product,
                  quantity,
                );
              },
              onDelete: () => ref
                  .read(cartController.notifier)
                  .removeLine(line.branchItemId),
            );
          },
        ).premiumAppear(wantKeepAlive: true),
      ),
    );
  }
}
