import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/ui_kit/forms/simple_form.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/shared/support/riverpod/support_controller.dart';
import 'package:store/presentation/views/shared/support/view/widgets/labeled_field.dart';

class SupportForm extends ConsumerWidget {
  const SupportForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(supportController.notifier);
    return Column(
      children: [
        LabeledField(
          label: Translation.ticket_subject.tr,
          child: SimpleForm(
            controller: notifier.titleController,
            focusNode: notifier.titleFocusNode,
            hintText: Translation.ticket_subject_hint.tr,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            height: 52,
            borderRadius: 17.r,
            backgroundColor: ColorM.gray100,
            borderColor: ColorM.gray100,
            textAlign: TextAlign.start,
            onFieldSubmitted: (_) => notifier.messageFocusNode.requestFocus(),
          ),
        ),
        18.verticalSpace,
        LabeledField(
          label: Translation.ticket_message.tr,
          child: SimpleForm(
            controller: notifier.messageController,
            focusNode: notifier.messageFocusNode,
            hintText: Translation.ticket_message_hint.tr,
            keyboardType: TextInputType.multiline,
            height: 120,
            maxLines: 5,
            borderRadius: 15.r,
            backgroundColor: ColorM.gray100,
            borderColor: ColorM.gray100,
            alignment: AlignmentDirectional.topStart,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12.h),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
