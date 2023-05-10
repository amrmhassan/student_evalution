import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/models/time_table_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/transformers/collections.dart';
import 'package:student_evaluation/transformers/models_fields.dart';
// import 'package:student_evaluation/models/user_model.dart';

class TimeLineProvider extends ChangeNotifier {
  DateTime get nowDate => DateTime.now();
  late DateTime currentDay = DateTime(nowDate.year, nowDate.month, nowDate.day);

  void setCurrentDay(
    DateTime dateTime, {
    required UserModel? userModel,
  }) {
    currentDay = dateTime;
    notifyListeners();
    loadTimeTable(userModel: userModel);
  }

  List<TimeTableModel> timeTable = [];
  bool loadingTimeTable = false;

  Future<void> loadTimeTable({
    required UserModel? userModel,
  }) async {
    if (userModel is AdminModel) return;
    loadingTimeTable = true;
    timeTable.clear();
    notifyListeners();
    try {
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs;
      if (userModel is TeacherModel) {
        // for teacher time table

        docs = (await FirebaseFirestore.instance
                .collection(DBCollections.timeTable)
                .where(
                  ModelsFields.teacherClass,
                  isEqualTo: userModel.teacherClass.name,
                )
                .where(
                  ModelsFields.weekDay,
                  isEqualTo: currentDay.weekday,
                )
                .get())
            .docs;
      } else if (userModel is StudentModel) {
        // for student time table
        docs = (await FirebaseFirestore.instance
                .collection(DBCollections.timeTable)
                .where(
                  ModelsFields.studentGrade,
                  isEqualTo: userModel.studentGrade.name,
                )
                .get())
            .docs;
      }
      if (docs == null) {
        throw Exception('cant load time table');
      }
      for (var doc in docs) {
        timeTable.add(TimeTableModel.fromJSON(doc.data()));
      }
      timeTable.sort(
        (a, b) => (a.hour + a.minute).compareTo(b.hour + b.minute),
      );

      loadingTimeTable = false;
      notifyListeners();
    } catch (e) {
      loadingTimeTable = false;
      notifyListeners();
      rethrow;
    }
  }
}
