// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/theming/constants/styles.dart';

class HomeWorkTableTitle extends StatelessWidget {
  const HomeWorkTableTitle({
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
        Text('Select Student'),
      ],
    );
  }
}
