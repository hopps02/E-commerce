import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/extensions/guest_gate.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/default_app_bar.dart';
import 'package:store/app/ui_kit/forms/simple_form.dart';
import 'package:store/app/ui_kit/shapes/gradient_border_side.dart'
    show GradientBorderSide;
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/addresses/riverpod/address_form_controller.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:store/presentation/res/spacing_manager.dart';

class AddressFormArgs {
  final DeliveryAddress? existing;
  const AddressFormArgs({this.existing});
}

enum _AddressField { displayAddress, street, building }

class AddressFormView extends ConsumerStatefulWidget {
  final AddressFormArgs args;
  const AddressFormView({super.key, required this.args});

  @override
  ConsumerState<AddressFormView> createState() => _AddressFormViewState();
}

class _AddressFormViewState extends ConsumerState<AddressFormView> {
  final _scrollController = ScrollController();
  final _displayAddress = TextEditingController();
  final _street = TextEditingController();
  final _building = TextEditingController();
  final _floor = TextEditingController();
  final _apartment = TextEditingController();
  final _landmark = TextEditingController();
  final _instructions = TextEditingController();

  final _fieldKeys = {
    _AddressField.displayAddress: GlobalKey(),
    _AddressField.street: GlobalKey(),
    _AddressField.building: GlobalKey(),
  };

  bool _submitted = false;
  bool _dirty = false;

  DeliveryAddress? get _existing => widget.args.existing;

