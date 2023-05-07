import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_evaluation/models/attendance_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/student_app/models/attendance_month_model.dart';
import 'package:student_evaluation/transformers/collections.dart';
import 'package:student_evaluation/transformers/models_fields.dart';

class StudentAttendProvider extends ChangeNotifier {
  List<AttendanceModel> attendData = [];
  List<AttendanceMonthModel> months = [];

  TeacherClass activeClass = TeacherClass.biology;

  void setActiveClass(TeacherClass g) {
    activeClass = g;
    notifyListeners();
  }

  var loading = false;
  Future<void> loadAttendData(StudentModel studentModel) async {
    try {
      attendData.clear();
      loading = true;
      notifyListeners();
      var docs = (await FirebaseFirestore.instance
              .collection(DBCollections.attendance)
              .where(ModelsFields.userId, isEqualTo: studentModel.uid)
              .where(ModelsFields.teacherClass, isEqualTo: activeClass.name)
              .get())
          .docs;
      for (var doc in docs) {
        var model = AttendanceModel.fromJSON(doc.data());
        attendData.add(model);
      }
      _calcAttendance();
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      rethrow;
    }
  }

  void _calcAttendance() {
    months.clear();
    var copiedData = [...attendData];
    var nullModel = AttendanceModel(
      id: 'id',
      day: '2020-05-06',
      state: AttendanceState.absent,
      userId: 'userId',
      studentGrade: StudentGrade.k1SectionA,
      teacherClass: TeacherClass.biology,
    );

    copiedData.sort((a, b) => a.day.compareTo(b.day));
    copiedData.add(nullModel);
    DateFormat dateFormat = DateFormat('yyy-MM-dd');
    String currentMonth = AttendanceMonthModel.dateConvert(
      dateFormat.parse(
        copiedData.first.day,
      ),
    );
    int attended = 0;

    for (var data in copiedData) {
      String month = AttendanceMonthModel.dateConvert(
        dateFormat.parse(
          data.day,
        ),
      );
      if (month != currentMonth) {
        // here create a new month model  and add it to the list
        // then clean the counters
        AttendanceMonthModel model = AttendanceMonthModel(
          month: currentMonth,
          attended: attended,
        );
        months.add(model);
        currentMonth = month;
        attended = 0;
      } else {
        // here just increment counter
        attended++;
      }
    }
    notifyListeners();
  }
}
