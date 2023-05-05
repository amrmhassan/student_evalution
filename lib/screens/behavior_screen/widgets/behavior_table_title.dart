// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/theming/constants/styles.dart';

class BehaviorTableTitle extends StatelessWidget {
  const BehaviorTableTitle({
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
        Text('Active'),
        HSpace(),
        Text('Normal'),
        HSpace(),
        Text('Worry'),
      ],
    );
  }
}