  @override
  void initState() {
    super.initState();
    _fillExisting();
    for (final controller in _controllers) {
      controller.addListener(_onTextChanged);
    }
    Future.microtask(() {
      final notifier = ref.read(addressFormController.notifier);
      notifier.initFrom(_existing);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    for (final controller in _controllers) {
      controller.removeListener(_onTextChanged);
      controller.dispose();
    }
    super.dispose();
  }

  List<TextEditingController> get _controllers => [
    _displayAddress,
    _street,
    _building,
    _floor,
    _apartment,
    _landmark,
    _instructions,
  ];

  void _fillExisting() {
    final existing = _existing;
    if (existing == null) return;
    _displayAddress.text = existing.displayAddress;
    _street.text = existing.street ?? '';
    _building.text = existing.buildingNumber ?? '';
    _floor.text = existing.floor ?? '';
    _apartment.text = existing.apartment ?? '';
    _landmark.text = existing.landmark ?? '';
    _instructions.text = existing.deliveryInstructions ?? '';
  }

  void _onTextChanged() {
    if (!_dirty) _dirty = true;
    if (mounted) setState(() {});
  }

  Future<void> _save() async {
    if (!await requireLogin(context, ref)) return;
    if (!_validateAndScroll()) return;

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
    if (saved != null && mounted) context.pop(saved);
  }

  bool _validateAndScroll() {
    setState(() => _submitted = true);
    final firstInvalid = _firstInvalidField(ref.read(addressFormController));
    if (firstInvalid == null) return true;

    final fieldContext = _fieldKeys[firstInvalid]?.currentContext;
    if (fieldContext != null) {
      Scrollable.ensureVisible(
        fieldContext,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
        alignment: 0.12,
      );
    }
    return false;
  }

  _AddressField? _firstInvalidField(AddressFormState form) {
    if (_displayAddress.text.trim().isEmpty)
      return _AddressField.displayAddress;
    if (_street.text.trim().isEmpty) return _AddressField.street;
    if (_building.text.trim().isEmpty) return _AddressField.building;
    return null;
  }

  bool _canSave(AddressFormState form) => _firstInvalidField(form) == null;

  bool _hasError(_AddressField field, AddressFormState form) =>
      _submitted && _firstInvalidField(form) == field;

  Future<bool> _confirmDiscard() async {
    if (!_dirty) return true;
    final discard = await showDialog<bool>(
      context: context,
      barrierColor: ColorM.gray950.withOpacity(0.45),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: SpaceM.s8.w),
        child: Container(
          padding: EdgeInsets.fromLTRB(SpaceM.s6, SpaceM.s7, SpaceM.s6, SpaceM.s6.h),
          decoration: ShapeDecoration(
            color: ColorM.white,
            shape: SmoothRectangleBorder(
              smoothness: 1,
              borderRadius: BorderRadius.circular(26.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 58,
                height: 58,
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  color: const Color(0xFFFFF3E8),
                  shape: SmoothRectangleBorder(
                    smoothness: 1,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: ColorM.orange,
                  size: 30,
                ),
              ),
              SpaceM.s5.verticalSpace,
              Text(
                Translation.discard_address_changes_title.tr,
                textAlign: TextAlign.center,
                style: context.titleMedium.copyWith(
                  fontWeight: FontWeightM.bold,
                  color: ColorM.gray950,
                ),
              ),
              SpaceM.s2.verticalSpace,
              Text(
                Translation.discard_address_changes_message.tr,
                textAlign: TextAlign.center,
                style: context.bodyMedium.copyWith(color: ColorM.gray600),
              ),
              SpaceM.s6.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: CustomInkButton(
                      onTap: () => Navigator.pop(context, false),
                      height: 50,
                      borderRadius: 16.r,
                      backgroundColor: ColorM.gray100,
                      alignment: Alignment.center,
                      child: Text(
                        Translation.cancel.tr,
                        style: context.bodyMedium.copyWith(
                          color: ColorM.gray800,
                          fontWeight: FontWeightM.bold,
                        ),
                      ),
                    ),
                  ),
                  SpaceM.s3.horizontalSpace,
                  Expanded(
                    child: CustomInkButton(
                      onTap: () => Navigator.pop(context, true),
                      height: 50,
                      borderRadius: 16.r,
                      backgroundColor: ColorM.red,
                      alignment: Alignment.center,
                      child: Text(
                        Translation.discard_changes.tr,
                        style: context.bodyMedium.copyWith(
                          color: ColorM.white,
                          fontWeight: FontWeightM.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return discard == true;
  }

  Widget _fieldLabel(String text, {bool required = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: context.bodyMedium.copyWith(fontWeight: FontWeightM.medium),
        ),
        if (required) ...[
          SpaceM.s1.horizontalSpace,
          Text(
            '*',
            style: context.bodyMedium.copyWith(
              color: ColorM.red,
              fontWeight: FontWeightM.bold,
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(addressFormController);
    final canSave = _canSave(form);

    return WillPopScope(
      onWillPop: _confirmDiscard,
      child: Scaffold(
        backgroundColor: ColorM.white,
        body: ResponsiveConstrained(
          maxWidth: 550,
          child: Column(
            children: [
              SizedBox(height: context.topSafeAreaPadding),
              DefaultAppBar(
                padding: EdgeInsets.symmetric(
                  vertical: SpaceM.s4,
                  horizontal: SizeM.pagePadding,
                ),
                title: _existing == null
                    ? Translation.add_address.tr
                    : Translation.edit_address.tr,
              ).premiumAppear(index: 0),
              Container(
                height: 6,
                color: ColorM.gray150,
              ).premiumAppear(index: 1),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.all(SpaceM.s4.w),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: SpaceM.s3,
                        children: [
                          for (final (labelValue, name) in [
                            ('home', Translation.label_home.tr),
                            ('work', Translation.label_work.tr),
                            ('other', Translation.label_other.tr),
                          ])
                            CustomInkButton(
                              onTap: () {
                                _dirty = true;
                                ref
                                    .read(addressFormController.notifier)
                                    .selectLabel(labelValue);
                              },
                              borderRadius: 12.r,
                              padding: EdgeInsets.symmetric(
                                horizontal: SpaceM.s4,
                                vertical: SpaceM.s2,
                              ),
                              backgroundColor: form.label == labelValue
                                  ? ColorM.primary50
                                  : ColorM.transparent,
                              side: GradientBorderSide(
                                color: form.label == labelValue
                                    ? ColorM.primary
                                    : ColorM.gray200,
                                width: 1,
                              ),
                              child: Text(
                                name,
                                style: context.labelMedium.copyWith(
                                  color: form.label == labelValue
                                      ? ColorM.primary500
                                      : ColorM.gray700,
                                  fontWeight: FontWeightM.medium,
                                ),
                              ),
                            ),
                        ],
                      ),

                      SpaceM.s5.verticalSpace,

                      _AddressTextField(
                        key: _fieldKeys[_AddressField.displayAddress],
                        label: _fieldLabel(
                          Translation.address_details_label.tr,
                          required: true,
                        ),
                        hintText: Translation.address_details_hint.tr,
                        controller: _displayAddress,
                        keyboardType: TextInputType.streetAddress,
                        maxLines: 2,
                        hasError: _hasError(_AddressField.displayAddress, form),
                        errorText: Translation.required_field.tr,
                      ),

                      SpaceM.s4.verticalSpace,

                      _AddressTextField(
                        key: _fieldKeys[_AddressField.street],
                        label: _fieldLabel(
                          Translation.street.tr,
                          required: true,
                        ),
                        hintText: Translation.street.tr,
                        controller: _street,
                        keyboardType: TextInputType.streetAddress,
                        hasError: _hasError(_AddressField.street, form),
                        errorText: Translation.required_field.tr,
                      ),

                      SpaceM.s4.verticalSpace,

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _AddressTextField(
                              key: _fieldKeys[_AddressField.building],
                              label: _fieldLabel(
                                Translation.building_number.tr,
                                required: true,
                              ),
                              hintText: '12',
                              controller: _building,
                              keyboardType: TextInputType.text,
                              hasError: _hasError(_AddressField.building, form),
                              errorText: Translation.required_field.tr,
                            ),
                          ),
                          SpaceM.s3.horizontalSpace,
                          Expanded(
                            child: _AddressTextField(
                              label: _fieldLabel(Translation.floor_label.tr),
                              hintText: '2',
                              controller: _floor,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          SpaceM.s3.horizontalSpace,
                          Expanded(
                            child: _AddressTextField(
                              label: _fieldLabel(Translation.apartment.tr),
                              hintText: '4',
                              controller: _apartment,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),

                      SpaceM.s4.verticalSpace,

                      _AddressTextField(
                        label: _fieldLabel(Translation.landmark.tr),
                        hintText: Translation.landmark.tr,
                        controller: _landmark,
                        keyboardType: TextInputType.text,
                      ),

                      SpaceM.s4.verticalSpace,

                      _AddressTextField(
                        label: _fieldLabel(
                          Translation.delivery_instructions.tr,
                        ),
                        hintText: Translation.delivery_instructions.tr,
                        controller: _instructions,
                        keyboardType: TextInputType.text,
                        maxLines: 2,
                      ),

                      SpaceM.s8.verticalSpace,

                      CustomInkButton(
                        onTap: _save,
                        borderRadius: 20.r,
                        backgroundColor: canSave
                            ? ColorM.primary500
                            : ColorM.gray300,
                        padding: EdgeInsets.symmetric(vertical: SpaceM.s4.h),
                        child: Center(
                          child: Text(
                            Translation.save.tr,
                            style: context.titleMedium.copyWith(
                              color: ColorM.white,
                              fontWeight: FontWeightM.bold,
                              fontSize: 16,
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
        ),
      ),
    );
  }
}

class _AddressTextField extends StatelessWidget {
  final Widget label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLines;
  final bool hasError;
  final String? errorText;

  const _AddressTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    this.maxLines = 1,
    this.hasError = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label,
        SpaceM.s2.verticalSpace,
        SimpleForm(
          hintText: hintText,
          keyboardType: keyboardType,
          controller: controller,
          maxLines: maxLines,
          borderColor: hasError ? ColorM.red : null,
          enableActiveBorder: true,
        ),
        if (hasError && errorText != null)
          Padding(
            padding: EdgeInsets.only(top: SpaceM.s2.h),
            child: Text(
              errorText!,
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
