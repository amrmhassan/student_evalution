// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/helpers/responsive.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/custom_text_field.dart';
import 'package:student_evaluation/fast_tools/widgets/h_line.dart';
import 'package:student_evaluation/fast_tools/widgets/h_space.dart';
import 'package:student_evaluation/fast_tools/widgets/padding_wrapper.dart';
import 'package:student_evaluation/fast_tools/widgets/v_space.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:intl/intl.dart' as intl;

class TimeLineTitle extends StatelessWidget {
  const TimeLineTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PaddingWrapper(
      padding: EdgeInsets.symmetric(horizontal: kHPad / 2),
      child: Row(
        children: [
          Text(
            'Select Date',
            style: h2LightTextStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          HSpace(factor: .5),
          Image.asset(
            'assets/icons/warning.png',
            color: Colors.white,
            width: mediumIconSize * .5,
          ),
          Spacer(),
          Image.asset(
            'assets/icons/attendance.png',
            color: Colors.white,
            width: mediumIconSize * .8,
          ),
          HSpace(factor: .5),
          Text(
            intl.DateFormat('MMM yyyy').format(DateTime.now()),
            style: h3LightTextStyle,
          ),
        ],
      ),
    );
  }
}
