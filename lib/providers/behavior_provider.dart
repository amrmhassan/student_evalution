// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/models/behavior_model.dart';
import 'package:student_evaluation/models/user_model.dart';
import 'package:student_evaluation/transformers/collections.dart';
import 'package:student_evaluation/transformers/models_fields.dart';
import 'package:student_evaluation/utils/global_utils.dart';

class BehaviorProvider extends ChangeNotifier {
  bool loadingBehaviour = false;
  StudentGrade activeGrade = StudentGrade.k1SectionA;

  void setActiveGrade(StudentGrade g) {
    activeGrade = g;
    notifyListeners();
  }

  List<UserModel> gradeUsers = [];
  List<BehaviourModel> behaviourData = [];

  Future<void> loadBehaviourData(
    TeacherClass currentTeacherClass,
    DateTime dateTime,
  ) async {
    behaviourData.clear();
    gradeUsers.clear();
    loadingBehaviour = true;
    notifyListeners();

    await _loadUserGrades();
    var docs = (await FirebaseFirestore.instance
            .collection(DBCollections.behavior)
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
    for (var behaviourMap in docs) {
      BehaviourModel model = BehaviourModel.fromJSON(behaviourMap.data());
      behaviourData.add(model);
    }
    loadingBehaviour = false;
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

  BehaviourModel? getBehaviourModelByUserId({
    required String userId,
  }) {
    try {
      return behaviourData.firstWhere((element) => element.userId == userId);
    } catch (e) {
      return null;
    }
  }

  BehaviourModel? getBehaviourModelByModelId({
    required String modelId,
  }) {
    try {
      return behaviourData.firstWhere((element) => element.id == modelId);
    } catch (e) {
      return null;
    }
  }

  void changeBehaviourState({
    required BehaviorState state,
    required String userId,
    required StudentGrade studentGrade,
    required TeacherClass teacherClass,
    required DateTime currentDate,
  }) {
    BehaviourModel? behaveModel = getBehaviourModelByUserId(userId: userId);
    if (behaveModel == null) {
      BehaviourModel newModel = BehaviourModel(
        id: null,
        day: GlobalUtils.dateToString(currentDate),
        state: state,
        userId: userId,
        studentGrade: studentGrade,
        teacherClass: teacherClass,
      );
      _addNewBehaveState(newModel);
    } else {
      behaveModel.state = state;
      _updateBehaveState(behaveModel);
    }
  }

  Future<String> _saveBehaveModel(BehaviourModel model) async {
    var res = await FirebaseFirestore.instance
        .collection(DBCollections.behavior)
        .add(model.toJSON());
    model.id = res.id;
    await FirebaseFirestore.instance
        .collection(DBCollections.behavior)
        .doc(res.id)
        .set(model.toJSON());
    return res.id;
  }

  Future<void> _updateBehaviourModel(BehaviourModel model) async {
    await FirebaseFirestore.instance
        .collection(DBCollections.behavior)
        .doc(model.id!)
        .set(model.toJSON());
  }

  void _updateBehaveState(BehaviourModel model) {
    int index = behaviourData.indexWhere((element) => element.id == model.id);
    behaviourData[index] = model;
    notifyListeners();
  }

  void _addNewBehaveState(BehaviourModel model) {
    bool exist = behaviourData.any((element) => element.userId == model.userId);
    if (exist) {
      int index =
          behaviourData.indexWhere((element) => element.userId == model.userId);
      behaviourData[index] = model;
    } else {
      behaviourData.add(model);
    }
    notifyListeners();
  }

  Future<void> applyBehaveData(
    TeacherClass teacherClass,
    DateTime currentDate,
  ) async {
    loadingBehaviour = true;
    notifyListeners();
    for (var u in gradeUsers) {
      StudentModel user = u as StudentModel;

      BehaviourModel? behaviourModel =
          getBehaviourModelByUserId(userId: user.uid);
      if (behaviourModel?.id == null || behaviourModel == null) {
        BehaviourModel newModel = BehaviourModel(
          id: null,
          day: GlobalUtils.dateToString(currentDate),
          state: behaviourModel?.state ?? BehaviorState.active,
          userId: user.uid,
          studentGrade: user.studentGrade,
          teacherClass: teacherClass,
        );
        String id = await _saveBehaveModel(newModel);
        newModel.id = id;
        _addNewBehaveState(newModel);
      } else {
        await _updateBehaviourModel(behaviourModel);
      }
    }
    loadingBehaviour = false;
    notifyListeners();
  }
}
