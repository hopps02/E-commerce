import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/view_extensions.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/views/user/product_details/riverpod/product_details_controller.dart';
import 'package:for_u/presentation/views/user/product_details/view/widgets/product_details_app_bar.dart';
import 'package:for_u/presentation/views/user/product_details/view/widgets/product_details_bottom_bar.dart';
import 'package:for_u/presentation/views/user/product_details/view/widgets/product_image_slider.dart';
import 'package:for_u/presentation/views/user/product_details/view/widgets/product_info_section.dart';
import 'package:for_u/app/extensions/widget_extensions.dart';

class ProductDetailsViewArgs {
  final int productId;

  /// The already-fetched list row, so the screen renders without a spinner.
  final BranchProduct? initial;

  const ProductDetailsViewArgs({required this.productId, this.initial});
}

class ProductDetailsView extends ConsumerStatefulWidget {
  final ProductDetailsViewArgs args;
  const ProductDetailsView({super.key, required this.args});

  @override
  ConsumerState<ProductDetailsView> createState() =>
      _ProductDetailsViewState();
}

class _ProductDetailsViewState extends ConsumerState<ProductDetailsView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(productDetailsController.notifier)
          .load(widget.args.productId, initial: widget.args.initial),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productDetailsController);
    final product = state.product;
    final arabic = context.locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: ColorM.white,
      body: Column(
        children: [
          // Status bar space
          SizedBox(height: context.topSafeAreaPadding),

          // App Bar
          const ProductDetailsAppBar(),

          // Thin divider
          Container(height: 6.h, color: ColorM.gray150),

          // Scrollable body
          Expanded(
            child: FastStateRender(
              reqState: state.reqState,
              errorMessage: state.errorMessage,
              onRetry: () => ref
                  .read(productDetailsController.notifier)
                  .load(widget.args.productId, initial: widget.args.initial),
              child: product == null
                  ? const SizedBox.shrink()
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          16.verticalSpace,

                          // Product image with favorite + dots
                          ProductImageSlider(
                            imageUrls: [product.imageUrl ?? ''],
                          ).premiumAppear(index: 0),

                          14.verticalSpace,

                          // Product name + availability
                          ProductInfoSection(
                            name: product.name(arabic),
                            isAvailable: product.inStock,
                          ).premiumAppear(index: 1),

                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),

      // Fixed bottom bar
      bottomNavigationBar: product == null
          ? null
          : ProductDetailsBottomBar(product: product).containerSlideUp(),
    );
  }
}
