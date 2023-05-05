// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/screens/behavior_screen/behavior_screen.dart';
import 'package:student_evaluation/screens/home_work_screen/home_work_screen.dart';
import 'package:student_evaluation/screens/intro_screen/intro_screen.dart';
import 'package:student_evaluation/screens/login_screen/login_screen.dart';
import 'package:student_evaluation/screens/test_screen/test_screen.dart';

import '../screens/attendance_screen/attendance_screen.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/loading_screen.dart';

class ScreensInit {
  static Map<String, Widget Function(BuildContext)> routes = {
    HomeScreen.routeName: (context) => HomeScreen(),
    LoginScreen.routeName: (context) => LoginScreen(),
    IntroScreen.routeName: (context) => IntroScreen(),
    TestScreen.routeName: (context) => TestScreen(),
    AttendanceScreen.routeName: (context) => AttendanceScreen(),
    BehaviorScreen.routeName: (context) => BehaviorScreen(),
    HomeWorkScreen.routeName: (context) => HomeWorkScreen(),
  };

  static Widget? home = StreamBuilder(
    stream: FirebaseAuth.instance.userChanges(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return LoadingScreen();
      } else if (snapshot.data != null) {
        return HomeScreen();
      } else {
        return IntroScreen();
      }
    },
  );
}
