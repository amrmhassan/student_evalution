import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:student_evaluation/models/user_model.dart';

String gradeTransformer(StudentGrade grade) {
  if (grade == StudentGrade.k1SectionA) {
    return 'K1 Section A';
  } else if (grade == StudentGrade.k1SectionB) {
    return 'K1 Section B';
  } else if (grade == StudentGrade.k2SectionA) {
    return 'K2 Section A';
  } else if (grade == StudentGrade.k2SectionB) {
    return 'K2 Section B';
  }
  return 'please add this grade transformer';
}

String classTransformer(TeacherClass className) {
  return className.name.capitalize;
  // if (className == StudentGrade.k1SectionA) {
  //   return 'K1 Section A';
  // } else if (className == StudentGrade.k1SectionB) {
  //   return 'K1 Section B';
  // } else if (className == StudentGrade.k2SectionA) {
  //   return 'K2 Section A';
  // } else if (className == StudentGrade.k2SectionB) {
  //   return 'K2 Section B';
  // }
  // return 'please add this grade transformer';
}
