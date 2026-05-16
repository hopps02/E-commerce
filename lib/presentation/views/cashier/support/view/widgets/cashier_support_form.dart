import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/ui_components/custom_form_field/simple_form.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/cashier/support/riverpod/cashier_support_controller.dart';
import 'package:for_u/presentation/views/cashier/support/view/widgets/labeled_field.dart';

class CashierSupportForm extends ConsumerWidget {
  const CashierSupportForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(cashierSupportController.notifier);
    return Column(
      children: [
        LabeledField(
          label: Translation.full_name.tr,
          child: SimpleForm(
            controller: notifier.nameController,
            focusNode: notifier.nameFocusNode,
            hintText: Translation.name_hint.tr,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            height: 52.h,
            borderRadius: 17.r,
            backgroundColor: ColorM.gray100,
            borderColor: ColorM.gray100,
            textAlign: TextAlign.start,
            onFieldSubmitted: (_) =>
                notifier.messageFocusNode.requestFocus(),
          ),
        ),
        18.verticalSpace,
        LabeledField(
          label: Translation.your_message.tr,
          child: SimpleForm(
            controller: notifier.messageController,
            focusNode: notifier.messageFocusNode,
            hintText: Translation.write_your_message_hint.tr,
            keyboardType: TextInputType.multiline,
            height: 120.h,
            maxLines: 5,
            borderRadius: 15.r,
            backgroundColor: ColorM.gray100,
            borderColor: ColorM.gray100,
            alignment: AlignmentDirectional.topStart,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
