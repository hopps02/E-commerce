import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/app/ui_kit/default_app_bar.dart';
import 'package:for_u/app/ui_kit/forms/simple_form.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/shared/support/view/widgets/labeled_field.dart';
import 'package:for_u/presentation/views/user/support/riverpod/create_ticket_controller.dart';
import 'package:for_u/presentation/views/user/support/riverpod/tickets_controller.dart';
import 'package:for_u/presentation/views/user/support/view/widgets/linked_order_picker.dart';

class CreateTicketView extends ConsumerStatefulWidget {
  const CreateTicketView({super.key});

  @override
  ConsumerState<CreateTicketView> createState() => _CreateTicketViewState();
}

class _CreateTicketViewState extends ConsumerState<CreateTicketView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _descriptionFocus = FocusNode();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _descriptionFocus.dispose();
    super.dispose();
  }

  Future<void> _pickOrder() async {
    final picked = await LinkedOrderPicker.show(context);
    if (picked == null || !mounted) return;
    ref
        .read(createTicketController.notifier)
        .selectOrder(picked.id, picked.number);
  }

  Future<void> _submit() async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    if (title.isEmpty || description.isEmpty) {
      DI().snackBarHelper.showMessage(
        Translation.fill_required_fields.tr,
        ErrorMessage.snackBar,
      );
      return;
    }

    final ticket = await ref
        .read(createTicketController.notifier)
        .submit(title: title, description: description);
    if (ticket == null || !mounted) return;

    // It appears in the list immediately (the list is mounted underneath).
    ref.read(ticketsController.notifier).prepend(ticket);
    DI().snackBarHelper.showMessage(
      Translation.ticket_submitted.tr,
      ErrorMessage.snackBar,
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createTicketController);

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
            title: Translation.new_ticket.tr,
          ),
          Container(height: 6.h, color: ColorM.gray150),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w) +
                  EdgeInsets.only(top: 20.h, bottom: 24.h),
              children: [
                LabeledField(
                  label: Translation.ticket_subject.tr,
                  child: SimpleForm(
                    controller: _titleController,
                    hintText: Translation.ticket_subject_hint.tr,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    height: 52.h,
                    borderRadius: 17.r,
                    backgroundColor: ColorM.gray100,
                    borderColor: ColorM.gray100,
                    textAlign: TextAlign.start,
                    onFieldSubmitted: (_) => _descriptionFocus.requestFocus(),
                  ),
                ),
                18.verticalSpace,
                LabeledField(
                  label: Translation.ticket_message.tr,
                  child: SimpleForm(
                    controller: _descriptionController,
                    focusNode: _descriptionFocus,
                    hintText: Translation.ticket_message_hint.tr,
                    keyboardType: TextInputType.multiline,
                    height: 140.h,
                    maxLines: 6,
                    borderRadius: 15.r,
                    backgroundColor: ColorM.gray100,
                    borderColor: ColorM.gray100,
                    alignment: AlignmentDirectional.topStart,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    textAlign: TextAlign.start,
                  ),
                ),
                18.verticalSpace,
                LabeledField(
                  label: Translation.link_order_optional.tr,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(17.r),
                    onTap: _pickOrder,
                    child: Container(
                      height: 52.h,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: ColorM.gray100,
                        borderRadius: BorderRadius.circular(17.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 20.w,
                            color: ColorM.gray500,
                          ),
                          10.horizontalSpace,
                          Expanded(
                            child: Text(
                              state.hasLinkedOrder
                                  ? state.linkedOrderNumber
                                  : Translation.no_linked_order.tr,
                              style: context.bodyLarge.copyWith(
                                color: state.hasLinkedOrder
                                    ? ColorM.gray900
                                    : ColorM.gray500,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: ColorM.gray500,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              SizeM.pagePadding.w,
              8.h,
              SizeM.pagePadding.w,
              12.h + context.bottomSafeAreaPadding,
            ),
            child: CustomInkButton(
              onTap: _submit,
              isLoading: state.submitting,
              width: double.infinity,
              height: 56.h,
              backgroundColor: ColorM.primary,
              borderRadius: 16.r,
              alignment: Alignment.center,
              child: Text(
                Translation.send.tr,
                style: context.bodyLarge.copyWith(
                  color: ColorM.white,
                  fontWeight: FontWeightM.medium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
