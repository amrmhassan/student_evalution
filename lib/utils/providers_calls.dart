import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_evaluation/providers/app_state_provider.dart';
import 'package:student_evaluation/providers/attendance_provider.dart';
import 'package:student_evaluation/providers/event_provider.dart';
import 'package:student_evaluation/providers/home_work_provider.dart';
import 'package:student_evaluation/providers/language_provider.dart';
import 'package:student_evaluation/providers/message_provider.dart';
import 'package:student_evaluation/providers/notifications_provider.dart';
import 'package:student_evaluation/providers/time_line_provider.dart';
import 'package:student_evaluation/student_app/providers/student_behaviour_provider.dart';
import 'package:student_evaluation/student_app/providers/student_homework_provider.dart';
import 'package:student_evaluation/student_app/providers/students_attend_provider.dart';
import 'package:student_evaluation/theming/providers/theme_provider.dart';

import '../providers/behavior_provider.dart';
import '../providers/user_provider.dart';

class Providers {
  static UserProvider userPf(BuildContext context) {
    return Provider.of<UserProvider>(context, listen: false);
  }

  static UserProvider userP(BuildContext context) {
    return Provider.of<UserProvider>(context);
  }

  static AppStateProvider appSPf(BuildContext context) {
    return Provider.of<AppStateProvider>(context, listen: false);
  }

  static AppStateProvider appSP(BuildContext context) {
    return Provider.of<AppStateProvider>(context);
  }

  static TimeLineProvider timeLPf(BuildContext context) {
    return Provider.of<TimeLineProvider>(context, listen: false);
  }

  static TimeLineProvider timeLP(BuildContext context) {
    return Provider.of<TimeLineProvider>(context);
  }

  static AttendanceProvider attendPf(BuildContext context) {
    return Provider.of<AttendanceProvider>(context, listen: false);
  }

  static AttendanceProvider attendP(BuildContext context) {
    return Provider.of<AttendanceProvider>(context);
  }

  static BehaviorProvider behavePf(BuildContext context) {
    return Provider.of<BehaviorProvider>(context, listen: false);
  }

  static BehaviorProvider behaveP(BuildContext context) {
    return Provider.of<BehaviorProvider>(context);
  }

  static HomeWorkProvider homeWPf(BuildContext context) {
    return Provider.of<HomeWorkProvider>(context, listen: false);
  }

  static HomeWorkProvider homeWP(BuildContext context) {
    return Provider.of<HomeWorkProvider>(context);
  }

  static MessageProvider msgPf(BuildContext context) {
    return Provider.of<MessageProvider>(context, listen: false);
  }

  static MessageProvider msgP(BuildContext context) {
    return Provider.of<MessageProvider>(context);
  }

  static StudentAttendProvider studentAttendPf(BuildContext context) {
    return Provider.of<StudentAttendProvider>(context, listen: false);
  }

  static StudentAttendProvider studentAttendP(BuildContext context) {
    return Provider.of<StudentAttendProvider>(context);
  }

  static StudentBehaviourProvider studentBehavePf(BuildContext context) {
    return Provider.of<StudentBehaviourProvider>(context, listen: false);
  }

  static StudentBehaviourProvider studentBehaveP(BuildContext context) {
    return Provider.of<StudentBehaviourProvider>(context);
  }

  static EventProvider eventPf(BuildContext context) {
    return Provider.of<EventProvider>(context, listen: false);
  }

  static EventProvider eventP(BuildContext context) {
    return Provider.of<EventProvider>(context);
  }

  static StudentHomeWorkProvider studentHWPf(BuildContext context) {
    return Provider.of<StudentHomeWorkProvider>(context, listen: false);
  }

  static StudentHomeWorkProvider studentHWP(BuildContext context) {
    return Provider.of<StudentHomeWorkProvider>(context);
  }

  static NotificationProvider notifyPf(BuildContext context) {
    return Provider.of<NotificationProvider>(context, listen: false);
  }

  static NotificationProvider notifyP(BuildContext context) {
    return Provider.of<NotificationProvider>(context);
  }

  static LanguageProvider langPf(BuildContext context) {
    return Provider.of<LanguageProvider>(context, listen: false);
  }

  static LanguageProvider langP(BuildContext context) {
    return Provider.of<LanguageProvider>(context);
  }

  static ThemeProvider themePf(BuildContext context) {
    return Provider.of<ThemeProvider>(context, listen: false);
  }

  static ThemeProvider themeP(BuildContext context) {
    return Provider.of<ThemeProvider>(context);
  }
}
