import 'package:intl/intl.dart';

class BehaviourMonthModel {
  final String month;
  final double avg;

  const BehaviourMonthModel({
    required this.month,
    required this.avg,
  });
  static String dateConvert(DateTime d) => DateFormat('MMM yyy').format(d);
  double get stars => 5 * avg;
}
