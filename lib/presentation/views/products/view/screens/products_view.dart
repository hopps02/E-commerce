

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/view_extensions.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/views/products/view/widgets/products_data.dart';
import 'package:jar/presentation/views/sections/view/widgets/app_bar.dart';

class ProductsViewArgs {
  final String title;
  ProductsViewArgs({required this.title});
}


class ProductsView extends StatefulWidget {
  final ProductsViewArgs args;
  const ProductsView({super.key, required this.args});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: context.topSafeAreaPadding),
          TopAppBar(title: widget.args.title,),
          Container(height: 6.h, color: ColorM.gray150),
          ProductsData()
        ],
      ),
    );
  }
}