// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';

class ChooseGradeSection extends StatelessWidget {
  const ChooseGradeSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kHPad / 2,
        vertical: kVPad / 2,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          mediumBorderRadius,
        ),
        border: Border.all(
          width: .3,
          color: colorTheme.inActiveText.withOpacity(.7),
        ),
      ),
      child: Row(
        children: [
          Text(
            '6th Grade B Section',
            style: h2TextStyle.copyWith(
              color: colorTheme.kBlueColor,
            ),
          ),
          Spacer(),
          Icon(
            FontAwesomeIcons.chevronDown,
            size: smallIconSize,
          )
        ],
      ),
    );
  }
}
