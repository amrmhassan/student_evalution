// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_evaluation/core/navigation.dart';
import 'package:student_evaluation/core/types.dart';
import 'package:student_evaluation/fast_tools/widgets/custom_text_field.dart';
import 'package:student_evaluation/models/absent_request_model.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/transformers/collections.dart';
import 'package:student_evaluation/utils/global_utils.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../../fast_tools/widgets/double_modal_button.dart';
import '../../../fast_tools/widgets/v_space.dart';
import '../../../theming/theme_calls.dart';

class AbsentModal extends StatefulWidget {
  const AbsentModal({
    super.key,
  });

  @override
  State<AbsentModal> createState() => _AbsentModalState();
}

class _AbsentModalState extends State<AbsentModal> {
  DateTime selectedDate = DateTime.now();
  TextEditingController reason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DoubleButtonsModal(
      onOk: () async {
        String reasonText = reason.text;
        if (reasonText.isEmpty) return;
        String userId = Providers.userPf(context).userModel!.uid;
        AbsentRequestModel requestModel = AbsentRequestModel(
          absentDate: selectedDate,
          reason: reasonText,
          userId: userId,
        );
        await FirebaseFirestore.instance
            .collection(DBCollections.absentRequest)
            .doc()
            .set(requestModel.toJson());
        GlobalUtils.showSnackBar(
          context: context,
          message: 'Request Sent',
          snackBarType: SnackBarType.success,
        );
        CNav.pop(context);
      },
      title: 'Absent Request',
      okColor: colorTheme.kBlueColor,
      cancelColor: colorTheme.kDangerColor,
      okText: 'Send',
      autoPop: false,
      onCancel: () {
        CNav.pop(context);
      },
      extra: Column(
        children: [
          VSpace(),
          CustomTextField(
            controller: reason,
            title: 'Reason',
            padding: EdgeInsets.zero,
            autoFocus: true,
          ),
          VSpace(factor: .3),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Date',
                  style: h3TextStyle,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  var date = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 33)));
                  if (date == null) return;
                  setState(() {
                    selectedDate = date;
                  });
                },
                child: Text(DateFormat('yyyy/MM/dd').format(selectedDate)),
              ),
            ],
          ),
          VSpace(),
        ],
      ),
    );
  }
}
