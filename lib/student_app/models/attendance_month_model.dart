import 'package:intl/intl.dart';

class AttendanceMonthModel {
  final String month;
  final int attended;
  final int monthDays;
  final int holidays;

  const AttendanceMonthModel({
    required this.month,
    required this.attended,
    required this.monthDays,
    required this.holidays,
  });
  // String get monthString => DateFormat('MMM yyyy').format(month);
  static String dateConvert(DateTime d) => DateFormat('MMM yyy').format(d);
}
