// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'constants/colors.dart';

part 'color_theme.g.dart';

@CopyWith()
class ColorTheme {
  final Color backGround;
  final Color cardBackground;
  final Color cardBackgroundDark;
  final Color lightCardBackground;
  final Color kInactiveColor;
  final Color kBlueColor;
  final Color textFieldBackgroundColor;
  final Color kMainIconColor;
  final Color kDangerColor;
  final Color kGreenColor;

  final Color activeText;
  final Color inActiveText;

  const ColorTheme({
    this.backGround = LightThemeColors.kBackgroundColor,
    this.cardBackground = LightThemeColors.kCardBackgroundColor,
    this.cardBackgroundDark = LightThemeColors.kCardBackgroundColorDark,
    this.lightCardBackground = LightThemeColors.kLightCardBackgroundColor,
    this.kInactiveColor = LightThemeColors.kInactiveColor,
    this.kBlueColor = LightThemeColors.kBlueColor,
    this.textFieldBackgroundColor = LightThemeColors.textFieldBackgroundColor,
    this.kMainIconColor = LightThemeColors.kBlueColor,
    this.kDangerColor = LightThemeColors.kDangerColor,
    this.kGreenColor = LightThemeColors.kGreenColor,
    this.activeText = TextColors.kActiveTextColor,
    this.inActiveText = TextColors.kInActiveTextColor,
  });
}
