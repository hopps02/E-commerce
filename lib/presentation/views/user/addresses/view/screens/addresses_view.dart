import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/extensions/guest_gate.dart';
import 'package:store/app/extensions/view_extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/default_app_bar.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/presentation/common/fast_state_render.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/addresses/riverpod/addresses_controller.dart';
import 'package:store/presentation/views/user/addresses/view/screens/address_form_view.dart';
import 'package:store/presentation/views/user/addresses/view/widgets/address_card.dart';
import 'package:store/presentation/views/user/addresses/view/widgets/delete_address_bottom_sheet.dart';
import 'package:store/app/extensions/widget_extensions.dart';

class AddressesView extends ConsumerStatefulWidget {
  const AddressesView({super.key});

  @override
  ConsumerState<AddressesView> createState() => _AddressesViewState();
}

class _AddressesViewState extends ConsumerState<AddressesView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_ensureAccessAndLoad);
  }

  Future<void> _openForm({DeliveryAddress? existing}) async {
    if (!await requireLogin(context, ref)) return;
    await context.pushNamed(
      Routes.addressForm,
      arguments: AddressFormArgs(existing: existing),
    );
    if (mounted) await _ensureAccessAndLoad();
  }

  Future<void> _ensureAccessAndLoad() async {
    if (!await requireLogin(context, ref)) {
      if (mounted) Navigator.of(context).maybePop();
      return;
    }
    ref.read(addressesController.notifier).load();
  }

  Future<void> _delete(DeliveryAddress address) async {
    if (!await requireLogin(context, ref)) return;
    final confirmed = await DeleteAddressBottomSheet.show(context);
    if (confirmed != true || !mounted) return;
    await ref.read(addressesController.notifier).delete(address.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addressesController);

    return Scaffold(
      backgroundColor: ColorM.white,
      body: Column(
        children: [
          SizedBox(height: context.topSafeAreaPadding),
          DefaultAppBar(
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: SizeM.pagePadding.w,
            ),
            title: Translation.addresses.tr,
          ).premiumAppear(index: 0),
          Container(height: 6.h, color: ColorM.gray150).premiumAppear(index: 1),
          Expanded(
            child: FastStateRender(
              reqState: state.reqState,
              errorMessage: state.errorMessage.trim().isEmpty
                  ? Translation.no_addresses_yet.tr
                  : state.errorMessage,
              alignment: const Alignment(0, -0.22),
              onRetry: _ensureAccessAndLoad,
              emptyChild: null,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeM.pagePadding.w,
                  vertical: 16.h,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: state.addresses.length,
                separatorBuilder: (_, _) => 12.verticalSpace,
                itemBuilder: (context, index) {
                  final address = state.addresses[index];
                  return AddressCard(
                    address: address,
                    onEdit: () => _openForm(existing: address),
                    onDelete: () => _delete(address),
                    onSetDefault: () async {
                      if (!await requireLogin(context, ref)) return;
                      await ref
                          .read(addressesController.notifier)
                          .setDefault(address.id);
                    },
                  ).premiumAppear(index: index);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          SizeM.pagePadding.w,
          12.h,
          SizeM.pagePadding.w,
          context.bottomSafeAreaPadding + 12.h,
        ),
        child: CustomInkButton(
          onTap: () => _openForm(),
          height: 56.h,
          width: double.infinity,
          backgroundColor: ColorM.primary,
          borderRadius: 16.r,
          alignment: Alignment.center,
          child: Text(
            Translation.add_address.tr,
            style: context.bodyLarge.copyWith(
              color: ColorM.white,
              fontWeight: FontWeightM.medium,
            ),
          ),
        ),
      ),
    );
  }
}
