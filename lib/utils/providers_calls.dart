import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_evaluation/providers/app_state_provider.dart';
import 'package:student_evaluation/providers/attendance_provider.dart';
import 'package:student_evaluation/providers/time_line_provider.dart';

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
}
