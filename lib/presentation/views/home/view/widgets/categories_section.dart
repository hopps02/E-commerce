import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/presentation/res/sizes_manager.dart';
import 'package:jar/presentation/views/home/view/widgets/section_header.dart';
import 'package:jar/presentation/views/home/view/widgets/category_grid_item.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'title': 'الخضار', 'image': ''},
      {'title': 'الفواكة', 'image': ''},
      {'title': 'الألبان', 'image': ''},
      {'title': 'مواد البقالة', 'image': ''},
      {'title': 'سناكس', 'image': ''},
      {'title': 'عصائر', 'image': ''},
      {'title': 'المجمّدات', 'image': ''},
      {'title': 'منظفات', 'image': ''},
    ];

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w),
          child: SectionHeader(
            title: "الأقسام",
            onViewAllTap: () {},
          ),
        ),
        16.verticalSpace,

        Wrap(
          spacing: 15.w,
          runSpacing: 16.h,
          alignment: WrapAlignment.center,
          children: categories.map((cat) {
            return CategoryGridItem(
              title: cat['title']!,
              imageUrl: cat['image']!,
              onTap: () {},
            );
          }).toList(),
        ),
      ],
    );
  }
}
