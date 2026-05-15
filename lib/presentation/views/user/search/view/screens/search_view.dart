import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/views/user/search/view/widgets/search_bar_section.dart';
import 'package:for_u/presentation/views/user/search/view/widgets/search_data.dart';
import 'package:for_u/app/extensions/widget_extensions.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _controller = TextEditingController();

  // Dummy product data — replace with real data from bloc/api
  final List<Map<String, dynamic>> _allProducts = [
    {
      "name": "الكرنب الأخضر",
      "image": "",
      "price": 12.0,
      "oldPrice": 18.0,
      "quantity": 0,
    },
    {
      "name": "الكرنب الأخضر",
      "image": "",
      "price": 12.0,
      "oldPrice": 18.0,
      "quantity": 1,
      "isFavorite": true,
    },
    {
      "name": "الكرنب الأخضر",
      "image": "",
      "price": 12.0,
      "oldPrice": 18.0,
      "quantity": 0,
    },
    {
      "name": "الكرنب الأخضر",
      "image": "",
      "price": 12.0,
      "oldPrice": 18.0,
      "quantity": 1,
      "isFavorite": true,
    },
    {
      "name": "الكرنب الأخضر",
      "image": "",
      "price": 12.0,
      "oldPrice": 18.0,
      "quantity": 0,
    },
    {
      "name": "الكرنب الأخضر",
      "image": "",
      "price": 12.0,
      "oldPrice": 18.0,
      "quantity": 0,
    },
    {
      "name": "الكرنب الأخضر",
      "image": "",
      "price": 12.0,
      "oldPrice": 18.0,
      "quantity": 0,
    },
    {
      "name": "الكرنب الأخضر",
      "image": "",
      "price": 12.0,
      "oldPrice": 18.0,
      "quantity": 1,
      "isFavorite": true,
    },
    {
      "name": "الكرنب الأخضر",
      "image": "",
      "price": 12.0,
      "oldPrice": 18.0,
      "quantity": 0,
    },
    {
      "name": "الكرنب الأخضر",
      "image": "",
      "price": 12.0,
      "oldPrice": 18.0,
      "quantity": 0,
    },
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: context.topSafeAreaPadding),
          SearchBarSection(controller: _controller).premiumAppear(index: 0),
          Container(height: 6.h, color: ColorM.gray150).premiumAppear(index: 1),
          SearchData(),
        ],
      ),
    );
  }
}
