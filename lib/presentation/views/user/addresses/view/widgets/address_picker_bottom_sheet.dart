import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/indicators/state_render.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/presentation/common/fast_state_render.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/app/extensions/guest_gate.dart';
import 'package:store/presentation/views/user/addresses/riverpod/addresses_controller.dart';
import 'package:store/presentation/views/user/addresses/view/screens/address_form_view.dart';
import 'package:smooth_corner/smooth_corner.dart';

/// Saved-address switcher. Picking one returns it to the caller for a fresh
/// quote or active home delivery location.
class AddressPickerBottomSheet extends ConsumerStatefulWidget {
  const AddressPickerBottomSheet({super.key});

  /// Saved addresses belong to a real account, so a guest is asked to sign
  /// in before the list opens rather than meeting a 401 inside it.
  static Future<DeliveryAddress?> show(BuildContext context, WidgetRef ref) async {
    if (!await requireLogin(context, ref)) return null;
    if (!context.mounted) return null;

    return showModalBottomSheet<DeliveryAddress>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) => const AddressPickerBottomSheet(),
    );
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
            width: 48,
            height: 4,
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
                ? _AddressEmptyState(onAddAddress: _addNew)
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
                    height: 50,
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

  const _AddressEmptyState({required this.onAddAddress});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 58,
            height: 58,
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
              width: 26,
              height: 26,
              colorFilter: ColorFilter.mode(
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
            height: 46,
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
              width: 18,
              height: 18,
              colorFilter: ColorFilter.mode(
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
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3.h),
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

