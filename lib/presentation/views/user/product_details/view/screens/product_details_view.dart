import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/view_extensions.dart';
import 'package:for_u/app/utils/state_render.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/views/user/product_details/riverpod/product_details_controller.dart';
import 'package:for_u/presentation/views/user/product_details/view/widgets/product_description.dart';
import 'package:for_u/presentation/views/user/product_details/view/widgets/product_details_app_bar.dart';
import 'package:for_u/presentation/views/user/product_details/view/widgets/product_details_bottom_bar.dart';
import 'package:for_u/presentation/views/user/product_details/view/widgets/product_image_slider.dart';
import 'package:for_u/presentation/views/user/product_details/view/widgets/product_info_section.dart';
import 'package:for_u/presentation/views/user/product_details/view/widgets/product_weight_selector.dart';
import 'package:for_u/app/extensions/widget_extensions.dart';

class ProductDetailsViewArgs {
  final String productId;

  const ProductDetailsViewArgs({required this.productId});
}

class ProductDetailsView extends ConsumerWidget {
  final ProductDetailsViewArgs args;
  const ProductDetailsView({super.key, required this.args});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productDetailsController);

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
              reqState: ReqState.success /*state.reqState*/,
              errorMessage: state.errorMessage,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.verticalSpace,

                    // Product image with favorite + dots
                    ProductImageSlider(
                      imageUrls: ["", "", "", ""],
                    ).premiumAppear(index: 0),

                    14.verticalSpace,

                    // Product name + availability + price
                    ProductInfoSection(
                      name: "أفوكادو",
                      price: 12.0,
                      oldPrice: 14.0,
                      isAvailable: true,
                    ).premiumAppear(index: 1),

                    12.verticalSpace,

                    // Divider
                    Divider(
                      color: ColorM.gray300,
                      height: 1,
                      indent: SizeM.pagePadding.w,
                      endIndent: SizeM.pagePadding.w,
                    ).premiumAppear(index: 2),
                    12.verticalSpace,

                    // Weight selector
                    ProductWeightSelector(
                      weights: ["500 جم", "1 كجم", "2 كجم"],
                    ).premiumAppear(index: 3),

                    12.verticalSpace,
                    // Divider
                    Divider(
                      color: ColorM.gray300,
                      height: 1,
                      indent: SizeM.pagePadding.w,
                      endIndent: SizeM.pagePadding.w,
                    ).premiumAppear(index: 4),
                    12.verticalSpace,

                    // Description
                    ProductDescription(
                      description:
                          "الأفوكادو فاكهة غنية بالعناصر الغذائية وتتميز بقوامها الكريمي واحتوائها على دهون صحية. يعود أصلها إلى أمريكا الوسطى والجنوبية، وقد استُخدمت منذ آلاف السنين. مثالية للسلطات، السندوتشات، أو العصائر.",
                    ).premiumAppear(index: 5),

                    SizedBox(height: SizeM.pagePadding.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // Fixed bottom bar
      bottomNavigationBar: ProductDetailsBottomBar(
        price: 12.0,
        productName: "جزر أصفر (Hills Farm) · جزر شانتينيه",
      ).containerSlideUp(),
    );
  }
}
