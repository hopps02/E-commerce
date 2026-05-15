import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/utils/after_layout.dart';
import 'package:for_u/presentation/common/riverpod/location_controller.dart';
import 'package:for_u/presentation/views/home/view/widgets/content_body.dart';
import 'package:for_u/presentation/views/home/view/widgets/home_tap_app_bar.dart';
import 'package:for_u/presentation/views/home/view/widgets/location_picker_dialog.dart';

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

  void _showLocationPicker() {
    LocationPickerDialog.show(
      context,
      onDismiss: () async {
        final storage = DI().storageService;
        if (storage.shouldShowLocationDialog) {
          await storage.incrementLocationDismissedCount();
        }
      },
      onEnablePressed: () async {
        return await ref
            .read(locationController.notifier)
            .handleLocationPermissionAndFetch();
      },
    );
  }

  @override
  Future<void> afterLayout(BuildContext context) async {
    final storage = DI().storageService;
    if (!storage.isLocationSelected && storage.shouldShowLocationDialog) {
      _showLocationPicker();
    }
  }
}
