import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/default_app_bar.dart';
import 'package:store/app/ui_kit/forms/simple_form.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/app/utils/snackbar_helper.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/shared/support/view/widgets/labeled_field.dart';
import 'package:store/presentation/views/user/support/riverpod/create_ticket_controller.dart';
import 'package:store/presentation/views/user/support/riverpod/tickets_controller.dart';
import 'package:store/presentation/views/user/support/view/widgets/linked_order_picker.dart';

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
      body: ResponsiveConstrained(
        maxWidth: 550,
        child: Column(
          children: [
            SizedBox(height: context.topSafeAreaPadding),
            DefaultAppBar(
              padding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: SizeM.pagePadding,
              ),
              title: Translation.new_ticket.tr,
            ),
            Container(height: 6, color: ColorM.gray150),
            Expanded(
              child: ListView(
                padding:
                    EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w) +
                    EdgeInsets.only(top: 20, bottom: 24.h),
                children: [
                  LabeledField(
                    label: Translation.ticket_subject.tr,
                    child: SimpleForm(
                      controller: _titleController,
                      hintText: Translation.ticket_subject_hint.tr,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      height: 52,
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
                      height: 140,
                      maxLines: 6,
                      borderRadius: 15.r,
                      backgroundColor: ColorM.gray100,
                      borderColor: ColorM.gray100,
                      alignment: AlignmentDirectional.topStart,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
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
                        height: 52,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: ColorM.gray100,
                          borderRadius: BorderRadius.circular(17.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.receipt_long_outlined,
                              size: 20,
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
                SizeM.pagePadding,
                8,
                SizeM.pagePadding,
                12.h + context.bottomSafeAreaPadding,
              ),
              child: CustomInkButton(
                onTap: _submit,
                isLoading: state.submitting,
                width: double.infinity,
                height: 56,
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
      ),
    );
  }
}
