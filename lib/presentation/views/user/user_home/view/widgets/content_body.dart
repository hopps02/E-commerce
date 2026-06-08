import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/navigation_extension.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/user_home/riverpod/tap_home_contaroller.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/categories_section.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/new_arrivals_banner.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/offer_banner.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/products_section.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/top_category.dart';
import 'package:for_u/presentation/views/user/products/view/screens/products_view.dart';
import 'package:for_u/app/extensions/widget_extensions.dart';

class ContentBody extends ConsumerWidget {
  final double bottomSafeAreaPadding;
  const ContentBody({super.key, required this.bottomSafeAreaPadding});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tapHomeState = ref.watch(tapHomeController);

    return FastStateRender(
      reqState: ReqState.success /* tapHomeState.reqState */,
      alignment: Alignment(0, -0.2),
      errorMessage: tapHomeState.errorMessage,
      isOutOfCoverage: true,//tapHomeState.isOutOfCoverage,
      onRetry: () {

      },
      child: Body(bottomSafeAreaPadding: bottomSafeAreaPadding),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key, required this.bottomSafeAreaPadding});

  final double bottomSafeAreaPadding;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: bottomSafeAreaPadding),
      children: [
        10.verticalSpace,
        TopCategory().premiumAppear(index: 0, wantKeepAlive: true),
        18.verticalSpace,
        const OfferBanner().premiumAppear(index: 1, wantKeepAlive: true),
        18.verticalSpace,
        CategoriesSection().premiumAppear(index: 2, wantKeepAlive: true),
        18.verticalSpace,
        ProductsSection(
          title: Translation.vegetables.tr,
          subtitle: Translation.quick_choices.tr,
          onViewAllTap: () {
            context.pushNamed(
              Routes.products,
              arguments: ProductsViewArgs(title: "الخضار"),
            );
          },
          products: [
            {
              "id": 1,
              "name": "الكرنب الأخضر",
              "image": "",
              "price": 12.0,
              "oldPrice": 18.0,
              "quantity": 1,
            },
            {
              "id": 1,
              "name": "الكرنب الأخضر",
              "image": "",
              "price": 12.0,
              "oldPrice": 18.0,
              "quantity": 1,
            },
            {
              "id": 1,
              "name": "الكرنب الأخضر",
              "image": "",
              "price": 12.0,
              "oldPrice": 18.0,
              "quantity": 1,
            },
          ],
        ).premiumAppear(index: 3, wantKeepAlive: true),
        18.verticalSpace,
        // New Arrivals Banner
        NewArrivalsBanner(onShopNowTap: () {}).premiumAppear(index: 4, wantKeepAlive: true),
        18.verticalSpace,
        // Snacks & Packaged Section
        ProductsSection(
          title: Translation.snacks_and_packaged.tr,
          subtitle: Translation.quick_choices.tr,
          onViewAllTap: () {
            context.pushNamed(
              Routes.products,
              arguments: ProductsViewArgs(
                title: Translation.snacks_and_packaged.tr,
              ),
            );
          },
          products: [
            {
              "id": 2,
              "name": "الكرنب الأخضر",
              "image": "",
              "price": 12.0,
              "oldPrice": 18.0,
              "quantity": 0,
            },
            {
              "id": 3,
              "name": "الكرنب الأخضر",
              "image": "",
              "price": 12.0,
              "oldPrice": 18.0,
              "quantity": 0,
            },
            {
              "id": 4,
              "name": "الكرنب الأخضر",
              "image": "",
              "price": 12.0,
              "oldPrice": 18.0,
              "quantity": 0,
            },
          ],
        ).premiumAppear(index: 5, wantKeepAlive: true),
        18.verticalSpace,
      ],
    );
  }
}
