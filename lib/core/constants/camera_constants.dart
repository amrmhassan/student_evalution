// ignore_for_file: prefer_const_constructors

import '../../models/user_model.dart';

class CamModel {
  final String camLink;
  final StudentGrade grade;
  const CamModel({
    required this.camLink,
    required this.grade,
  });
}

List<CamModel> cams = [
  CamModel(camLink: 'camLink', grade: StudentGrade.juniorSectionA),
  CamModel(camLink: 'camLink', grade: StudentGrade.juniorSectionB),
  CamModel(camLink: 'camLink', grade: StudentGrade.juniorSectionA),
  CamModel(camLink: 'camLink', grade: StudentGrade.juniorSectionA),
  CamModel(camLink: 'camLink', grade: StudentGrade.juniorSectionA),
  CamModel(camLink: 'camLink', grade: StudentGrade.juniorSectionA),
];

CamModel getUserCam(StudentGrade grade) {
  return cams.firstWhere((element) => element.grade == grade);
}
