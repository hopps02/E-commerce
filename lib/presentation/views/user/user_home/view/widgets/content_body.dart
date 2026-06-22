import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/app/utils/money.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/common/riverpod/location_controller.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/cart/riverpod/cart_controller.dart';
import 'package:for_u/presentation/views/user/favorites/riverpod/favorites_controller.dart';
import 'package:for_u/presentation/views/user/product_details/view/screens/product_details_view.dart';
import 'package:for_u/presentation/views/user/user_home/riverpod/home_catalog_controller.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/categories_section.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/new_arrivals_banner.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/offer_banner.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/products_section.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/top_category.dart';
import 'package:for_u/presentation/views/user/products/view/screens/products_view.dart';

class ContentBody extends ConsumerStatefulWidget {
  final double bottomSafeAreaPadding;
  final Future<void> Function() onChooseAddress;

  const ContentBody({
    super.key,
    required this.bottomSafeAreaPadding,
    required this.onChooseAddress,
  });

  @override
  ConsumerState<ContentBody> createState() => _ContentBodyState();
}

class _ContentBodyState extends ConsumerState<ContentBody> {
  int? _loadedBranchId;

  @override
  Widget build(BuildContext context) {
    final location = ref.watch(locationController);
    final catalog = ref.watch(homeCatalogController);
    final branchId = location.servingBranchId;

    if (!location.canBrowseCatalog || branchId == null) {
      _loadedBranchId = null;
      return _LocationGateBody(
        location: location,
        bottomSafeAreaPadding: widget.bottomSafeAreaPadding,
        onChooseAddress: widget.onChooseAddress,
        onRetryCoverage: () =>
            ref.read(locationController.notifier).resolveSelectedAddressBranch(),
      );
    }

    final shouldLoad = _loadedBranchId != branchId;
    if (shouldLoad) {
      _scheduleCatalogLoad(branchId);
    }

    return FastStateRender(
      reqState: shouldLoad ? ReqState.loading : catalog.reqState,
      alignment: const Alignment(0, -0.2),
      errorMessage: catalog.errorMessage,
      onRetry: () => ref.read(homeCatalogController.notifier).load(branchId),
      child: Body(
        bottomSafeAreaPadding: widget.bottomSafeAreaPadding,
        catalog: catalog,
      ),
    );
  }

  void _scheduleCatalogLoad(int branchId) {
    _loadedBranchId = branchId;
    Future.microtask(() {
      if (!mounted) return;
      ref.read(homeCatalogController.notifier).load(branchId);
    });
  }
}

class _LocationGateBody extends StatelessWidget {
  final LocationState location;
  final double bottomSafeAreaPadding;
  final Future<void> Function() onChooseAddress;
  final Future<void> Function() onRetryCoverage;

  const _LocationGateBody({
    required this.location,
    required this.bottomSafeAreaPadding,
    required this.onChooseAddress,
    required this.onRetryCoverage,
  });

  @override
  Widget build(BuildContext context) {
    if (location.servingBranchStatus == ServingBranchStatus.resolving) {
      return const FastStateRender(
        reqState: ReqState.loading,
        alignment: Alignment(0, -0.2),
        child: SizedBox.shrink(),
      );
    }

    if (location.servingBranchErrorMessage.isNotEmpty) {
      return FastStateRender(
        reqState: ReqState.error,
        alignment: const Alignment(0, -0.2),
        errorMessage: location.servingBranchErrorMessage,
        onRetry: () {
          onRetryCoverage();
        },
        child: const SizedBox.shrink(),
      );
    }

    return switch (location.servingBranchStatus) {
      ServingBranchStatus.noStoreInZone => _HomeLocationState(
        bottomSafeAreaPadding: bottomSafeAreaPadding,
        badge: Translation.service_unavailable_in_area.tr,
        icon: Icons.storefront_outlined,
        accentColor: ColorM.orange,
        accentBackground: const Color(0xFFFFF3E8),
        title: Translation.home_no_store_title.tr,
        description: Translation.home_no_store_desc.tr,
        actionLabel: Translation.change_delivery_address.tr,
        onAction: onChooseAddress,
      ),
      ServingBranchStatus.outsideZone => _HomeLocationState(
        bottomSafeAreaPadding: bottomSafeAreaPadding,
        badge: Translation.out_of_delivery_range.tr,
        icon: Icons.location_off_outlined,
        accentColor: ColorM.red,
        accentBackground: const Color(0xFFFFECEC),
        title: Translation.out_of_delivery_range.tr,
        description: Translation.out_of_delivery_range_desc.tr,
        actionLabel: Translation.change_delivery_address.tr,
        onAction: onChooseAddress,
      ),
      _ => _HomeLocationState(
        bottomSafeAreaPadding: bottomSafeAreaPadding,
        badge: Translation.deliver_to.tr,
        icon: Icons.location_on_outlined,
        accentColor: ColorM.primary500,
        accentBackground: ColorM.primary50,
        title: Translation.home_choose_location_title.tr,
        description: Translation.home_choose_location_desc.tr,
        actionLabel: Translation.home_choose_location_cta.tr,
        onAction: onChooseAddress,
      ),
    };
  }
}

class _HomeLocationState extends StatelessWidget {
  final double bottomSafeAreaPadding;
  final String badge;
  final IconData icon;
  final Color accentColor;
  final Color accentBackground;
  final String title;
  final String description;
  final String actionLabel;
  final Future<void> Function() onAction;

