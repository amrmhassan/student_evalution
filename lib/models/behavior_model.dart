import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/transformers/models_fields.dart';
import 'package:student_evaluation/utils/global_utils.dart';

enum BehaviorState {
  active,
  normal,
  worry,
}

class BehaviourModel {
  String? id;
  final String day;
  final String userId;
  BehaviorState state;
  final StudentGrade studentGrade;
  final TeacherClass teacherClass;

  BehaviourModel({
    required this.id,
    required this.day,
    required this.state,
    required this.userId,
    required this.studentGrade,
    required this.teacherClass,
  });

  Map<String, dynamic> toJSON() {
    return {
      ModelsFields.id: id,
      ModelsFields.day: day,
      ModelsFields.userId: userId,
      ModelsFields.state: state.name,
      ModelsFields.studentGrade: studentGrade.name,
      ModelsFields.teacherClass: teacherClass.name,
    };
  }

  static BehaviourModel fromJSON(Map<String, dynamic> obj) {
    return BehaviourModel(
        id: obj[ModelsFields.id],
        day: obj[ModelsFields.day],
        state: GlobalUtils.stringToEnum(
          obj[ModelsFields.state],
          BehaviorState.values,
        ),
        userId: obj[ModelsFields.userId],
        studentGrade: GlobalUtils.stringToEnum(
          obj[ModelsFields.studentGrade],
          StudentGrade.values,
        ),
        teacherClass: GlobalUtils.stringToEnum(
          obj[ModelsFields.teacherClass],
          TeacherClass.values,
        ));
  }
}
