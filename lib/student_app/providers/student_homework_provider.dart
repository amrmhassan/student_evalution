import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/models/home_work_model.dart';
import 'package:student_evaluation/models/user_model.dart';

import '../../transformers/collections.dart';

class StudentHomeWorkProvider extends ChangeNotifier {
  final List<HomeWorkModel> _homeWorks = [];
  List<HomeWorkModel> get homeWorks => [..._homeWorks];
  bool loadingHomeWork = false;
  TeacherClass activeTeacherClass = TeacherClass.arabic;

  void setActiveTeacherClass(TeacherClass teacherClass) {
    activeTeacherClass = teacherClass;
    notifyListeners();
  }

  Future<void> loadHomeWorks(StudentGrade grade) async {
    loadingHomeWork = true;
    _homeWorks.clear();

    notifyListeners();
    var res = await FirebaseDatabase.instance
        .ref(DBCollections.homeWorks)
        .child(grade.name)
        .get();

    for (var doc in res.children) {
      var value = doc.value;
      var test = (value as Map<dynamic, dynamic>);

      Map<String, dynamic> data = {};
      test.forEach((key, value) {
        data[key.toString()] = value;
      });
      HomeWorkModel homeWorkModel = HomeWorkModel.fromJSON(data);
      if (homeWorkModel.teacherClass != activeTeacherClass) continue;
      _homeWorks.add(homeWorkModel);
    }
    loadingHomeWork = false;
    notifyListeners();
  }
}
