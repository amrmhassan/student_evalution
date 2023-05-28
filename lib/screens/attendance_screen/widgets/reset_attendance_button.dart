// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';

class ResetAttendanceButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const ResetAttendanceButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      onTap: onTap,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          mediumBorderRadius,
        ),
        border: Border.all(
          width: 1,
          color: colorTheme.kBlueColor,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: kHPad,
        vertical: kVPad / 3,
      ),
      child: Text(
        title,
        style: h3LightTextStyle.copyWith(
          color: colorTheme.kBlueColor,
        ),
      ),
    );
  }
}
