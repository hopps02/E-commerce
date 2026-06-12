import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/app/ui_kit/default_app_bar.dart';
import 'package:for_u/app/ui_kit/forms/simple_form.dart';
import 'package:for_u/app/ui_kit/shapes/gradient_border_side.dart'
    show GradientBorderSide;
import 'package:for_u/data/models/customer/catalog_models.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/addresses/riverpod/address_form_controller.dart';
import 'package:for_u/app/extensions/widget_extensions.dart';
import 'package:smooth_corner/smooth_corner.dart';

class AddressFormArgs {
  final DeliveryAddress? existing;
  const AddressFormArgs({this.existing});
}

class AddressFormView extends ConsumerStatefulWidget {
  final AddressFormArgs args;
  const AddressFormView({super.key, required this.args});

  @override
  ConsumerState<AddressFormView> createState() => _AddressFormViewState();
}

class _AddressFormViewState extends ConsumerState<AddressFormView> {
  final _displayAddress = TextEditingController();
  final _street = TextEditingController();
  final _building = TextEditingController();
  final _floor = TextEditingController();
  final _apartment = TextEditingController();
  final _landmark = TextEditingController();
  final _instructions = TextEditingController();

  DeliveryAddress? get _existing => widget.args.existing;

  @override
  void initState() {
    super.initState();
    final existing = _existing;
    if (existing != null) {
      _displayAddress.text = existing.displayAddress;
      _street.text = existing.street ?? '';
      _building.text = existing.buildingNumber ?? '';
      _floor.text = existing.floor ?? '';
      _apartment.text = existing.apartment ?? '';
      _landmark.text = existing.landmark ?? '';
      _instructions.text = existing.deliveryInstructions ?? '';
    }
    Future.microtask(
      () => ref.read(addressFormController.notifier).initFrom(existing),
    );
  }

  @override
  void dispose() {
    for (final c in [
      _displayAddress,
      _street,
      _building,
      _floor,
      _apartment,
      _landmark,
      _instructions,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (_displayAddress.text.trim().isEmpty) return;

    final saved = await ref
        .read(addressFormController.notifier)
        .save(
          existing: _existing,
          displayAddress: _displayAddress.text.trim(),
          street: _street.text.trim(),
          buildingNumber: _building.text.trim(),
          floor: _floor.text.trim(),
          apartment: _apartment.text.trim(),
          landmark: _landmark.text.trim(),
          deliveryInstructions: _instructions.text.trim(),
        );
    if (saved && mounted) context.pop();
  }

  Widget _fieldLabel(String text) => Text(
    text,
    style: context.bodyMedium.copyWith(fontWeight: FontWeightM.medium),
  );

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(addressFormController);

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
            title: _existing == null
                ? Translation.add_address.tr
                : Translation.edit_address.tr,
          ).premiumAppear(index: 0),
          Container(height: 6.h, color: ColorM.gray150).premiumAppear(index: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location: the existing GPS/geocode flow + coverage check.
                  GestureDetector(
                    onTap: () => ref
                        .read(addressFormController.notifier)
                        .useMyLocation(),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14.w),
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
                              ColorM.primary500,
                              BlendMode.srcIn,
                            ),
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: Text(
                              form.hasLocation
                                  ? form.locationLabel
                                  : Translation.address_use_my_location.tr,
                              style: context.labelLarge.copyWith(
                                color: form.hasLocation
                                    ? ColorM.gray950
                                    : ColorM.gray600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          8.horizontalSpace,
                          CustomInkButton(
                            onTap: () => ref
                                .read(addressFormController.notifier)
                                .useMyLocation(),
                            backgroundColor: ColorM.primary50,
                            borderRadius: 10.r,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 8.h,
                            ),
                            child: Text(
                              Translation.address_use_my_location.tr,
                              style: context.labelMedium.copyWith(
                                color: ColorM.primary500,
                                fontWeight: FontWeightM.medium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  20.verticalSpace,

                  // Label chips (home / work / other)
                  Row(
                    spacing: 10.w,
                    children: [
                      for (final (value, name) in [
                        ('home', Translation.label_home.tr),
                        ('work', Translation.label_work.tr),
                        ('other', Translation.label_other.tr),
                      ])
                        CustomInkButton(
                          onTap: () => ref
                              .read(addressFormController.notifier)
                              .selectLabel(value),
                          borderRadius: 12.r,
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 8.h,
                          ),
                          backgroundColor: form.label == value
                              ? ColorM.primary50
                              : ColorM.transparent,
                          side: GradientBorderSide(
                            color: form.label == value
                                ? ColorM.primary
                                : ColorM.gray200,
                            width: 1.w,
                          ),
                          child: Text(
                            name,
                            style: context.labelMedium.copyWith(
                              color: form.label == value
                                  ? ColorM.primary500
                                  : ColorM.gray700,
                              fontWeight: FontWeightM.medium,
                            ),
                          ),
                        ),
                    ],
                  ),

                  20.verticalSpace,

                  _fieldLabel(Translation.address_details_label.tr),
                  8.verticalSpace,
                  SimpleForm(
                    hintText: Translation.address_details_hint.tr,
                    keyboardType: TextInputType.streetAddress,
                    controller: _displayAddress,
                    maxLines: 2,
                  ),

                  16.verticalSpace,

                  _fieldLabel(Translation.street.tr),
                  8.verticalSpace,
                  SimpleForm(
                    hintText: Translation.street.tr,
                    keyboardType: TextInputType.streetAddress,
                    controller: _street,
                  ),

                  16.verticalSpace,

                  // Building / floor / apartment share one responsive row.
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _fieldLabel(Translation.building_number.tr),
                            8.verticalSpace,
                            SimpleForm(
                              hintText: '12',
                              keyboardType: TextInputType.text,
                              controller: _building,
                            ),
                          ],
                        ),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _fieldLabel(Translation.floor_label.tr),
                            8.verticalSpace,
                            SimpleForm(
                              hintText: '2',
                              keyboardType: TextInputType.text,
                              controller: _floor,
                            ),
                          ],
                        ),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _fieldLabel(Translation.apartment.tr),
                            8.verticalSpace,
                            SimpleForm(
                              hintText: '4',
                              keyboardType: TextInputType.text,
                              controller: _apartment,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  16.verticalSpace,

                  _fieldLabel(Translation.landmark.tr),
                  8.verticalSpace,
                  SimpleForm(
                    hintText: Translation.landmark.tr,
                    keyboardType: TextInputType.text,
                    controller: _landmark,
                  ),

                  16.verticalSpace,

                  _fieldLabel(Translation.delivery_instructions.tr),
                  8.verticalSpace,
                  SimpleForm(
                    hintText: Translation.delivery_instructions.tr,
                    keyboardType: TextInputType.text,
                    controller: _instructions,
                    maxLines: 2,
                  ),

                  32.verticalSpace,

                  CustomInkButton(
                    onTap: _save,
                    borderRadius: 20.r,
                    backgroundColor: ColorM.primary500,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Center(
                      child: Text(
                        Translation.save.tr,
                        style: context.titleMedium.copyWith(
                          color: ColorM.white,
                          fontWeight: FontWeightM.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: context.bottomSafeAreaPadding + 16.h),
                ],
              ).premiumAppear(index: 2),
            ),
          ),
        ],
      ),
    );
  }
}
