// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/theming/constants/styles.dart';

import '../../../fast_tools/widgets/h_space.dart';

class EventInfoItem extends StatelessWidget {
  final String title;
  final String value;
  const EventInfoItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: h2TextStyle,
        ),
        HSpace(),
        Expanded(
          child: Text(
            value,
            style: h3InactiveTextStyle,
            softWrap: true,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
