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

class HomeScreenSearchBox extends StatelessWidget {
  final String hint;
  final Function(String value) onSearch;
  const HomeScreenSearchBox({
    super.key,
    required this.hint,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.getWidth(context) - kHPad * 2,
      height: 2 * 1.5 * kVPad,
      decoration: BoxDecoration(
        color: colorTheme.backGround,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(largeBorderRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SizedBox(height: double.infinity),
          HSpace(),
          Icon(
            Icons.search,
            color: colorTheme.kInactiveColor,
            size: mediumIconSize,
          ),
          // HSpace(factor: .3),
          Expanded(
            child: CustomTextField(
              padding: EdgeInsets.zero,
              title: hint,
              hintStyle: h3InactiveTextStyle.copyWith(
                  color: colorTheme.activeText.withOpacity(.3)),
              borderColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
