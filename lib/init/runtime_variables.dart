import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:student_evaluation/theming/providers/theme_provider.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Logger logger = Logger();
bool testing = false;
Locale? loadedCurrentLocale;
late CustomThemeMode customThemeMode;
