import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/utils/mixins/after_layout.dart';
import 'package:store/presentation/common/riverpod/location_controller.dart';
import 'package:store/presentation/views/user/addresses/view/widgets/address_picker_bottom_sheet.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/content_body.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/home_tap_app_bar.dart';

class TapHomeView extends ConsumerStatefulWidget {
  final double bottomSafeAreaPadding;
  const TapHomeView({super.key, required this.bottomSafeAreaPadding});

  @override
  ConsumerState<TapHomeView> createState() => _TapHomeViewState();
}

class _TapHomeViewState extends ConsumerState<TapHomeView>
    with AutomaticKeepAliveClientMixin, AfterLayout {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [HomeTapAppBar()];
      },
      body: ContentBody(
        bottomSafeAreaPadding: widget.bottomSafeAreaPadding,
        onChooseAddress: _showLocationPicker,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _showLocationPicker() async {
    final picked = await AddressPickerBottomSheet.show(context, ref);
    if (!mounted || picked == null) return;
    await ref.read(locationController.notifier).setSelectedAddress(picked);
  }

  /// Nothing is asked on arrival: the store has one catalogue and delivers
  /// anywhere, so an address is only needed at checkout.
  @override
  Future<void> afterLayout(BuildContext context) async {}
}
