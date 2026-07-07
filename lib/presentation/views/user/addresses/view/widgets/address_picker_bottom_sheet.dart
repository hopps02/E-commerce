import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/extensions/guest_gate.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/app/ui_kit/forms/simple_form.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/app/utils/money.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/domain/usecase/create_address_usecase.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/common/riverpod/location_controller.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/addresses/model/map_location_picker_models.dart';
import 'package:for_u/presentation/views/user/addresses/riverpod/addresses_controller.dart';
import 'package:for_u/presentation/views/user/addresses/view/screens/address_form_view.dart';
import 'package:smooth_corner/smooth_corner.dart';

/// Saved-address switcher. Picking one returns it to the caller for a fresh
/// quote or active home delivery location.
class AddressPickerBottomSheet extends ConsumerStatefulWidget {
  const AddressPickerBottomSheet({super.key});

  static Future<DeliveryAddress?> show(BuildContext context) async {
    final isGuest = await DI().sessionService.isGuest;
    if (!context.mounted) return null;
    if (isGuest) return _showGuestMapPicker(context);

    return showModalBottomSheet<DeliveryAddress>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) => const AddressPickerBottomSheet(),
    );
  }

  static Future<DeliveryAddress?> _showGuestMapPicker(
    BuildContext context,
  ) async {
    final locationState = ProviderScope.containerOf(
      context,
      listen: false,
    ).read(locationController);
    final selectedAddress = locationState.selectedAddress;
    final pickerArgs = selectedAddress == null
        ? const MapLocationPickerArgs(useCurrentLocation: true)
        : MapLocationPickerArgs.fromAddress(selectedAddress);

    final picked = await context.pushNamed<MapLocationPickerResult>(
      Routes.mapLocationPicker,
      arguments: pickerArgs,
    );
    return picked?.toSessionAddress();
  }

  @override
  ConsumerState<AddressPickerBottomSheet> createState() =>
      _AddressPickerBottomSheetState();
}

