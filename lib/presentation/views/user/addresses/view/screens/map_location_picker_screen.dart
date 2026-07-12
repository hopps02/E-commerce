import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/shapes/gradient_border_side.dart'
    show GradientBorderSide;
import 'package:store/app/utils/money.dart';
import 'package:store/data/response/customer/place_response.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/addresses/model/map_location_picker_models.dart';
import 'package:store/presentation/views/user/addresses/riverpod/map_location_picker_controller.dart';
import 'package:smooth_corner/smooth_corner.dart';

class MapLocationPickerScreen extends ConsumerStatefulWidget {
  final MapLocationPickerArgs args;

  const MapLocationPickerScreen({super.key, required this.args});

  @override
  ConsumerState<MapLocationPickerScreen> createState() =>
      _MapLocationPickerScreenState();
}

class _MapLocationPickerScreenState
    extends ConsumerState<MapLocationPickerScreen> {
  GoogleMapController? _mapController;
  LatLng? _lastCameraCenter;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(mapLocationPickerController.notifier).load(widget.args),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _moveCamera(MapLocationPickerState state) async {
    final controller = _mapController;
    if (controller == null) return;
    await controller.animateCamera(
      CameraUpdate.newLatLngZoom(state.cameraTarget, state.zoom),
    );
  }

  void _confirm() {
    final pickedLocation = ref
        .read(mapLocationPickerController.notifier)
        .confirmResult();
    if (pickedLocation == null) return;
    context.pop(pickedLocation);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<MapLocationPickerState>(mapLocationPickerController, (
      previous,
      next,
    ) {
      if (previous?.cameraTarget != next.cameraTarget ||
          previous?.zoom != next.zoom) {
        _moveCamera(next);
      }
    });

    final state = ref.watch(mapLocationPickerController);

    return Scaffold(
      backgroundColor: ColorM.gray150,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: state.cameraTarget,
              zoom: state.zoom,
            ),
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
            zoomControlsEnabled: false,
            compassEnabled: false,
            polygons: _polygons(state),
            onMapCreated: (controller) {
              _mapController = controller;
              _moveCamera(state);
            },
            onCameraMove: (position) => _lastCameraCenter = position.target,
            onCameraIdle: () => ref
                .read(mapLocationPickerController.notifier)
                .onCameraIdle(_lastCameraCenter ?? state.cameraTarget),
          ),
          const _CenterPin(),
          PositionedDirectional(
            top: context.topSafeAreaPadding + 12.h,
            start: SizeM.pagePadding.w,
            end: SizeM.pagePadding.w,
            child: _TopControls(
              permissionDenied: state.permissionDenied,
              permissionDeniedForever: state.permissionDeniedForever,
              searching: state.searching,
              suggestions: state.suggestions,
              onSettings: () => ref
                  .read(mapLocationPickerController.notifier)
                  .openAppSettings(),
            ),
          ),
          PositionedDirectional(
            end: SizeM.pagePadding.w,
            bottom: context.bottomSafeAreaPadding + 148.h,
            child: _CurrentLocationButton(
              locating: state.locating,
              onTap: () => ref
                  .read(mapLocationPickerController.notifier)
                  .recenterToGps(),
            ),
          ),
          PositionedDirectional(
            start: SizeM.pagePadding.w,
            end: SizeM.pagePadding.w,
            bottom: context.bottomSafeAreaPadding + 12.h,
            child: _CoverageBar(
              state: state,
              onRetryZones: () => ref
                  .read(mapLocationPickerController.notifier)
                  .retryZones(),
              onRetryCoverage: () => ref
                  .read(mapLocationPickerController.notifier)
                  .retryCoverage(),
              onConfirm: _confirm,
            ),
          ),
        ],
      ),
    );
  }

  Set<Polygon> _polygons(MapLocationPickerState state) {
    return state.zones
        .where((zone) => zone.polygon.length >= 3)
        .map(
          (zone) => Polygon(
            polygonId: PolygonId('delivery-zone-${zone.id}'),
            points: zone.polygon,
            fillColor: ColorM.primary.withOpacity(0.14),
            strokeColor: ColorM.primary500,
            strokeWidth: 1,
          ),
        )
        .toSet();
  }
}

class _TopControls extends ConsumerStatefulWidget {
  final bool permissionDenied;
  final bool permissionDeniedForever;
  final bool searching;
  final List<PlaceSuggestion> suggestions;
  final VoidCallback onSettings;