  const _HomeLocationState({
    required this.bottomSafeAreaPadding,
    required this.badge,
    required this.icon,
    required this.accentColor,
    required this.accentBackground,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding:
          EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w) +
          EdgeInsets.only(top: 24.h, bottom: bottomSafeAreaPadding + 24.h),
      children: [
        Align(
          alignment: Alignment.center,
          child: _LocationStateBadge(
            label: badge,
            icon: icon,
            color: accentColor,
            background: accentBackground,
          ),
        ),
        26.verticalSpace,
        SvgPicture.asset(
          Assets.svg.locationMap.path,
          width: 280.w,
          height: 196.h,
          fit: BoxFit.fitWidth,
        ),
        22.verticalSpace,
        Text(
          title,
          textAlign: TextAlign.center,
          style: context.headlineSmall.copyWith(
            color: ColorM.gray950,
            fontWeight: FontWeightM.bold,
            letterSpacing: 0,
          ),
        ),
        12.verticalSpace,
        Text(
          description,
          textAlign: TextAlign.center,
          style: context.bodyMedium.copyWith(
            color: ColorM.gray600,
            height: 1.5,
          ),
        ),
        24.verticalSpace,
        CustomInkButton(
          onTap: () {
            onAction();
          },
          height: 50.h,
          width: double.infinity,
          borderRadius: SizeM.commonBorderRadius.r,
          backgroundColor: ColorM.primary500,
          alignment: Alignment.center,
          tap: const ButtonAnimationSettings(
            ButtonAnimation.scaleTap,
            intensity: 0.2,
          ),
          child: Text(
            actionLabel,
            style: context.bodyLarge.copyWith(
              color: ColorM.white,
              fontWeight: FontWeightM.medium,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _LocationStateBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color background;

  const _LocationStateBadge({
    required this.label,
    required this.icon,
    required this.color,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18.sp),
          8.horizontalSpace,
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: context.labelMedium.copyWith(
                color: color,
                fontWeight: FontWeightM.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Body extends ConsumerWidget {
  const Body({
    super.key,
    required this.bottomSafeAreaPadding,
    required this.catalog,
  });

  final double bottomSafeAreaPadding;
  final HomeCatalogState catalog;

  void _openProducts(BuildContext context, ProductCategory category, bool arabic) {
    context.pushNamed(
      Routes.products,
      arguments: ProductsViewArgs(
        title: category.name(arabic),
        categoryId: category.id,
      ),
    );
  }

  void _openDetails(BuildContext context, BranchProduct product) {
    context.pushNamed(
      Routes.productDetails,
      arguments: ProductDetailsViewArgs(
        productId: product.id,
        initial: product,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arabic = context.locale.languageCode == 'ar';
    final cart = ref.watch(cartController);
    final cartNotifier = ref.read(cartController.notifier);
    final favorites = ref.watch(favoritesController);
    final favoritesNotifier = ref.read(favoritesController.notifier);

    // Seed favorite hearts from the loaded home sections.
    ref.listen(homeCatalogController.select((s) => s.sections), (_, sections) {
      favoritesNotifier.seedFrom([for (final s in sections) ...s.products]);
    });

    return ListView(
      padding: EdgeInsets.only(bottom: bottomSafeAreaPadding),
      children: [
        10.verticalSpace,
        TopCategory().premiumAppear(index: 0, wantKeepAlive: true),
        18.verticalSpace,
        const OfferBanner().premiumAppear(index: 1, wantKeepAlive: true),
        18.verticalSpace,
        CategoriesSection(
          categories: catalog.categories,
        ).premiumAppear(index: 2, wantKeepAlive: true),
        for (final (sectionIndex, section) in catalog.sections.indexed) ...[
          18.verticalSpace,
          if (sectionIndex == 1)
            // The promo banner sits between the two product rows, as designed.
            NewArrivalsBanner(
              onShopNowTap: () =>
                  _openProducts(context, section.category, arabic),
            ).premiumAppear(index: 3 + sectionIndex, wantKeepAlive: true),
          if (sectionIndex == 1) 18.verticalSpace,
          ProductsSection(
            title: section.category.name(arabic),
            subtitle: Translation.quick_choices.tr,
            onViewAllTap: () =>
                _openProducts(context, section.category, arabic),
            onProductTap: (index) =>
                _openDetails(context, section.products[index]),
            onLimitReached: () => cartNotifier.notifyStockLimit(),
            onQuantityChanged: (index, quantity) =>
                cartNotifier.setQuantity(section.products[index], quantity),
            onFavTap: (index) =>
                favoritesNotifier.toggle(section.products[index]),
            products: [
              for (final product in section.products)
                {
                  'id': product.id,
                  'name': product.name(arabic),
                  'image': product.imageUrl ?? '',
                  'price': Money.asRiyals(product.effectivePriceHalalas),
                  'oldPrice': product.hasDiscount
                      ? Money.asRiyals(product.priceHalalas)
                      : null,
                  'quantity': cart.quantityOf(product.id),
                  'available': product.available,
                  'isFavorite': favorites.contains(product.id),
                },
            ],
          ).premiumAppear(index: 4 + sectionIndex, wantKeepAlive: true),
        ],
        18.verticalSpace,
      ],
    );
  }
}
