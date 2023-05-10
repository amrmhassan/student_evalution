import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:student_evaluation/providers/app_state_provider.dart';
import 'package:student_evaluation/providers/attendance_provider.dart';
import 'package:student_evaluation/providers/behavior_provider.dart';
import 'package:student_evaluation/providers/event_provider.dart';
import 'package:student_evaluation/providers/home_work_provider.dart';
import 'package:student_evaluation/providers/message_provider.dart';
import 'package:student_evaluation/providers/notifications_provider.dart';
import 'package:student_evaluation/providers/time_line_provider.dart';
import 'package:student_evaluation/student_app/providers/student_behaviour_provider.dart';
import 'package:student_evaluation/student_app/providers/student_homework_provider.dart';
import 'package:student_evaluation/student_app/providers/students_attend_provider.dart';

import '../providers/user_provider.dart';
import '../theming/providers/theme_provider.dart';

class ProvidersInit {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => AppStateProvider()),
    ChangeNotifierProvider(create: (context) => TimeLineProvider()),
    ChangeNotifierProvider(create: (context) => AttendanceProvider()),
    ChangeNotifierProvider(create: (context) => BehaviorProvider()),
    ChangeNotifierProvider(create: (context) => HomeWorkProvider()),
    ChangeNotifierProvider(create: (context) => MessageProvider()),
    ChangeNotifierProvider(create: (context) => StudentAttendProvider()),
    ChangeNotifierProvider(create: (context) => StudentBehaviourProvider()),
    ChangeNotifierProvider(create: (context) => EventProvider()),
    ChangeNotifierProvider(create: (context) => StudentHomeWorkProvider()),
    ChangeNotifierProvider(create: (context) => NotificationProvider()),
  ];
}
