import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/indicators/state_render.dart';
import 'package:store/presentation/common/cart_branch_resolution_state.dart';
import 'package:store/presentation/common/fast_state_render.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/cart/riverpod/cart_controller.dart';
import 'package:store/presentation/views/user/cart/riverpod/checkout_controller.dart';
import 'package:store/presentation/views/user/cart/view/widgets/cart_item_card.dart';

class CartData extends ConsumerWidget {
  const CartData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartController);
    final checkout = ref.watch(checkoutController);
    final arabic = context.locale.languageCode == 'ar';
    if (cart.isEmpty) {
      return Expanded(
        child: FastStateRender(
          reqState: ReqState.empty,
          alignment: const Alignment(0, -0.22),
          errorMessage: Translation.cart_empty.tr,
          child: const SizedBox.shrink(),
        ),
      );
    }

    if (checkout.requiresCartBranchResolution) {
      return Expanded(
        child: CartBranchResolutionState(
          message: checkout.errorMessage,
          onClearCart: () {
            ref.read(cartController.notifier).clear();
            context.goNamed(Routes.home);
          },
          onDismiss: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).maybePop();
              return;
            }
            context.goNamed(Routes.home);
          },
        ),
      );
    }

    return Expanded(
      child: FastStateRender(
        reqState: checkout.reqState,
        alignment: const Alignment(0, -0.22),
        errorMessage: checkout.errorMessage,
        onRetry: () => ref.read(checkoutController.notifier).retry(),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: SizeM.pagePadding,
            vertical: 16,
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
              priceHalalas: product?.effectivePriceHalalas ?? 0,
              imageUrl: product?.imageUrl ?? '',
              initialQuantity: line.quantity,
              maxQuantity: product?.available,
              onLimitReached: () =>
                  ref.read(cartController.notifier).notifyStockLimit(),
              onQuantityChanged: (quantity) {
                if (product == null) return;
                ref
                    .read(cartController.notifier)
                    .setQuantity(product, quantity);
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
