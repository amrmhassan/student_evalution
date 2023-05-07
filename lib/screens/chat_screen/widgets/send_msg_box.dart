// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/theming/constants/styles.dart';
import 'package:student_evaluation/theming/theme_calls.dart';

import '../../../fast_tools/widgets/button_wrapper.dart';
import '../../../fast_tools/widgets/custom_text_field.dart';
import '../../../theming/constants/sizes.dart';

class SendMessageBox extends StatelessWidget {
  const SendMessageBox({
    super.key,
    required this.focusNode,
  });

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: colorTheme.backGround,
      padding: EdgeInsets.symmetric(
        horizontal: kHPad,
        vertical: kVPad / 2,
      ),
      child: CustomTextField(
        focusNode: focusNode,
        borderRadius: BorderRadius.circular(1000),
        backgroundColor: colorTheme.kBlueColor,
        hintStyle: h4LightTextStyle.copyWith(
          color: Colors.white.withOpacity(
            .7,
          ),
        ),
        textStyle: h4LightTextStyle,
        padding: EdgeInsets.zero,
        title: 'Type Something...',
        color: colorTheme.kBlueColor,
        trailingIcon: ButtonWrapper(
          padding: EdgeInsets.all(largePadding),
          borderRadius: 1000,
          onTap: () {},
          backgroundColor: colorTheme.kBlueColor,
          child: Icon(
            Icons.send,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
