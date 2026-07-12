import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/default_app_bar.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/cart/riverpod/cart_controller.dart';
import 'package:store/app/ui_kit/shapes/gradient_border_side.dart';

class ProductDetailsAppBar extends StatelessWidget {
  const ProductDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 17.h),
      child: DefaultAppBar(
        title: Translation.product_details.tr,
        titleAlignment: .center,
        actionButtons: [_CartIconButton()],
      ),
    );
  }
}

class _CartIconButton extends ConsumerWidget {
  const _CartIconButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartCount = ref.watch(cartController.select((s) => s.itemsCount));

    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomInkButton(
          onTap: () => context.pushNamed(Routes.cart),
          padding: EdgeInsets.zero,
          width: 38.w,
          height: 38.w,
          smoothness: 0,
          backgroundColor: ColorM.white,
          borderRadius: 12.r,
          alignment: Alignment.center,
          side: GradientBorderSide(color: ColorM.gray300, width: 1.w),
          child: SvgPicture.asset(
            Assets.svg.borderBag.path,
            width: 22.w,
            height: 22.w,
            colorFilter: ColorFilter.mode(ColorM.gray900, BlendMode.srcIn),
          ),
        ),
        if (cartCount > 0)
          PositionedDirectional(
            top: -6.h,
            end: -6.w,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Container(
                key: ValueKey(cartCount),
                constraints: BoxConstraints(minWidth: 18.w, minHeight: 18.w),
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorM.primary500,
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: ColorM.white, width: 1.5.w),
                ),
                child: Text(
                  cartCount > 99 ? '99+' : '$cartCount',
                  style: context.labelLarge.copyWith(
                    color: ColorM.white,
                    fontWeight: FontWeightM.bold,
                    fontSize: 9.sp,
                    height: 1,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
