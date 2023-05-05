import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/theme_calls.dart';

class RoundCheckBox extends StatelessWidget {
  final bool checked;
  final VoidCallback onChange;

  const RoundCheckBox({
    super.key,
    required this.checked,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      onTap: onChange,
      width: mediumIconSize * .8,
      height: mediumIconSize * .8,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 2,
          color: checked ? colorTheme.kBlueColor : colorTheme.inActiveText,
        ),
        borderRadius: BorderRadius.circular(
          1000,
        ),
      ),
      child: checked
          ? Icon(
              FontAwesomeIcons.check,
              size: smallIconSize * .8,
              color: colorTheme.kBlueColor,
            )
          : null,
    );
  }
}
