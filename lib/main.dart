// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:student_evaluation/screens/test_screen/test_screen.dart';
import 'package:student_evaluation/theming/providers/theme_provider.dart';

import 'core/constants/languages_constants.dart';
import 'core/hive/hive_initiator.dart';
import 'init/firebase_init.dart';
import 'init/language_init.dart';
import 'init/providers_init.dart';
import 'init/runtime_variables.dart';
import 'init/screens_init.dart';
import 'init/theme_init.dart';
import 'init/user_initiators.dart';
import 'package:localization/localization.dart';
// flutter packages pub run build_runner build --delete-conflicting-outputs

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInit.init();
  FirebaseDatabase.instance.databaseURL =
      ('https://inidian-ta-default-rtdb.europe-west1.firebasedatabase.app');

  await UserInit.reloadUser();
  await HiveInitiator().setup();
  await loadCurrentLang();
  await ThemeProvider.loadTheme();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  void setLocale(Locale l) {
    setState(() {
      _locale = l;
    });
  }

  Locale? get locale => _locale;
  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['assets/languages'];

    return MultiProvider(
      providers: ProvidersInit.providers,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeInit.theme,
        debugShowCheckedModeBanner: false,
        locale: _locale,
        localizationsDelegates: [
          // delegate from flutter_localization
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          // delegate from localization package.
          LocalJsonLocalization.delegate,
        ],

        supportedLocales: supportedLocales,
        localeResolutionCallback: (locale, supportedLocales) {
          // to check for the saved locale key
          if (loadedCurrentLocale != null) {
            Locale localeHolder = Locale.fromSubtags(
              languageCode: loadedCurrentLocale!.languageCode,
            );
            Intl.defaultLocale = localeHolder.languageCode;
            loadedCurrentLocale = null;

            return localeHolder;
          }
          //! this line causes an error
          Intl.defaultLocale = locale?.languageCode;
          for (var l in supportedLocales) {
            if (l.languageCode.toLowerCase() ==
                locale?.languageCode.toLowerCase()) {
              return l;
            }
          }

          return enLocale;
        },
        title: 'Students Evaluation',
        home: testing ? TestScreen() : ScreensInit.home,
        // home: testing ? TestScreen() : CreateGroupsScreen(),
        routes: ScreensInit.routes,
      ),
    );
  }
}
