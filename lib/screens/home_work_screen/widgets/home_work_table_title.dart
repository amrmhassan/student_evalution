// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/screens/attendance_screen/widgets/round_checkbox.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

class HomeWorkTableTitle extends StatelessWidget {
  const HomeWorkTableTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var homeWProvider = Providers.homeWP(context);

    return Row(
      children: [
        Text(
          'Name',
          style: h2liteTextStyle,
        ),
        Spacer(),
        Text('Select All'),
        HSpace(factor: .5),
        RoundCheckBox(
          checked: homeWProvider.gradeUsers.length ==
              homeWProvider.assignedUsersIDs.length,
          onChange: () {
            var hWPF = Providers.homeWPf(context);
            bool selectAll =
                hWPF.gradeUsers.length != hWPF.assignedUsersIDs.length;
            if (selectAll) {
              for (var student in hWPF.gradeUsers) {
                bool checked = hWPF.assignedUsersIDs.contains(student.uid);
                if (!checked) {
                  hWPF.toggleAssign(student.uid);
                }
              }
            } else {
              for (var student in hWPF.gradeUsers) {
                bool checked = hWPF.assignedUsersIDs.contains(student.uid);
                if (checked) {
                  hWPF.toggleAssign(student.uid);
                }
              }
            }
          },
        ),
      ],
    );
  }
}
