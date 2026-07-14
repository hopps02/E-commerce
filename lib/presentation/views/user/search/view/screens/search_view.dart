import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/views/user/search/riverpod/search_controller.dart';
import 'package:store/presentation/views/user/search/view/widgets/search_bar_section.dart';
import 'package:store/presentation/views/user/search/view/widgets/search_data.dart';
import 'package:store/app/extensions/widget_extensions.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ResponsiveConstrained(
        maxWidth: 450,
        child: Column(
          children: [
            SizedBox(height: context.topSafeAreaPadding),
            SearchBarSection(
              controller: _controller,
              onChanged: (query) =>
                  ref.read(searchController.notifier).onQueryChanged(query),
            ).premiumAppear(index: 0),
            Container(height: 6, color: ColorM.gray150).premiumAppear(index: 1),
            const SearchData(),
          ],
        ),
      ),
    );
  }
}
