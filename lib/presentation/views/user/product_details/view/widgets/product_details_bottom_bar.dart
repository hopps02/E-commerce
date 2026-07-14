import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/shapes/gradient_border_side.dart';
import 'package:store/app/utils/money.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/cart/riverpod/cart_controller.dart';

/// The product page's sticky bar: the price (with any discount) on one side and,
/// on the other, an action that MORPHS between "add to cart" and a live quantity
/// stepper. The cart is the single source of truth — the bar reflects it and the
/// stepper writes straight back to it, so the app-bar cart badge stays in sync.
class ProductDetailsBottomBar extends ConsumerWidget {
  final BranchProduct product;

  const ProductDetailsBottomBar({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arabic = context.locale.languageCode == 'ar';
    final cartQuantity = ref.watch(
      cartController.select((s) => s.quantityOf(product.id)),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: ColorM.white,
        boxShadow: [
          BoxShadow(
            color: ColorM.gray900.withValues(alpha: 0.08),
            blurRadius: 30.r,
            offset: Offset(0, -10.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 1, color: ColorM.gray150),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              16,
              14,
              16,
              14.h + context.bottomSafeAreaPadding,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _PriceBlock(product: product, arabic: arabic),
                ),
                12.horizontalSpace,
                AnimatedSize(
                  duration: const Duration(milliseconds: 240),
                  curve: Curves.easeOutCubic,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: Tween<double>(
                          begin: 0.9,
                          end: 1,
                        ).animate(animation),
                        child: child,
                      ),
                    ),
                    child: _action(context, ref, cartQuantity),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _action(BuildContext context, WidgetRef ref, int cartQuantity) {
    if (!product.inStock) {
      return const _OutOfStockChip(key: ValueKey('out-of-stock'));
    }
    if (cartQuantity == 0) {
      return _AddToCartButton(
        key: const ValueKey('add-to-cart'),
        onTap: () {
          addToCartGuarded(context, ref, product, 1);
        },
      );
    }
    return _QuantityStepper(
      key: const ValueKey('stepper'),
      quantity: cartQuantity,
      canIncrease: cartQuantity < product.available,
      onDecrease: () => ref
          .read(cartController.notifier)
          .setQuantity(product, cartQuantity - 1),
      onIncrease: () => ref
          .read(cartController.notifier)
          .setQuantity(product, cartQuantity + 1),
    );
  }
}

class _PriceBlock extends StatelessWidget {
  final BranchProduct product;
  final bool arabic;

  const _PriceBlock({required this.product, required this.arabic});

  @override
  Widget build(BuildContext context) {
    final hasDiscount = product.hasDiscount;
    final percent = hasDiscount && product.priceHalalas > 0
        ? ((product.discountHalalas / product.priceHalalas) * 100).round()
        : 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasDiscount && percent > 0) ...[
          _SaveBadge(percent: percent),
          6.verticalSpace,
        ],
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Text(
                Money.format(product.effectivePriceHalalas, arabic: arabic),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.titleMedium.copyWith(
                  color: ColorM.primary700,
                  fontWeight: FontWeightM.bold,
                  fontSize: 18,
                  height: 1,
                ),
              ),
            ),
            if (hasDiscount) ...[
              8.horizontalSpace,
              Text(
                Money.format(product.priceHalalas, arabic: arabic),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.labelMedium.copyWith(
                  color: ColorM.gray500,
                  fontWeight: FontWeightM.medium,
                  height: 1,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: ColorM.gray500,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _SaveBadge extends StatelessWidget {
  final int percent;

  const _SaveBadge({required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3.h),
      decoration: ShapeDecoration(
        color: ColorM.primary50,
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Text(
        Translation.save_percent.trNamed({'percent': '$percent'}),
        style: context.labelMedium.copyWith(
          color: ColorM.primary600,
          fontWeight: FontWeightM.bold,
          fontSize: 11,
          height: 1,
        ),
      ),
    );
  }
}

class _AddToCartButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddToCartButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: onTap,
      height: 48,
      borderRadius: 15.r,
      smoothness: 0.8,
      backgroundColor: ColorM.primary500,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      side: GradientBorderSide(color: ColorM.primary600, width: 1.w),
      boxShadow: [
        BoxShadow(
          color: ColorM.primary500.withValues(alpha: 0.22),
          blurRadius: 18.r,
          offset: Offset(0, 7.h),
        ),
      ],
      pressEffect: const ButtonAnimationSettings(
        ButtonAnimation.scaleHold,
        duration: Duration(milliseconds: 180),
        intensity: 0.4,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add_shopping_cart_rounded, color: ColorM.white, size: 19),
          8.horizontalSpace,
          Text(
            Translation.add_to_cart.tr,
            style: context.bodyLarge.copyWith(
              color: ColorM.white,
              fontWeight: FontWeightM.semiBold,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _OutOfStockChip extends StatelessWidget {
  const _OutOfStockChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: ShapeDecoration(
        color: ColorM.gray150,
        shape: SmoothRectangleBorder(
          smoothness: 0.8,
          borderRadius: BorderRadius.circular(15.r),
          side: GradientBorderSide(color: ColorM.gray250, width: 1.w),
        ),
      ),
      child: Text(
        Translation.unavailable.tr,
        style: context.bodyLarge.copyWith(
          color: ColorM.gray500,
          fontWeight: FontWeightM.semiBold,
          height: 1,
        ),
      ),
    );
  }
}

class _QuantityStepper extends StatelessWidget {
  final int quantity;
  final bool canIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  const _QuantityStepper({
    super.key,
    required this.quantity,
    required this.canIncrease,
    required this.onDecrease,
    required this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    // The minus is always enabled: at quantity 1 it removes the line and the
    // bar morphs back to "add to cart".
    final decreaseControl = _StepperControl(
      icon: quantity > 1 ? Icons.remove_rounded : Icons.delete_outline_rounded,
      enabled: true,
      onTap: onDecrease,
    );
    final increaseControl = _StepperControl(
      icon: Icons.add_rounded,
      enabled: canIncrease,
      onTap: onIncrease,
    );
    final quantityLabel = _QuantityLabel(quantity: quantity);
    final List<Widget> controls = context.isRTL
        ? [increaseControl, quantityLabel, decreaseControl]
        : [decreaseControl, quantityLabel, increaseControl];

    return Container(
      width: 132,
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: ShapeDecoration(
        color: ColorM.gray100,
        shape: SmoothRectangleBorder(
          smoothness: 0.8,
          borderRadius: BorderRadius.circular(15.r),
          side: GradientBorderSide(color: ColorM.gray250, width: 1.w),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: controls,
      ),
    );
  }
}

class _StepperControl extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _StepperControl({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: onTap,
      enabled: enabled,
      width: 36,
      height: 36,
      borderRadius: 11.r,
      smoothness: 0.8,
      backgroundColor: enabled ? ColorM.white : ColorM.gray150,
      side: GradientBorderSide(
        color: enabled ? ColorM.primary50 : ColorM.gray250,
        width: 1,
      ),
      pressEffect: const ButtonAnimationSettings(
        ButtonAnimation.scaleHold,
        duration: Duration(milliseconds: 160),
        intensity: 0.45,
      ),
      child: Icon(
        icon,
        size: 20,
        color: enabled ? ColorM.primary550 : ColorM.gray500,
      ),
    );
  }
}

class _QuantityLabel extends StatelessWidget {
  final int quantity;

  const _QuantityLabel({required this.quantity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: Tween<double>(begin: 0.6, end: 1).animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        ),
        child: Text(
          '$quantity',
          key: ValueKey(quantity),
          textAlign: TextAlign.center,
          style: context.titleMedium.copyWith(
            color: ColorM.gray950,
            fontWeight: FontWeightM.bold,
            height: 1,
          ),
        ),
      ),
    );
  }
}
