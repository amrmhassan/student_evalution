import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/models/medical_state_model.dart';

import '../models/absent_request_model.dart';
import '../models/user_model.dart';
import '../transformers/collections.dart';
import '../transformers/models_fields.dart';

class AllStudentsProvider extends ChangeNotifier {
  bool loadingGrades = false;
  StudentGrade activeGrade = StudentGrade.k1SectionA;

  void setActiveGrade(StudentGrade g) {
    activeGrade = g;
    notifyListeners();
  }

  List<UserModel> gradeUsers = [];

  Future<void> loadUserGrades() async {
    loadingGrades = true;
    gradeUsers.clear();
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
    loadingGrades = false;
    notifyListeners();
  }

  Future<List<MedicalStateModel>> loadUserMedicalStates(
      String studentId) async {
    var docs = (await FirebaseFirestore.instance
            .collection(DBCollections.medical)
            .where('studentId', isEqualTo: studentId)
            .get())
        .docs;
    return docs.map((e) => MedicalStateModel.fromJson(e.data())).toList();
  }

  Future<List<AbsentRequestModel>> loadUserAbsentState(String studentId) async {
    var docs = (await FirebaseFirestore.instance
            .collection(DBCollections.absentRequest)
            .where('userId', isEqualTo: studentId)
            .get())
        .docs;
    return docs.map((e) => AbsentRequestModel.fromJson(e.data())).toList();
  }
}