class _AddressPickerBottomSheetState
    extends ConsumerState<AddressPickerBottomSheet> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(addressesController.notifier).load());
  }

  Future<void> _addNew() async {
    final created = await context.pushNamed<DeliveryAddress>(
      Routes.addressForm,
      arguments: const AddressFormArgs(),
    );
    if (!mounted) return;
    if (created != null) {
      Navigator.pop(context, created);
      return;
    }
    ref.read(addressesController.notifier).load();
  }

  Future<void> _deliverDifferentLocation() async {
    final picked = await context.pushNamed<MapLocationPickerResult>(
      Routes.mapLocationPicker,
      arguments: const MapLocationPickerArgs(),
    );
    if (picked == null || !mounted) return;

    final created = await _OneOffAddressDetailsSheet.show(context, picked);
    if (created != null && mounted) Navigator.pop(context, created);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addressesController);

    return Container(
      padding:
          EdgeInsets.all(SizeM.pagePadding.dg) +
          EdgeInsets.only(bottom: context.bottomSafeAreaPadding),
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: 0.76.sh),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.r),
            topRight: Radius.circular(32.r),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: ColorM.gray300,
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
          20.verticalSpace,
          Text(
            Translation.deliver_to.tr,
            style: context.bodyLarge.copyWith(fontWeight: FontWeightM.bold),
          ),
          16.verticalSpace,
          Flexible(
            child: state.reqState == ReqState.empty
                ? _AddressEmptyState(
                    onAddAddress: _addNew,
                    onDifferentLocation: _deliverDifferentLocation,
                  )
                : FastStateRender(
                    reqState: state.reqState,
                    errorMessage: state.errorMessage,
                    onRetry: () =>
                        ref.read(addressesController.notifier).load(),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.addresses.length,
                      separatorBuilder: (_, _) => 10.verticalSpace,
                      itemBuilder: (context, index) {
                        final address = state.addresses[index];
                        return _PickerRow(
                          address: address,
                          onTap: () => Navigator.pop(context, address),
                        );
                      },
                    ),
                  ),
          ),
          if (state.reqState != ReqState.empty) ...[
            16.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: CustomInkButton(
                    onTap: _addNew,
                    height: 50.h,
                    backgroundColor: ColorM.primary50,
                    borderRadius: 14.r,
                    alignment: Alignment.center,
                    child: Text(
                      Translation.add_address.tr,
                      style: context.labelLarge.copyWith(
                        color: ColorM.primary500,
                        fontWeight: FontWeightM.medium,
                      ),
                    ),
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: CustomInkButton(
                    onTap: _deliverDifferentLocation,
                    height: 50.h,
                    backgroundColor: ColorM.gray100,
                    borderRadius: 14.r,
                    alignment: Alignment.center,
                    child: Text(
                      Translation.deliver_to_different_location.tr,
                      textAlign: TextAlign.center,
                      style: context.labelLarge.copyWith(
                        color: ColorM.gray800,
                        fontWeight: FontWeightM.medium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _AddressEmptyState extends StatelessWidget {
  final VoidCallback onAddAddress;
  final VoidCallback onDifferentLocation;

  const _AddressEmptyState({
    required this.onAddAddress,
    required this.onDifferentLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 58.w,
            height: 58.w,
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              color: ColorM.primary50,
              shape: SmoothRectangleBorder(
                smoothness: 1,
                borderRadius: BorderRadius.circular(18.r),
              ),
            ),
            child: SvgPicture.asset(
              Assets.svg.borderLocation.path,
              width: 26.w,
              height: 26.w,
              colorFilter: const ColorFilter.mode(
                ColorM.primary500,
                BlendMode.srcIn,
              ),
            ),
          ),
          12.verticalSpace,
          Text(
            Translation.no_addresses_saved.tr,
            style: context.bodyLarge.copyWith(
              color: ColorM.gray950,
              fontWeight: FontWeightM.bold,
            ),
          ),
          8.verticalSpace,
          Text(
            Translation.no_addresses_saved_hint.tr,
            textAlign: TextAlign.center,
            style: context.labelMedium.copyWith(color: ColorM.gray600),
          ),
          16.verticalSpace,
          CustomInkButton(
            onTap: onAddAddress,
            height: 46.h,
            width: double.infinity,
            backgroundColor: ColorM.primary500,
            borderRadius: 14.r,
            alignment: Alignment.center,
            child: Text(
              Translation.add_address.tr,
              style: context.labelLarge.copyWith(
                color: ColorM.white,
                fontWeight: FontWeightM.medium,
              ),
            ),
          ),
          10.verticalSpace,
          CustomInkButton(
            onTap: onDifferentLocation,
            height: 46.h,
            width: double.infinity,
            backgroundColor: ColorM.gray100,
            borderRadius: 14.r,
            alignment: Alignment.center,
            child: Text(
              Translation.deliver_to_different_location.tr,
              style: context.labelLarge.copyWith(
                color: ColorM.gray800,
                fontWeight: FontWeightM.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PickerRow extends StatelessWidget {
  final DeliveryAddress address;
  final VoidCallback onTap;

  const _PickerRow({required this.address, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: ShapeDecoration(
          shape: SmoothRectangleBorder(
            smoothness: 1,
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(color: ColorM.gray250, width: 1.w),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              Assets.svg.borderLocation.path,
              width: 18.w,
              height: 18.w,
              colorFilter: const ColorFilter.mode(
                ColorM.greenSecondary,
                BlendMode.srcIn,
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.displayAddress,
                    style: context.labelLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (address.detailsLine.isNotEmpty) ...[
                    3.verticalSpace,
                    Text(
                      address.detailsLine,
                      style: context.labelMedium.copyWith(
                        color: ColorM.gray600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            if (address.isDefault) ...[
              8.horizontalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: ShapeDecoration(
                  color: ColorM.primary50,
                  shape: SmoothRectangleBorder(
                    smoothness: 1,
                    borderRadius: BorderRadius.circular(99.r),
                  ),
                ),
                child: Text(
                  Translation.address_default_badge.tr,
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
    );
  }
}

class _OneOffAddressDetailsSheet extends ConsumerStatefulWidget {
  final MapLocationPickerResult mapResult;

  const _OneOffAddressDetailsSheet({required this.mapResult});

  static Future<DeliveryAddress?> show(
    BuildContext context,
    MapLocationPickerResult mapResult,
  ) {
    return showModalBottomSheet<DeliveryAddress>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) => _OneOffAddressDetailsSheet(mapResult: mapResult),
    );
  }

  @override
  ConsumerState<_OneOffAddressDetailsSheet> createState() =>
      _OneOffAddressDetailsSheetState();
}

class _OneOffAddressDetailsSheetState
    extends ConsumerState<_OneOffAddressDetailsSheet> {
  late final TextEditingController _displayAddress;
  late final TextEditingController _street;
  late final TextEditingController _building;
  bool _submitted = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final mapResult = widget.mapResult;
    _displayAddress = TextEditingController(
      text: mapResult.displayAddressSuggestion ?? mapResult.area ?? '',
    );
    _street = TextEditingController(text: mapResult.street ?? '');
    _building = TextEditingController(text: mapResult.buildingNumber ?? '');
    _displayAddress.addListener(_refresh);
    _street.addListener(_refresh);
    _building.addListener(_refresh);
  }

  @override
  void dispose() {
    _displayAddress.removeListener(_refresh);
    _street.removeListener(_refresh);
    _building.removeListener(_refresh);
    _displayAddress.dispose();
    _street.dispose();
    _building.dispose();
    super.dispose();
  }

  bool get _canSave =>
      _displayAddress.text.trim().isNotEmpty &&
      _street.text.trim().isNotEmpty &&
      _building.text.trim().isNotEmpty;

  void _refresh() {
    if (mounted) setState(() {});
  }

  Future<void> _save() async {
    setState(() => _submitted = true);
    if (!_canSave || _saving) return;
    if (!await requireLogin(context, ref)) return;

    setState(() => _saving = true);
    final mapResult = widget.mapResult;
    final created = await DI().createAddressUseCase.execute(
      CreateAddressParams(
        cityId: mapResult.cityId,
        displayAddress: _displayAddress.text.trim(),
        lat: mapResult.lat,
        lng: mapResult.lng,
        label: 'other',
        street: _street.text.trim(),
        buildingNumber: _building.text.trim(),
        isDefault: false,
      ),
    );
    if (!mounted) return;
    setState(() => _saving = false);

    created.fold(
      (failure) => DI().snackBarHelper.showMessage(
        failure.displayMessage,
        ErrorMessage.snackBar,
      ),
      (address) => Navigator.pop(context, address),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final arabic = context.locale.languageCode == 'ar';
    final fee = widget.mapResult.deliveryFeeHalalas;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 180),
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        width: double.infinity,
        padding:
            EdgeInsets.all(SizeM.pagePadding.w) +
            EdgeInsets.only(bottom: context.bottomSafeAreaPadding),
        decoration: ShapeDecoration(
          color: ColorM.white,
          shape: SmoothRectangleBorder(
            smoothness: 1,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28.r),
              topRight: Radius.circular(28.r),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 48.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: ColorM.gray300,
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
            ),
            18.verticalSpace,
            Text(
              Translation.complete_delivery_address.tr,
              style: context.bodyLarge.copyWith(fontWeight: FontWeightM.bold),
            ),
            if (fee != null) ...[
              8.verticalSpace,
              Text(
                Translation.delivery_fee_value.trNamed({
                  'fee': Money.format(fee, arabic: arabic),
                }),
                style: context.labelMedium.copyWith(color: ColorM.primary700),
              ),
            ],
            16.verticalSpace,
            _RequiredSheetField(
              label: Translation.address_details_label.tr,
              hint: Translation.address_details_hint.tr,
              controller: _displayAddress,
              submitted: _submitted,
              keyboardType: TextInputType.streetAddress,
            ),
            12.verticalSpace,
            _RequiredSheetField(
              label: Translation.street.tr,
              hint: Translation.street.tr,
              controller: _street,
              submitted: _submitted,
              keyboardType: TextInputType.streetAddress,
            ),
            12.verticalSpace,
            _RequiredSheetField(
              label: Translation.building_number.tr,
              hint: '12',
              controller: _building,
              submitted: _submitted,
              keyboardType: TextInputType.text,
            ),
            18.verticalSpace,
            CustomInkButton(
              onTap: _save,
              height: 52.h,
              borderRadius: 16.r,
              isLoading: _saving,
              backgroundColor: _canSave ? ColorM.primary500 : ColorM.gray300,
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
      ),
    );
  }
}

class _RequiredSheetField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool submitted;
  final TextInputType keyboardType;

  const _RequiredSheetField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.submitted,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = submitted && controller.text.trim().isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: context.bodyMedium.copyWith(
                fontWeight: FontWeightM.medium,
              ),
            ),
            3.horizontalSpace,
            Text(
              '*',
              style: context.bodyMedium.copyWith(
                color: ColorM.red,
                fontWeight: FontWeightM.bold,
              ),
            ),
          ],
        ),
        8.verticalSpace,
        SimpleForm(
          hintText: hint,
          keyboardType: keyboardType,
          controller: controller,
          borderColor: hasError ? ColorM.red : null,
          enableActiveBorder: true,
        ),
        if (hasError)
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Text(
              Translation.required_field.tr,
              style: context.labelSmall.copyWith(
                color: ColorM.red,
                fontWeight: FontWeightM.medium,
              ),
            ),
          ),
      ],
    );
  }
}
