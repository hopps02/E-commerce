import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/app/extensions/guest_gate.dart';
import 'package:store/app/ui_kit/custom_cached_image.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/views/user/product_details/riverpod/product_details_controller.dart';
import 'package:store/presentation/views/user/favorites/riverpod/favorites_controller.dart';

class ProductImageSlider extends ConsumerStatefulWidget {
  final List<String> imageUrls;

  const ProductImageSlider({super.key, this.imageUrls = const []});

  @override
  ConsumerState<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends ConsumerState<ProductImageSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.imageUrls;

    return SizedBox(
      height: 260,
      child: Stack(
        children: [
          // Image PageView
          PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return CustomCachedImage(
                imageUrl: images[index],
                width: 200,
                height: 200,
                fit: BoxFit.contain,
                borderRadius: BorderRadius.circular(16.r),
              );
            },
          ),

          PositionedDirectional(
            top: 0,
            end: 16,
            child: Builder(
              builder: (context) {
                final product = ref.watch(
                  productDetailsController.select((s) => s.product),
                );
                final isFav =
                    product != null &&
                    ref.watch(
                      favoritesController.select((s) => s.contains(product.id)),
                    );
                return CustomInkButton(
                  onTap: product == null
                      ? null
                      : () async {
                          if (!await requireLogin(context, ref)) return;
                          await ref
                              .read(favoritesController.notifier)
                              .toggle(product);
                        },
                  width: 32,
                  height: 32,
                  borderRadius: 99999,
                  backgroundColor: ColorM.gray100,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    isFav
                        ? Assets.svg.fillHeart.path
                        : Assets.svg.borderHeart.path,
                    width: 14,
                    colorFilter: ColorFilter.mode(
                      isFav ? Colors.red : ColorM.gray700,
                      BlendMode.srcIn,
                    ),
                  ),
                );
              },
            ),
          ),

          // Page Indicator dots
          if (images.length > 1)
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (index) {
                  final isActive = index == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isActive ? ColorM.gray600 : ColorM.gray300,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  );
                }),
              ),
            )
          else
            // Static 3-dot indicator for single image (matching Figma)
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: index == 1 ? ColorM.gray600 : ColorM.gray300,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}
