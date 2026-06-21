import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/utils/mixins/after_layout.dart';
import 'package:for_u/presentation/common/riverpod/location_controller.dart';
import 'package:for_u/presentation/views/user/addresses/view/widgets/address_picker_bottom_sheet.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/content_body.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/home_tap_app_bar.dart';

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
      body: ContentBody(bottomSafeAreaPadding: widget.bottomSafeAreaPadding),
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
    final picked = await AddressPickerBottomSheet.show(context);
    if (!mounted) return;
    if (picked != null) {
      await ref.read(locationController.notifier).setSelectedAddress(picked);
      return;
    }

    final storage = DI().storageService;
    if (storage.shouldShowLocationDialog) {
      await storage.incrementLocationDismissedCount();
    }
  }

  @override
  Future<void> afterLayout(BuildContext context) async {
    final storage = DI().storageService;
    if (!storage.isLocationSelected && storage.shouldShowLocationDialog) {
      await _showLocationPicker();
    }
  }
}
