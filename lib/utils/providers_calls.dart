import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_evaluation/providers/app_state_provider.dart';
import 'package:student_evaluation/providers/time_line_provider.dart';

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
}
