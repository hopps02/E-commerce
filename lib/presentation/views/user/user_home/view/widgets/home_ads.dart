import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/custom_cached_image.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/views/user/product_details/view/screens/product_details_view.dart';
import 'package:store/presentation/views/user/products/view/screens/products_view.dart';
import 'package:store/presentation/res/spacing_manager.dart';
import 'package:store/presentation/res/radius_manager.dart';

/// Opens whatever the panel pointed the ad at. The target arrives resolved, so
/// there is nothing to look up here.
void openBannerTarget(BuildContext context, HomeBanner banner, bool arabic) {
  final target = banner.target;
  if (target == null) return;

  final title = banner.title(arabic);

  switch (target.type) {
    case 'category':
      if (target.categoryId == null) return;
      context.pushNamed(
        Routes.products,
        arguments: ProductsViewArgs(
          title: title,
          categoryId: target.categoryId,
        ),
      );
    case 'product':
      if (target.branchItemId == null) return;
      context.pushNamed(
        Routes.productDetails,
        arguments: ProductDetailsViewArgs(productId: target.branchItemId!),
      );
    case 'products':
      if (target.products.isEmpty) return;
      context.pushNamed(
        Routes.products,
        arguments: ProductsViewArgs(title: title, products: target.products),
      );
  }
}

/// The wide promo at the top of the home screen, drawn from whatever the panel
/// wrote: a photo, a chip, a headline, a line under it and a button.
class HomeAdBanner extends StatelessWidget {
  final HomeBanner banner;

  const HomeAdBanner({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    final arabic = context.locale.languageCode == 'ar';
    final badge = banner.badge(arabic);
    final title = banner.title(arabic);
    final subtitle = banner.subtitle(arabic);
    final cta = banner.cta(arabic);
    final image = banner.imageUrl ?? '';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w),
      child: CustomInkButton(
        onTap: banner.opensSomething
            ? () => openBannerTarget(context, banner, arabic)
            : null,
        borderRadius: RadiusM.md.r,
        backgroundColor: ColorM.primary550,
        height: 200,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (image.isNotEmpty)
              CustomCachedImage(imageUrl: image, fit: BoxFit.cover),

            // A scrim from the reading side, so the words hold on any photo.
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentDirectional.centerStart,
                  end: AlignmentDirectional.centerEnd,
                  colors: [
                    ColorM.primary900.withValues(alpha: image.isEmpty ? 0.35 : 0.75),
                    ColorM.primary900.withValues(alpha: 0.05),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsetsDirectional.only(
                start: SpaceM.s4,
                end: SpaceM.s16,
                top: SpaceM.s5,
                bottom: SpaceM.s5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (badge.isNotEmpty) ...[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: SpaceM.s2, vertical: SpaceM.s1.h),
                      decoration: BoxDecoration(
                        color: ColorM.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(RadiusM.xl.r),
                      ),
                      child: Text(
                        badge,
                        style: context.labelMedium.copyWith(
                          color: ColorM.white,
                          fontWeight: FontWeightM.semiBold,
                        ),
                      ),
                    ),
                    SpaceM.s3.verticalSpace,
                  ],
                  if (title.isNotEmpty)
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.titleMedium.copyWith(
                        color: ColorM.white,
                        fontWeight: FontWeightM.bold,
                        height: 1.3,
                      ),
                    ),
                  if (subtitle.isNotEmpty) ...[
                    SpaceM.s2.verticalSpace,
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.bodyMedium.copyWith(
                        color: ColorM.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                  if (cta.isNotEmpty) ...[
                    SpaceM.s4.verticalSpace,
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: SpaceM.s4, vertical: SpaceM.s2.h),
                      decoration: BoxDecoration(
                        color: ColorM.white,
                        borderRadius: BorderRadius.circular(RadiusM.xl.r),
                      ),
                      child: Text(
                        cta,
                        style: context.labelLarge.copyWith(
                          color: ColorM.primary700,
                          fontWeight: FontWeightM.semiBold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The small cards under the search bar — the same ads, in tile form.
class HomeAdTiles extends StatelessWidget {
  final List<HomeBanner> tiles;

  const HomeAdTiles({super.key, required this.tiles});

  @override
  Widget build(BuildContext context) {
    final arabic = context.locale.languageCode == 'ar';

    return SizedBox(
      height: 112,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w),
        itemCount: tiles.length,
        separatorBuilder: (context, index) => SpaceM.s2.horizontalSpace,
        itemBuilder: (context, index) {
          final tile = tiles[index];
          final image = tile.imageUrl ?? '';

          return CustomInkButton(
            onTap: tile.opensSomething
                ? () => openBannerTarget(context, tile, arabic)
                : null,
            width: 109,
            height: 112,
            backgroundColor: ColorM.lightGreen,
            borderRadius: RadiusM.sm.r,
            child: Stack(
              children: [
                if (image.isNotEmpty)
                  PositionedDirectional(
                    bottom: 0,
                    end: 0,
                    child: CustomCachedImage(
                      imageUrl: image,
                      width: 70,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.all(SpaceM.s2.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tile.title(arabic),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.labelMedium.copyWith(
                          fontWeight: FontWeightM.bold,
                          color: ColorM.gray950,
                        ),
                      ),
                      SpaceM.s1.verticalSpace,
                      Text(
                        tile.subtitle(arabic),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.labelSmall.copyWith(
                          color: ColorM.gray600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
