// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/theming/theme_calls.dart';

import '../../theming/constants/sizes.dart';
import '../../theming/constants/styles.dart';
import 'button_wrapper.dart';

class ApplyModalButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool active;
  final Color? color;

  const ApplyModalButton({
    Key? key,
    required this.onTap,
    required this.title,
    this.active = true,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      backgroundColor: colorTheme.kBlueColor,
      active: active,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: kVPad / 2),
      onTap: onTap,
      child: Text(
        title,
        style: h3LiteTextStyle.copyWith(color: Colors.white),
      ),
    );
  }
}
