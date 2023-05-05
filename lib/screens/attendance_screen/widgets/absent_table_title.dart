// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/theming/constants/styles.dart';

class AbsentTableTitle extends StatelessWidget {
  const AbsentTableTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Name',
          style: h2liteTextStyle,
        ),
        Spacer(),
        Text('Present'),
        HSpace(),
        Text('Absent'),
      ],
    );
  }
}
