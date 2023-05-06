import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/transformers/models_fields.dart';

class HomeWorkModel {
  String? id;
  final String day;
  final StudentGrade studentGrade;
  final TeacherClass teacherClass;
  final String? documentLink;
  final String? description;
  final String startDate;
  final String endDate;
  final List<String> usersIds;

  HomeWorkModel({
    required this.id,
    required this.day,
    required this.studentGrade,
    required this.teacherClass,
    required this.documentLink,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.usersIds,
  });

  Map<String, dynamic> toJSON() {
    return {
      ModelsFields.id: id,
      ModelsFields.day: day,
      ModelsFields.studentGrade: studentGrade.name,
      ModelsFields.teacherClass: teacherClass.name,
      ModelsFields.documentLink: documentLink,
      ModelsFields.description: description,
      ModelsFields.startDate: startDate,
      ModelsFields.endDate: endDate,
      ModelsFields.usersIds: usersIds,
    };
  }
}
