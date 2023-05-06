// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/utils/global_utils.dart';

import '../transformers/collections.dart';
import '../transformers/models_fields.dart';

class HomeWorkProvider extends ChangeNotifier {
  bool loadingUsers = false;
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
  List<String> assignedUsersIDs = [];
  List<UserModel> gradeUsers = [];

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
    return assignedUsersIDs.any((element) => element == userID);
  }

  void toggleAssign(String userID) {
    bool assigned = homeWorkAssigned(userID);
    if (assigned) {
      assignedUsersIDs.remove(userID);
    } else {
      assignedUsersIDs.add(userID);
    }
    notifyListeners();
  }

  Future<void> loadUserGrades() async {
    loadingUsers = true;
    notifyListeners();
    var docs = (await FirebaseFirestore.instance
            .collection(DBCollections.users)
            .where(
              ModelsFields.studentGrade,
              isEqualTo: activeGrade.name,
            )
            .get())
        .docs;
    for (var user in docs) {
      UserModel u = UserModel.fromJSON(user.data());
      gradeUsers.add(u);
    }
    loadingUsers = false;
    notifyListeners();
  }
}
