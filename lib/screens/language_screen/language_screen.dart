// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:student_evaluation/fast_tools/widgets/screen_wrapper.dart';
import 'package:student_evaluation/theming/theme_calls.dart';
import 'package:student_evaluation/utils/global_utils.dart';
import 'package:student_evaluation/utils/providers_calls.dart';

import '../../core/constants/languages_constants.dart';
import '../../fast_tools/widgets/button_wrapper.dart';
import '../../fast_tools/widgets/v_space.dart';
import '../../theming/constants/styles.dart';

class LanguageScreen extends StatefulWidget {
  static const String routeName = '/LanguageScreen';
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late Map<String, String> languageMap;
  @override
  void initState() {
    languageMap = getLanguageNames(supportedLocales);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var langProvider = Providers.langP(context);
    return ScreenWrapper(
      backgroundColor: colorTheme.backGround,
      body: Column(
        children: [
          // CustomAppBar(
          //   title: Text('change-language'.i18n()),
          // ),
          VSpace(),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: supportedLocales.length,
              itemBuilder: (context, index) {
                var locale = supportedLocales[index];
                return ButtonWrapper(
                  backgroundColor: langProvider.locale == locale
                      ? colorTheme.cardBackground
                      : null,
                  onTap: () {
                    Providers.langPf(context).setLocale(context, locale);
                    // CustomLocale.changeLocale(context, enLocale);
                    GlobalUtils.showSnackBar(
                      context: context,
                      message: "apply-on-next-startup".i18n(),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      languageMap[locale.languageCode] ?? 'Unknown',
                      style: h4TextStyleInactive,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
