import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/transformers/models_fields.dart';
import 'package:student_evaluation/utils/global_utils.dart';

class MaterialModel {
  final String id;
  final StudentGrade studentGrade;
  final TeacherClass teacherClass;
  final String link;

  const MaterialModel({
    required this.id,
    required this.studentGrade,
    required this.link,
    required this.teacherClass,
  });

  Map<String, dynamic> toJSON() {
    return {
      ModelsFields.id: id,
      ModelsFields.studentGrade: studentGrade.name,
      ModelsFields.teacherClass: teacherClass.name,
      ModelsFields.link: link,
    };
  }

  static MaterialModel fromJSON(Map<String, dynamic> obj) {
    return MaterialModel(
      id: obj[ModelsFields.id],
      studentGrade: GlobalUtils.stringToEnum(
        obj[ModelsFields.studentGrade],
        StudentGrade.values,
      ),
      link: obj[ModelsFields.link],
      teacherClass: GlobalUtils.stringToEnum(
        obj[ModelsFields.teacherClass],
        TeacherClass.values,
      ),
    );
  }
}
