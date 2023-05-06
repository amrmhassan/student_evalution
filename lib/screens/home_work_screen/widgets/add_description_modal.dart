// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/custom_text_field.dart';
import 'package:student_evaluation/fast_tools/widgets/double_modal_button.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

class AddDescriptionModal extends StatefulWidget {
  const AddDescriptionModal({
    super.key,
  });

  @override
  State<AddDescriptionModal> createState() => _AddDescriptionModalState();
}

class _AddDescriptionModalState extends State<AddDescriptionModal> {
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    descController.text = Providers.homeWPf(context).description ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DoubleButtonsModal(
      autoPop: true,
      okActive: descController.text.isNotEmpty,
      onOk: () {
        Providers.homeWPf(context).setDescription(descController.text);
      },
      okColor: colorTheme.kBlueColor,
      okText: 'Save',
      cancelColor: colorTheme.kDangerColor,
      title: 'Type Description',
      extra: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VSpace(),
          CustomTextField(
            onChange: (v) {
              setState(() {});
            },
            controller: descController,
            title: 'Description',
            padding: EdgeInsets.zero,
            borderColor: Colors.transparent,
            backgroundColor: colorTheme.inActiveText.withOpacity(.1),
            maxLines: 1,
            textInputType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            autoFocus: true,
          ),
          VSpace(),
        ],
      ),
    );
  }
}
