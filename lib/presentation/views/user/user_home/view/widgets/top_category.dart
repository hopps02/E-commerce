import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/navigation_extension.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/category_card.dart';
import 'package:for_u/presentation/views/user/products/view/screens/products_view.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

class TopCategory extends StatelessWidget {
  const TopCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CategoryCard(
            title: Translation.grocery.tr,
            subtitle: Translation.fresh_daily.tr,
            imagePath: Assets.tempImages.image1.path,
            onTap: () {
              context.pushNamed(
                Routes.products,
                arguments: ProductsViewArgs(title: Translation.grocery.tr),
              );
            },
          ),
          CategoryCard(
            title: Translation.best_offers.tr,
            subtitle: Translation.save_more_today.tr,
            imagePath: Assets.tempImages.image2.path,
            onTap: () {
              context.pushNamed(
                Routes.products,
                arguments: ProductsViewArgs(title: Translation.best_offers.tr),
              );
            },
          ),
          CategoryCard(
            title: Translation.daily_needs.tr,
            subtitle: Translation.carefully_selected_fresh.tr,
            imagePath: Assets.tempImages.image3.path,
            onTap: () {
              context.pushNamed(
                Routes.products,
                arguments: ProductsViewArgs(title: Translation.daily_needs.tr),
              );
            },
          ),
        ],
      ),
    );
  }
}
