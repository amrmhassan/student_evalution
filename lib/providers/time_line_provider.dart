import 'package:flutter/material.dart';
// import 'package:student_evaluation/models/user_model.dart';

class TimeLineProvider extends ChangeNotifier {
  DateTime get nowDate => DateTime.now();
  late DateTime currentDay = DateTime(nowDate.year, nowDate.month, nowDate.day);
  void setCurrentDay(DateTime dateTime) {
    currentDay = dateTime;
    notifyListeners();
  }

  // StudentGrade activeGrade = StudentGrade.k1SectionA;
  // void setGrade(StudentGrade grade) {
  //   activeGrade = grade;
  //   notifyListeners();
  // }
}
