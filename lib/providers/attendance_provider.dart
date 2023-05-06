// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/models/attendance_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/transformers/collections.dart';
import 'package:student_evaluation/transformers/models_fields.dart';
import 'package:student_evaluation/utils/global_utils.dart';

class AttendanceProvider extends ChangeNotifier {
  bool loadingAttendance = false;
  StudentGrade activeGrade = StudentGrade.k1SectionA;

  void setActiveGrade(StudentGrade g) {
    activeGrade = g;
    notifyListeners();
  }

  List<UserModel> gradeUsers = [];
  List<AttendanceModel> attendanceData = [];

  Future<void> loadAttendanceData(
    TeacherClass currentTeacherClass,
    DateTime dateTime,
  ) async {
    attendanceData.clear();
    gradeUsers.clear();
    loadingAttendance = true;
    notifyListeners();

    await _loadUserGrades();
    var docs = (await FirebaseFirestore.instance
            .collection(DBCollections.attendance)
            .where(
              ModelsFields.studentGrade,
              isEqualTo: activeGrade.name,
            )
            .where(
              ModelsFields.teacherClass,
              isEqualTo: currentTeacherClass.name,
            )
            .where(
              ModelsFields.day,
              isEqualTo: GlobalUtils.dateToString(dateTime),
            )
            .get())
        .docs;
    for (var attendanceMap in docs) {
      AttendanceModel model = AttendanceModel.fromJSON(attendanceMap.data());
      attendanceData.add(model);
    }
    loadingAttendance = false;
    notifyListeners();
  }

  Future<void> _loadUserGrades() async {
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
    notifyListeners();
  }

  AttendanceModel? getAttendanceModelByUserId({
    required String userId,
  }) {
    try {
      return attendanceData.firstWhere((element) => element.userId == userId);
    } catch (e) {
      return null;
    }
  }

  AttendanceModel? getAttendanceModelByModelId({
    required String modelId,
  }) {
    try {
      return attendanceData.firstWhere((element) => element.id == modelId);
    } catch (e) {
      return null;
    }
  }

  void changeAttendanceState({
    required AttendanceState state,
    required String userId,
    required StudentGrade studentGrade,
    required TeacherClass teacherClass,
    required DateTime currentDate,
  }) {
    AttendanceModel? attendModel = getAttendanceModelByUserId(userId: userId);
    if (attendModel == null) {
      AttendanceModel newModel = AttendanceModel(
        id: null,
        day: GlobalUtils.dateToString(currentDate),
        state: state,
        userId: userId,
        studentGrade: studentGrade,
        teacherClass: teacherClass,
      );
      _addNewAttendState(newModel);
    } else {
      attendModel.state = state;
      _updateAttendState(attendModel);
    }
  }

  Future<String> _saveAttendModel(AttendanceModel model) async {
    var res = await FirebaseFirestore.instance
        .collection(DBCollections.attendance)
        .add(model.toJSON());
    model.id = res.id;
    await FirebaseFirestore.instance
        .collection(DBCollections.attendance)
        .doc(res.id)
        .set(model.toJSON());
    return res.id;
  }

  Future<void> _updateAttendanceModel(AttendanceModel model) async {
    await FirebaseFirestore.instance
        .collection(DBCollections.attendance)
        .doc(model.id!)
        .set(model.toJSON());
  }

  void _updateAttendState(AttendanceModel model) {
    int index = attendanceData.indexWhere((element) => element.id == model.id);
    attendanceData[index] = model;
    notifyListeners();
  }

  void _addNewAttendState(AttendanceModel model) {
    bool exist =
        attendanceData.any((element) => element.userId == model.userId);
    if (exist) {
      int index = attendanceData
          .indexWhere((element) => element.userId == model.userId);
      attendanceData[index] = model;
    } else {
      attendanceData.add(model);
    }
    notifyListeners();
  }

  Future<void> applyAttendData(
    TeacherClass teacherClass,
    DateTime currentDate,
  ) async {
    loadingAttendance = true;
    notifyListeners();
    for (var u in gradeUsers) {
      StudentModel user = u as StudentModel;

      AttendanceModel? attendanceModel =
          getAttendanceModelByUserId(userId: user.uid);
      if (attendanceModel?.id == null || attendanceModel == null) {
        AttendanceModel newModel = AttendanceModel(
          id: null,
          day: GlobalUtils.dateToString(currentDate),
          state: attendanceModel?.state ?? AttendanceState.absent,
          userId: user.uid,
          studentGrade: user.studentGrade,
          teacherClass: teacherClass,
        );
        String id = await _saveAttendModel(newModel);
        newModel.id = id;
        _addNewAttendState(newModel);
      } else {
        await _updateAttendanceModel(attendanceModel);
      }
    }
    loadingAttendance = false;
    notifyListeners();
  }
}
