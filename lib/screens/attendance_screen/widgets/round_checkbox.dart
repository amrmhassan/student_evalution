import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_evaluation/fast_tools/widgets/button_wrapper.dart';
import 'package:student_evaluation/theming/constants/sizes.dart';
import 'package:student_evaluation/theming/theme_calls.dart';

class RoundCheckBox extends StatefulWidget {
  final bool checked;
  final VoidCallback onChange;
  final double? radius;

  const RoundCheckBox({
    super.key,
    required this.checked,
    required this.onChange,
    this.radius,
  });

  @override
  State<RoundCheckBox> createState() => _RoundCheckBoxState();
}

class _RoundCheckBoxState extends State<RoundCheckBox> {
  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      onTap: widget.onChange,
      width: widget.radius ?? mediumIconSize * .8,
      height: widget.radius ?? mediumIconSize * .8,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 2,
          color:
              widget.checked ? colorTheme.kBlueColor : colorTheme.inActiveText,
        ),
        borderRadius: BorderRadius.circular(
          1000,
        ),
      ),
      child: widget.checked
          ? Icon(
              FontAwesomeIcons.check,
              size: smallIconSize * .8,
              color: colorTheme.kBlueColor,
            )
          : null,
    );
  }
}
