import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/view_extensions.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/views/user/products/riverpod/products_controller.dart';
import 'package:store/presentation/views/user/products/view/widgets/products_data.dart';
import 'package:store/presentation/views/user/sections/view/widgets/app_bar.dart';
import 'package:store/app/extensions/widget_extensions.dart';

class ProductsViewArgs {
  final String title;
  final int? categoryId;
  final String? search;

  ProductsViewArgs({required this.title, this.categoryId, this.search});
}

class ProductsView extends ConsumerStatefulWidget {
  final ProductsViewArgs args;
  const ProductsView({super.key, required this.args});

  @override
  ConsumerState<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends ConsumerState<ProductsView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(productsController.notifier)
          .init(categoryId: widget.args.categoryId, search: widget.args.search),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveConstrained(
        maxWidth: 450,
        child: Column(
          children: [
            SizedBox(height: context.topSafeAreaPadding),
            TopAppBar(title: widget.args.title).premiumAppear(index: 0),
            Container(height: 6, color: ColorM.gray150).premiumAppear(index: 1),
            const ProductsData(),
          ],
        ),
      ),
    );
  }
}
