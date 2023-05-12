import 'dart:ui';

import 'package:student_evaluation/init/runtime_variables.dart';

import '../fast_tools/constants/shared_pref_constants.dart';
import '../fast_tools/helpers/shared_pref_helper.dart';

Future<void> loadCurrentLang() async {
  String? loaded = await SharedPrefHelper.getString(languageKey);
  if (loaded == null) return;
  loadedCurrentLocale = Locale.fromSubtags(languageCode: loaded);
}
