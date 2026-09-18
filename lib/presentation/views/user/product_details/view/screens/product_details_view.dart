import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/view_extensions.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/presentation/common/fast_state_render.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/views/user/product_details/riverpod/product_details_controller.dart';
import 'package:store/presentation/views/user/product_details/view/widgets/product_details_app_bar.dart';
import 'package:store/presentation/views/user/product_details/view/widgets/product_description.dart';
import 'package:store/presentation/views/user/product_details/view/widgets/product_details_bottom_bar.dart';
import 'package:store/presentation/views/user/product_details/view/widgets/product_image_slider.dart';
import 'package:store/presentation/views/user/product_details/view/widgets/product_info_section.dart';
import 'package:store/presentation/views/user/product_details/view/widgets/product_specs.dart';
import 'package:store/presentation/views/user/product_details/view/widgets/product_variant_picker.dart';

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
  ConsumerState<ProductDetailsView> createState() => _ProductDetailsViewState();
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
      // NOTE: the width cap (ResponsiveConstrained) is applied to the app bar
      // and the scroll content individually — NOT around this whole Column.
      // Wrapping a full-height Column that contains an `Expanded` in the cap's
      // `Align` collapses it to zero height on wide (tablet+) screens, which is
      // what made the image/name disappear while the bottom bar stayed.
      body: Column(
        children: [
          // Status bar space
          SizedBox(height: context.topSafeAreaPadding),

          // App Bar
          const ResponsiveConstrained(
            maxWidth: 450,
            child: ProductDetailsAppBar(),
          ),

          // Thin divider
          Container(height: 6, color: ColorM.gray150),

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
                  : ResponsiveConstrained(
                      maxWidth: 450,
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            16.verticalSpace,

                            // Product image with favorite + dots
                            ProductImageSlider(
                              imageUrls: product.gallery.isEmpty
                                  ? [product.imageUrl ?? '']
                                  : product.gallery,
                            ),

                            14.verticalSpace,

                            // Product name + availability
                            ProductInfoSection(
                              name: product.name(arabic),
                              isAvailable: product.inStock,
                              brand: product.brand ?? '',
                            ),

                            if (product.hasVariants) ...[
                              20.verticalSpace,
                              ProductVariantPicker(
                                variants: product.variants,
                                selectedId: product.id,
                                onPick: (id) => ref
                                    .read(productDetailsController.notifier)
                                    .chooseVariant(id),
                              ),
                            ],

                            if (product.attributes.isNotEmpty) ...[
                              20.verticalSpace,
                              ProductSpecs(attributes: product.attributes),
                            ],

                            if (product.description(arabic).isNotEmpty) ...[
                              20.verticalSpace,
                              ProductDescription(
                                description: product.description(arabic),
                              ),
                            ],

                            SizedBox(height: 24.h),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),

      // Fixed bottom bar.
      // NOTE: do NOT wrap this in ResponsiveConstrained — its `Align` fills the
      // full height the Scaffold offers the bottom slot, so the bar would
      // balloon to the whole screen and starve the body of height. We cap the
      // width with an Align that uses `heightFactor: 1` so it shrink-wraps to
      // the bar's own height.
      bottomNavigationBar: product == null
          ? null
          : Align(
              alignment: Alignment.bottomCenter,
              heightFactor: 1,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: ProductDetailsBottomBar(product: product),
              ),
            ),
    );
  }
}
