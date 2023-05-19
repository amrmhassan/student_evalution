// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/admin_app/screens/admin_home_screen/admin_home_screen.dart';
import 'package:student_evaluation/admin_app/screens/users_screen/users_screen.dart';
import 'package:student_evaluation/screens/add_event_screen/add_event_screen.dart';
import 'package:student_evaluation/screens/add_medical_state_screen/add_medical_state_screen.dart';
import 'package:student_evaluation/screens/all_students_screen/all_students_screen.dart';
import 'package:student_evaluation/screens/behavior_screen/behavior_screen.dart';
import 'package:student_evaluation/screens/camera_screen/camera_screen.dart';
import 'package:student_evaluation/screens/chat_screen/chat_screen.dart';
import 'package:student_evaluation/screens/event_screen/event_screen.dart';
import 'package:student_evaluation/screens/home_work_screen/home_work_screen.dart';
import 'package:student_evaluation/screens/intro_screen/intro_screen.dart';
import 'package:student_evaluation/screens/login_screen/login_screen.dart';
import 'package:student_evaluation/screens/medical_tracking_screen/medical_tracking_screen.dart';
import 'package:student_evaluation/screens/notifications_screen/notifications_screen.dart';
import 'package:student_evaluation/screens/search_screen/search_screen.dart';
import 'package:student_evaluation/screens/settings_screen/settings_screen.dart';
import 'package:student_evaluation/admin_app/screens/signup_screen/signup_screen.dart';
import 'package:student_evaluation/screens/test_screen/test_screen.dart';
import 'package:student_evaluation/student_app/screens/student_behaviour_screen/student_behaviour_screen.dart';
import 'package:student_evaluation/student_app/screens/student_materials_screen/student_materials_screen.dart';

import '../admin_app/screens/admin_add_time_table_screen/admin_add_time_table_screen.dart';
import '../admin_app/screens/admin_student_materials/admin_student_materials.dart';
import '../admin_app/screens/admin_time_table_screen/admin_time_table_screen.dart';
import '../screens/absent_request_view_screen/absent_request_view_screen.dart';
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
    AdminMaterialsScreen.routeName: (context) => AdminMaterialsScreen(),
    StudentMaterialsScreen.routeName: (context) => StudentMaterialsScreen(),
    AdminTimeTableScreen.routeName: (context) => AdminTimeTableScreen(),
    AdminAddTimeTableScreen.routeName: (context) => AdminAddTimeTableScreen(),
    NotificationsScreen.routeName: (context) => NotificationsScreen(),
    MedicalTrackingScreen.routeName: (context) => MedicalTrackingScreen(),
    AddMedicalStateScreen.routeName: (context) => AddMedicalStateScreen(),
    AllStudentsScreen.routeName: (context) => AllStudentsScreen(),
    AbsentRequestViewScreen.routeName: (context) => AbsentRequestViewScreen(),
    CameraScreen.routeName: (context) => CameraScreen(),
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
