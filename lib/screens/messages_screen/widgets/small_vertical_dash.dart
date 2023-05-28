import 'package:flutter/material.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/theme_calls.dart';

class SmallVerticalDash extends StatelessWidget {
  const SmallVerticalDash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kVPad,
      color: colorTheme.inActiveText.withOpacity(.5),
      width: 1,
    );
  }
}
