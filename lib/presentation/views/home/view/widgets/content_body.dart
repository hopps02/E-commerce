import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/navigation_extension.dart';
import 'package:jar/app/ui_components/error_widget.dart';
import 'package:jar/app/utils/state_render.dart';
import 'package:jar/presentation/common/fast_state_render.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';
import 'package:jar/presentation/res/routes_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';
import 'package:jar/presentation/views/home/riverpod/tap_home_contaroller.dart';
import 'package:jar/presentation/views/home/view/widgets/categories_section.dart';
import 'package:jar/presentation/views/home/view/widgets/new_arrivals_banner.dart';
import 'package:jar/presentation/views/home/view/widgets/offer_banner.dart';
import 'package:jar/presentation/views/home/view/widgets/products_section.dart';
import 'package:jar/presentation/views/home/view/widgets/top_category.dart';
import 'package:jar/presentation/views/products/view/screens/products_view.dart';

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
        TopCategory(),
        18.verticalSpace,
        const OfferBanner(),
        18.verticalSpace,
        const CategoriesSection(),
        18.verticalSpace,
        ProductsSection(
          title: "الخضار",
          subtitle: "تسوّق فواكه وخضار طازجة، ومنتجات الألبان… بسهولة",
          onViewAllTap: () {
            context.pushNamed(
              RoutesManager.products.route,
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
        ),
        18.verticalSpace,
        // New Arrivals Banner
        NewArrivalsBanner(onShopNowTap: () {}),
        18.verticalSpace,
        // Snacks & Packaged Section
        ProductsSection(
          title: Translation.snacks_and_packaged.tr,
          subtitle: Translation.quick_choices.tr,
          onViewAllTap: () {
            context.pushNamed(
              RoutesManager.products.route,
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
        ),
        18.verticalSpace,
      ],
    );
  }
}
