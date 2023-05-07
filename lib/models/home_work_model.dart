import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/transformers/models_fields.dart';
import 'package:student_evaluation/utils/global_utils.dart';

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

  static HomeWorkModel fromJSON(Map<String, dynamic> obj) {
    List<String> fetchedUserIds = (obj[ModelsFields.usersIds] as List).cast();
    return HomeWorkModel(
      id: obj[ModelsFields.id],
      day: obj[ModelsFields.day],
      studentGrade: GlobalUtils.stringToEnum(
        obj[ModelsFields.studentGrade],
        StudentGrade.values,
      ),
      teacherClass: GlobalUtils.stringToEnum(
        obj[ModelsFields.teacherClass],
        TeacherClass.values,
      ),
      documentLink: obj[ModelsFields.documentLink],
      description: obj[ModelsFields.description],
      startDate: obj[ModelsFields.startDate],
      endDate: obj[ModelsFields.endDate],
      usersIds: fetchedUserIds,
    );
  }
}
