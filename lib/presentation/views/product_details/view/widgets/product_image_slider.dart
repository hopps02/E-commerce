import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jar/app/ui_components/custom_cached_image.dart';
import 'package:jar/app/ui_components/custom_ink_button.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';
import 'package:jar/presentation/views/product_details/riverpod/product_details_controller.dart';

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
      height: 260.h,
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
                width: 200.w,
                height: 200.w,
                fit: BoxFit.contain,
                borderRadius: BorderRadius.circular(16.r),
              );
            },
          ),

          // Favorite Button (strictly on the left to match Figma)
          PositionedDirectional(
            top: 0.h,
            end: 16.w,
            child: CustomInkButton(
              onTap: () {},
              width: 32.w,
              height: 32.w,
              borderRadius: 99999,
              backgroundColor: ColorM.gray100,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                true
                    ? Assets.svg.borderHeart.path
                    : Assets.svg.fillHeart.path,
                width: 14.w,
              ),
            ),
          ),

          // Page Indicator dots
          if (images.length > 1)
            Positioned(
              bottom: 8.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (index) {
                  final isActive = index == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    width: 6.w,
                    height: 6.h,
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
              bottom: 8.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    width: 6.w,
                    height: 6.h,
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
