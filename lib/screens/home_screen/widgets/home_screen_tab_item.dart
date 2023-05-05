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

class HomeScreenTabItem extends StatelessWidget {
  final bool active;
  final String title;
  final VoidCallback onTap;

  const HomeScreenTabItem({
    super.key,
    required this.active,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      onTap: onTap,
      padding: EdgeInsets.symmetric(
        horizontal: kHPad / 5,
        vertical: kVPad / 3,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: active
              ? BorderSide(
                  color: colorTheme.kBlueColor,
                  width: 3,
                )
              : BorderSide.none,
        ),
      ),
      child: Text(
        title,
        style: h2TextStyle.copyWith(
          color: active
              ? colorTheme.kBlueColor
              : colorTheme.activeText.withOpacity(.5),
        ),
      ),
    );
  }
}
