import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/navigation_extension.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';
import 'package:jar/presentation/res/routes_manager.dart';
import 'package:jar/presentation/res/sizes_manager.dart';
import 'package:jar/presentation/views/home/view/widgets/category_card.dart';
import 'package:jar/presentation/views/products/view/screens/products_view.dart';

class TopCategory extends StatelessWidget {
  const TopCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CategoryCard(
            title: "البقالة",
            subtitle: "طازج يوميًا",
            imagePath: Assets.tempImages.image1.path,
            onTap: () {
              context.pushNamed(RoutesManager.products.route, arguments: ProductsViewArgs(title: "البقالة"));
            },
          ),
          CategoryCard(
            title: "أفضل العروض",
            subtitle: "وفّر أكثر اليوم",
            imagePath: Assets.tempImages.image2.path,
            onTap: () {
              context.pushNamed(RoutesManager.products.route, arguments: ProductsViewArgs(title: "أفضل العروض"));
            },
          ),
          CategoryCard(
            title: "احتياجاتك اليومية",
            subtitle: "مختار بعناية وطازج",
            imagePath: Assets.tempImages.image3.path,
            onTap: () {
              context.pushNamed(RoutesManager.products.route, arguments: ProductsViewArgs(title: "احتياجاتك اليومية"));
            },
          ),
        ],
      ),
    );
  }
}
