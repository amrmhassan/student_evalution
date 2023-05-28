import 'package:intl/intl.dart';

class AttendanceMonthModel {
  final String month;
  final int attended;

  const AttendanceMonthModel({
    required this.month,
    required this.attended,
  });
  // String get monthString => DateFormat('MMM yyyy').format(month);
  static String dateConvert(DateTime d) => DateFormat('MMM yyy').format(d);

  int get getWorkingDays {
    DateFormat dateFormat = DateFormat('MMM yyy');
    DateTime currentMonth = dateFormat.parse(month);
    DateTime now = DateTime.now();
    int diff = now.difference(currentMonth).inDays + 1;
    diff = diff > 30 ? 30 : diff;
    return diff;
  }

  int get getHolidaysDays {
    int workingDays = getWorkingDays;
    int holidays = workingDays ~/ 7;
    return holidays;
  }
}
