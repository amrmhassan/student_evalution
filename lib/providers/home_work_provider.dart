// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/utils/global_utils.dart';

class HomeWorkProvider extends ChangeNotifier {
  bool sendingHomeWork = false;
  StudentGrade activeGrade = StudentGrade.k1SectionA;
  String? documentLink;
  String? description;
  String startDate = GlobalUtils.dateToString(DateTime.now());
  String endDate = GlobalUtils.dateToString(
    DateTime.now().add(
      Duration(
        days: 2,
      ),
    ),
  );
  List<String> usersIDs = [];

  void setStartDate(DateTime d) {
    startDate = GlobalUtils.dateToString(d);
    notifyListeners();
  }

  void setEndDate(DateTime d) {
    endDate = GlobalUtils.dateToString(d);
    notifyListeners();
  }

  void setDocumentLink(String link) {
    documentLink = link;
    notifyListeners();
  }

  void setDescription(String d) {
    description = d;
    notifyListeners();
  }

  void setActiveGrade(StudentGrade g) {
    activeGrade = g;
    notifyListeners();
  }

  bool homeWorkAssigned(String userID) {
    return usersIDs.any((element) => element == userID);
  }

  void toggleAssign(String userID) {
    bool assigned = homeWorkAssigned(userID);
    if (assigned) {
      usersIDs.remove(userID);
    } else {
      usersIDs.add(userID);
    }
    notifyListeners();
  }
}
