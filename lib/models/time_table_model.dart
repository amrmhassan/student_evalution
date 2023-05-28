import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/transformers/models_fields.dart';
import 'package:student_evaluation/utils/global_utils.dart';

class TimeTableModel {
  final String id;
  final TeacherClass teacherClass;
  final StudentGrade studentGrade;
  final int weekDay;
  final int hour;
  final int minute;

  const TimeTableModel({
    required this.id,
    required this.teacherClass,
    required this.studentGrade,
    required this.weekDay,
    required this.hour,
    required this.minute,
  });

  Map<String, dynamic> toJSON() {
    return {
      ModelsFields.id: id,
      ModelsFields.teacherClass: teacherClass.name,
      ModelsFields.studentGrade: studentGrade.name,
      ModelsFields.weekDay: weekDay,
      ModelsFields.hour: hour,
      ModelsFields.minute: minute,
    };
  }

  static TimeTableModel fromJSON(Map<String, dynamic> obj) {
    return TimeTableModel(
      id: obj[ModelsFields.id],
      teacherClass: GlobalUtils.stringToEnum(
        obj[ModelsFields.teacherClass],
        TeacherClass.values,
      ),
      studentGrade: GlobalUtils.stringToEnum(
        obj[ModelsFields.studentGrade],
        StudentGrade.values,
      ),
      weekDay: obj[ModelsFields.weekDay],
      hour: obj[ModelsFields.hour],
      minute: obj[ModelsFields.minute],
    );
  }
}
