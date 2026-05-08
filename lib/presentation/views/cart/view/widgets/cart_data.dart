import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/presentation/common/fast_state_render.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/sizes_manager.dart';
import 'package:jar/presentation/views/cart/riverpod/cart_controller.dart';
import 'package:jar/presentation/views/cart/view/widgets/cart_item_card.dart';
import 'package:jar/app/extensions/widget_extensions.dart';

class CartData extends StatelessWidget {
  const CartData({
    super.key,
    required this.state,
    required this.notifier,
  });

  final CartState state;
  final CartController notifier;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FastStateRender(
        reqState: state.reqState,
        alignment: Alignment(0, -0.22),
        errorMessage: state.errorMessage,
        onRetry: (){},
        child: ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: SizeM.pagePadding.w,
            vertical: 16.h,
          ),
          physics: const BouncingScrollPhysics(),
          itemCount: 4,
          separatorBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Divider(color: ColorM.gray200, height: 1),
          ),
          itemBuilder: (context, index) {
            return CartItemCard(
              title: "جزر أصفر (Hills Farm) · جزر شانتينيه",
              weight: "2 كجم",
              price: 12,
              imageUrl: "",
              initialQuantity: 1,
              onQuantityChanged: (newQty) {},
              onDelete: () {},
            ).premiumAppear(index: index % 5);
          },
        ),
      ),
    );
  }
}
