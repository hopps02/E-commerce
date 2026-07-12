import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/presentation/common/switch_branch_bottom_sheet.dart';
import 'package:store/presentation/views/user/cart/riverpod/cart_controller.dart';

Future<void> addToCartGuarded(
  BuildContext context,
  WidgetRef ref,
  BranchProduct product,
  int quantity,
) async {
  final cart = ref.read(cartController);
  final cartBranchId = cart.cartBranchId;
  if (!cart.isEmpty &&
      cartBranchId != null &&
      cartBranchId != product.branchId) {
    final shouldStartNewCart = await SwitchBranchBottomSheet.show(context);
    if (shouldStartNewCart == true) {
      ref.read(cartController.notifier).clearAndAdd(product, quantity);
    }
    return;
  }

  ref.read(cartController.notifier).setQuantity(product, quantity);
}
