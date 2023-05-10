// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/admin_app/screens/admin_home_screen/admin_home_screen.dart';
import 'package:student_evaluation/admin_app/screens/users_screen/users_screen.dart';
import 'package:student_evaluation/screens/add_event_screen/add_event_screen.dart';
import 'package:student_evaluation/screens/behavior_screen/behavior_screen.dart';
import 'package:student_evaluation/screens/chat_screen/chat_screen.dart';
import 'package:student_evaluation/screens/event_screen/event_screen.dart';
import 'package:student_evaluation/screens/home_work_screen/home_work_screen.dart';
import 'package:student_evaluation/screens/intro_screen/intro_screen.dart';
import 'package:student_evaluation/screens/login_screen/login_screen.dart';
import 'package:student_evaluation/screens/search_screen/search_screen.dart';
import 'package:student_evaluation/screens/settings_screen/settings_screen.dart';
import 'package:student_evaluation/admin_app/screens/signup_screen/signup_screen.dart';
import 'package:student_evaluation/screens/test_screen/test_screen.dart';
import 'package:student_evaluation/student_app/screens/student_behaviour_screen/student_behaviour_screen.dart';

import '../admin_app/screens/admin_student_materials/admin_student_materials.dart';
import '../screens/attendance_screen/attendance_screen.dart';
import '../screens/create_groups_screen/create_groups_screen.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/loading_screen.dart';
import '../screens/messages_screen/messages_screen.dart';
import '../student_app/screens/student_homework_screen/student_homework_screen.dart';
import '../student_app/screens/students_attendance_screen/students_attendance_screen.dart';

class ScreensInit {
  static Map<String, Widget Function(BuildContext)> routes = {
    HomeScreen.routeName: (context) => HomeScreen(),
    LoginScreen.routeName: (context) => LoginScreen(),
    IntroScreen.routeName: (context) => IntroScreen(),
    TestScreen.routeName: (context) => TestScreen(),
    AttendanceScreen.routeName: (context) => AttendanceScreen(),
    BehaviorScreen.routeName: (context) => BehaviorScreen(),
    HomeWorkScreen.routeName: (context) => HomeWorkScreen(),
    MessagesScreen.routeName: (context) => MessagesScreen(),
    ChatScreen.routeName: (context) => ChatScreen(),
    EventScreen.routeName: (context) => EventScreen(),
    SignUpScreen.routeName: (context) => SignUpScreen(),
    SearchScreen.routeName: (context) => SearchScreen(),
    CreateGroupsScreen.routeName: (context) => CreateGroupsScreen(),
    StudentAttendanceScreen.routeName: (context) => StudentAttendanceScreen(),
    StudentBehaviorScreen.routeName: (context) => StudentBehaviorScreen(),
    SettingsScreen.routeName: (context) => SettingsScreen(),
    AddEventScreen.routeName: (context) => AddEventScreen(),
    StudentHomeWorkScreen.routeName: (context) => StudentHomeWorkScreen(),
    AdminHomeScreen.routeName: (context) => AdminHomeScreen(),
    AdminUsersScreen.routeName: (context) => AdminUsersScreen(),
    AdminStudentMaterialScreen.routeName: (context) =>
        AdminStudentMaterialScreen(),
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