  const _TopControls({
    required this.permissionDenied,
    required this.permissionDeniedForever,
    required this.searching,
    required this.suggestions,
    required this.onSettings,
  });

  @override
  ConsumerState<_TopControls> createState() => _TopControlsState();
}

class _TopControlsState extends ConsumerState<_TopControls> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController()
      ..addListener(_refreshSearchAffordance);
  }

  @override
  void dispose() {
    _searchController.removeListener(_refreshSearchAffordance);
    _searchController.dispose();
    super.dispose();
  }

  void _refreshSearchAffordance() {
    setState(() {});
  }

  void _submitSearch(String query) {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) return;
    FocusScope.of(context).unfocus();
    ref.read(mapLocationPickerController.notifier).onSearchChanged(trimmedQuery);
  }

  void _clearSearch() {
    _searchController.clear();
    ref.read(mapLocationPickerController.notifier).clearSearch();
  }

  void _selectSuggestion(PlaceSuggestion suggestion) {
    _searchController.text = suggestion.primaryText;
    _searchController.selection = TextSelection.collapsed(
      offset: _searchController.text.length,
    );
    FocusScope.of(context).unfocus();
    ref.read(mapLocationPickerController.notifier).selectSuggestion(suggestion);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            CustomInkButton(
              onTap: () => context.pop(),
              width: 42.w,
              height: 42.w,
              borderRadius: 14.r,
              backgroundColor: ColorM.white,
              alignment: Alignment.center,
              side: GradientBorderSide(color: ColorM.gray250, width: 1.w),
              child: RotatedBox(
                quarterTurns: context.isRTL ? 2 : 0,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 18.sp,
                  color: ColorM.gray900,
                ),
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: _MapSearchField(
                controller: _searchController,
                searching: widget.searching,
                onChanged: ref
                    .read(mapLocationPickerController.notifier)
                    .onSearchChanged,
                onSubmitted: _submitSearch,
                onClear: _clearSearch,
              ),
            ),
          ],
        ),
        if (widget.suggestions.isNotEmpty) ...[
          8.verticalSpace,
          Padding(
            padding: EdgeInsetsDirectional.only(start: 52.w),
            child: _PlaceSuggestionsDropdown(
              suggestions: widget.suggestions,
              onSelected: _selectSuggestion,
            ),
          ),
        ],
        if (widget.permissionDenied || widget.permissionDeniedForever) ...[
          10.verticalSpace,
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: ShapeDecoration(
              color: ColorM.white,
              shape: SmoothRectangleBorder(
                smoothness: 1,
                borderRadius: BorderRadius.circular(14.r),
                side: BorderSide(color: ColorM.orange, width: 1.w),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.location_off, color: ColorM.orange, size: 20.sp),
                8.horizontalSpace,
                Expanded(
                  child: Text(
                    Translation.location_permission_settings_hint.tr,
                    style: context.labelMedium.copyWith(color: ColorM.gray800),
                  ),
                ),
                if (widget.permissionDeniedForever) ...[
                  8.horizontalSpace,
                  CustomInkButton(
                    onTap: widget.onSettings,
                    backgroundColor: ColorM.primary50,
                    borderRadius: 10.r,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 7.h,
                    ),
                    child: Text(
                      Translation.open_settings.tr,
                      style: context.labelMedium.copyWith(
                        color: ColorM.primary500,
                        fontWeight: FontWeightM.medium,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _MapSearchField extends StatelessWidget {
  final TextEditingController controller;
  final bool searching;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onClear;

  const _MapSearchField({
    required this.controller,
    required this.searching,
    required this.onChanged,
    required this.onSubmitted,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final hasQuery = controller.text.trim().isNotEmpty;

    return Container(
      height: 42.w,
      padding: EdgeInsetsDirectional.only(start: 12.w, end: 8.w),
      decoration: ShapeDecoration(
        color: ColorM.white,
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(14.r),
          side: BorderSide(color: ColorM.gray250, width: 1.w),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.search, size: 19.sp, color: ColorM.gray600),
          8.horizontalSpace,
          Expanded(
            child: TextField(
              controller: controller,
              cursorColor: ColorM.primary500,
              textInputAction: TextInputAction.search,
              textAlign: TextAlign.start,
              style: context.labelLarge.copyWith(
                color: ColorM.gray950,
                fontWeight: FontWeightM.medium,
              ),
              decoration: InputDecoration.collapsed(
                hintText: Translation.map_search_hint.tr,
                hintStyle: context.labelMedium.copyWith(
                  color: ColorM.gray600,
                ),
              ),
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
            ),
          ),
          8.horizontalSpace,
          _SearchTrailingAction(
            searching: searching,
            hasQuery: hasQuery,
            onClear: onClear,
          ),
        ],
      ),
    );
  }
}

class _SearchTrailingAction extends StatelessWidget {
  final bool searching;
  final bool hasQuery;
  final VoidCallback onClear;

  const _SearchTrailingAction({
    required this.searching,
    required this.hasQuery,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    if (searching) {
      return SizedBox(
        width: 28.w,
        height: 28.w,
        child: Center(
          child: SizedBox(
            width: 16.w,
            height: 16.w,
            child: CircularProgressIndicator(
              strokeWidth: 2.w,
              color: ColorM.primary500,
            ),
          ),
        ),
      );
    }

    if (!hasQuery) return SizedBox(width: 28.w, height: 28.w);

    return CustomInkButton(
      onTap: onClear,
      width: 28.w,
      height: 28.w,
      borderRadius: 10.r,
      backgroundColor: ColorM.gray100,
      alignment: Alignment.center,
      child: Icon(Icons.close, size: 16.sp, color: ColorM.gray600),
    );
  }
}

class _PlaceSuggestionsDropdown extends StatelessWidget {
  final List<PlaceSuggestion> suggestions;
  final ValueChanged<PlaceSuggestion> onSelected;

  const _PlaceSuggestionsDropdown({
    required this.suggestions,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 294.h),
      decoration: ShapeDecoration(
        color: ColorM.white,
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(14.r),
          side: BorderSide(color: ColorM.gray250, width: 1.w),
        ),
        shadows: [
          BoxShadow(
            color: ColorM.gray950.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: suggestions.length,
          separatorBuilder: (context, index) => Padding(
            padding: EdgeInsetsDirectional.only(start: 48.w),
            child: Divider(
              height: 1,
              thickness: 1,
              color: ColorM.gray250,
            ),
          ),
          itemBuilder: (context, index) => _PlaceSuggestionRow(
            suggestion: suggestions[index],
            onTap: () => onSelected(suggestions[index]),
          ),
        ),
      ),
    );
  }
}

class _PlaceSuggestionRow extends StatelessWidget {
  final PlaceSuggestion suggestion;
  final VoidCallback onTap;

  const _PlaceSuggestionRow({
    required this.suggestion,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final secondary = suggestion.secondaryText?.trim().isNotEmpty == true
        ? suggestion.secondaryText!.trim()
        : suggestion.description;

    return CustomInkButton(
      onTap: onTap,
      backgroundColor: ColorM.white,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Icon(
              Icons.location_on_outlined,
              size: 20.sp,
              color: ColorM.gray500,
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  suggestion.primaryText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.labelLarge.copyWith(
                    color: ColorM.gray950,
                    fontWeight: FontWeightM.bold,
                  ),
                ),
                3.verticalSpace,
                Text(
                  secondary,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.labelMedium.copyWith(color: ColorM.gray600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CenterPin extends StatelessWidget {
  const _CenterPin();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: Offset(0, -18.h),
        child: SvgPicture.asset(
          Assets.svg.borderLocation.path,
          width: 42.w,
          height: 42.w,
          colorFilter: const ColorFilter.mode(
            ColorM.primary500,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class _CurrentLocationButton extends StatelessWidget {
  final bool locating;
  final VoidCallback onTap;

  const _CurrentLocationButton({required this.locating, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: Translation.address_use_my_location.tr,
      child: CustomInkButton(
        onTap: locating ? null : onTap,
        width: 48.w,
        height: 48.w,
        borderRadius: 16.r,
        backgroundColor: ColorM.white,
        alignment: Alignment.center,
        side: GradientBorderSide(color: ColorM.gray250, width: 1.w),
        isLoading: locating,
        loadingColor: ColorM.primary500,
        child: Icon(Icons.my_location, color: ColorM.primary500, size: 21.sp),
      ),
    );
  }
}

class _CoverageBar extends StatelessWidget {
  final MapLocationPickerState state;
  final VoidCallback onRetryZones;
  final VoidCallback onRetryCoverage;
  final VoidCallback onConfirm;

  const _CoverageBar({
    required this.state,
    required this.onRetryZones,
    required this.onRetryCoverage,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final barStyle = _CoverageBarStyle.fromState(state.coverageStatus);
    final message = _message(context);

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: ShapeDecoration(
        color: ColorM.white,
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(22.r),
          side: BorderSide(color: ColorM.gray250, width: 1.w),
        ),
        shadows: [
          BoxShadow(
            color: ColorM.gray950.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  color: barStyle.background,
                  shape: SmoothRectangleBorder(
                    smoothness: 1,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Icon(barStyle.icon, size: 18.sp, color: barStyle.color),
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: context.labelLarge.copyWith(
                        color: barStyle.color,
                        fontWeight: FontWeightM.bold,
                      ),
                    ),
                    if (_subtitle(context).isNotEmpty) ...[
                      3.verticalSpace,
                      Text(
                        _subtitle(context),
                        style: context.labelMedium.copyWith(
                          color: ColorM.gray600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (state.hasZoneFetchFailure || _canRetryCoverage) ...[
            10.verticalSpace,
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: CustomInkButton(
                onTap: state.hasZoneFetchFailure
                    ? onRetryZones
                    : onRetryCoverage,
                backgroundColor: ColorM.gray100,
                borderRadius: 10.r,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Text(
                  Translation.retry_button.tr,
                  style: context.labelMedium.copyWith(
                    color: ColorM.gray800,
                    fontWeight: FontWeightM.medium,
                  ),
                ),
              ),
            ),
          ],
          12.verticalSpace,
          CustomInkButton(
            onTap: state.canConfirm ? onConfirm : null,
            enabled: state.canConfirm,
            height: 52.h,
            borderRadius: 16.r,
            backgroundColor: state.canConfirm
                ? ColorM.primary500
                : ColorM.gray300,
            alignment: Alignment.center,
            child: Text(
              Translation.confirm.tr,
              style: context.bodyLarge.copyWith(
                color: ColorM.white,
                fontWeight: FontWeightM.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool get _canRetryCoverage =>
      state.coverageStatus == MapCoverageStatus.networkError &&
      !state.hasZoneFetchFailure;

  String _message(BuildContext context) {
    return switch (state.coverageStatus) {
      MapCoverageStatus.serviceable =>
        Translation.map_inside_delivery_zone.tr,
      MapCoverageStatus.unavailableBranch =>
        Translation.map_zone_no_branch.tr,
      MapCoverageStatus.outside => Translation.map_outside_delivery_zone.tr,
      MapCoverageStatus.networkError =>
        state.coverageErrorMessage.trim().isEmpty
            ? Translation.error_no_internet.tr
            : state.coverageErrorMessage,
      MapCoverageStatus.noZones => Translation.map_no_zones_in_city.tr,
      MapCoverageStatus.checking => Translation.map_checking_coverage.tr,
      MapCoverageStatus.idle => Translation.map_move_pin_hint.tr,
    };
  }

  String _subtitle(BuildContext context) {
    if (state.coverageStatus != MapCoverageStatus.serviceable) {
      if (state.zonesFromCache) return Translation.map_zones_cache_hint.tr;
      return '';
    }

    final fee = state.coverage?.deliveryFeeHalalas;
    if (fee == null) return '';
    final arabic = context.locale.languageCode == 'ar';
    return Translation.delivery_fee_value.trNamed({
      'fee': Money.format(fee, arabic: arabic),
    });
  }
}

class _CoverageBarStyle {
  final Color color;
  final Color background;
  final IconData icon;

  const _CoverageBarStyle({
    required this.color,
    required this.background,
    required this.icon,
  });

  factory _CoverageBarStyle.fromState(MapCoverageStatus status) {
    return switch (status) {
      MapCoverageStatus.serviceable => const _CoverageBarStyle(
        color: ColorM.primary500,
        background: ColorM.primary50,
        icon: Icons.check_circle_outline,
      ),
      MapCoverageStatus.unavailableBranch => const _CoverageBarStyle(
        color: ColorM.orange,
        background: Color(0xFFFFF3E8),
        icon: Icons.storefront_outlined,
      ),
      MapCoverageStatus.outside || MapCoverageStatus.noZones =>
        const _CoverageBarStyle(
          color: ColorM.red,
          background: Color(0xFFFFECEC),
          icon: Icons.location_off_outlined,
        ),
      MapCoverageStatus.networkError => const _CoverageBarStyle(
        color: ColorM.gray700,
        background: ColorM.gray100,
        icon: Icons.wifi_off_outlined,
      ),
      MapCoverageStatus.checking || MapCoverageStatus.idle =>
        const _CoverageBarStyle(
          color: ColorM.gray700,
          background: ColorM.gray100,
          icon: Icons.location_searching,
        ),
    };
  }
}
