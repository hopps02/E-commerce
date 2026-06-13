import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/addresses/riverpod/addresses_controller.dart';
import 'package:for_u/presentation/views/user/addresses/view/screens/address_form_view.dart';
import 'package:smooth_corner/smooth_corner.dart';

/// Checkout-time address switcher: the saved addresses in the app's sheet
/// language; picking one returns it to the caller for a fresh quote.
class AddressPickerBottomSheet extends ConsumerStatefulWidget {
  const AddressPickerBottomSheet({super.key});

  static Future<DeliveryAddress?> show(BuildContext context) {
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
    await context.pushNamed(
      Routes.addressForm,
      arguments: const AddressFormArgs(),
    );
    if (mounted) ref.read(addressesController.notifier).load();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addressesController);

    return Container(
      padding:
          EdgeInsets.all(SizeM.pagePadding.dg) +
          EdgeInsets.only(bottom: context.bottomSafeAreaPadding),
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: 0.7.sh),
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
            child: FastStateRender(
              reqState: state.reqState,
              errorMessage: state.errorMessage,
              onRetry: () => ref.read(addressesController.notifier).load(),
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
          16.verticalSpace,
          CustomInkButton(
            onTap: _addNew,
            height: 50.h,
            width: double.infinity,
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
              child: Text(
                address.displayAddress,
                style: context.labelLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
