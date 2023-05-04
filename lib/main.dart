// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/hive/hive_initiator.dart';
import 'init/firebase_init.dart';
import 'init/providers_init.dart';
import 'init/runtime_variables.dart';
import 'init/screens_init.dart';
import 'init/theme_init.dart';
import 'init/user_initiators.dart';

// flutter packages pub run build_runner build --delete-conflicting-outputs
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseInit.init();
  await UserInit.reloadUser();
  await HiveInitiator().setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProvidersInit.providers,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeInit.theme,
        debugShowCheckedModeBanner: false,
        title: 'Firebase Chat',
        home: ScreensInit.home,
        routes: ScreensInit.routes,
      ),
    );
  }
}
