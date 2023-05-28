// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_evaluation/fast_tools/constants/shared_pref_constants.dart';
import 'package:student_evaluation/fast_tools/helpers/shared_pref_helper.dart';
import 'package:student_evaluation/init/runtime_variables.dart';
import 'package:student_evaluation/utils/global_utils.dart';

import '../color_theme.dart';
import '../size_theme.dart';

enum CustomThemeMode {
  light,
  dark,
}

ColorTheme lightColorTheme = const ColorTheme();
ColorTheme darkColorTheme = ColorTheme(backGround: Colors.black);
SizeTheme _defaultSizeTheme = SizeTheme();

class ThemeProvider extends ChangeNotifier {
  SizeTheme defaultSizes = _defaultSizeTheme;

  CustomThemeMode themeMode = customThemeMode;
  ColorTheme get defaultColors =>
      themeMode == CustomThemeMode.light ? lightColorTheme : darkColorTheme;

  void setThemeMode(CustomThemeMode mode) {
    themeMode = mode;
    notifyListeners();
    SharedPrefHelper.setString(themeKey, mode.name);
  }

  static Future<void> loadTheme() async {
    String theme = await SharedPrefHelper.getString(themeKey) ??
        CustomThemeMode.light.name;

    CustomThemeMode loaded =
        GlobalUtils.stringToEnum(theme, CustomThemeMode.values);
    customThemeMode = loaded;
  }

  void updateColorTheme(ColorTheme newColorTheme) {
    // defaultColors = newColorTheme;
    notifyListeners();
  }

  void applyDarkTheme() {
    setThemeMode(CustomThemeMode.dark);
    updateColorTheme(darkColorTheme);
  }

  void applyLightTheme() {
    setThemeMode(CustomThemeMode.light);
    updateColorTheme(lightColorTheme);
  }
}

ThemeProvider get themeProvider =>
    Provider.of<ThemeProvider>(navigatorKey.currentContext!);
