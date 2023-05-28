import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_evaluation/models/behavior_model.dart';
import 'package:student_evaluation/student_app/models/behaviour_month_model.dart';

import '../../models/user_model.dart';
import '../../transformers/collections.dart';
import '../../transformers/models_fields.dart';

class StudentBehaviourProvider extends ChangeNotifier {
  List<BehaviourModel> behaveData = [];
  final List<BehaviourMonthModel> _months = [];
  List<BehaviourMonthModel> get months => [..._months.reversed];

  TeacherClass activeClass = TeacherClass.arabic;

  void setActiveClass(TeacherClass g) {
    activeClass = g;
    notifyListeners();
  }

  var loading = false;

  Future<void> loadBehaveData(StudentModel studentModel) async {
    try {
      behaveData.clear();
      loading = true;
      notifyListeners();
      var docs = (await FirebaseFirestore.instance
              .collection(DBCollections.behavior)
              .where(ModelsFields.userId, isEqualTo: studentModel.uid)
              .where(ModelsFields.teacherClass, isEqualTo: activeClass.name)
              .get())
          .docs;
      for (var doc in docs) {
        var model = BehaviourModel.fromJSON(doc.data());
        behaveData.add(model);
      }
      _calcBehave();
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      rethrow;
    }
  }

  void _calcBehave() {
    // to calculate how many stars i need to calc a percentage
    // active to be 1
    // normal to be .6
    // worry to be .4

    _months.clear();
    var copiedData = [...behaveData];
    var nullModel = BehaviourModel(
      id: 'id',
      day: DateFormat('yyy-MM-dd').format(DateTime(1900)),
      state: BehaviorState.active,
      userId: 'userId',
      studentGrade: StudentGrade.k1SectionA,
      teacherClass: TeacherClass.arabic,
    );

    copiedData.sort((a, b) => a.day.compareTo(b.day));
    copiedData.add(nullModel);
    DateFormat dateFormat = DateFormat('yyy-MM-dd');
    String currentMonth = BehaviourMonthModel.dateConvert(
      dateFormat.parse(
        copiedData.first.day,
      ),
    );

    List<double> statesMap = [];

    for (var data in copiedData) {
      String month = BehaviourMonthModel.dateConvert(
        dateFormat.parse(
          data.day,
        ),
      );
      if (month != currentMonth) {
        // here create a new month model  and add it to the list
        // then clean the counters
        double avg = _stateAvg(statesMap);
        BehaviourMonthModel model = BehaviourMonthModel(
          month: currentMonth,
          avg: avg,
        );
        _months.add(model);
        currentMonth = month;
        statesMap.clear();
      }
      // here just increment counter
      double stateMap = _stateBehaveMap(data.state);
      statesMap.add(stateMap);
    }
    notifyListeners();
  }

  double _stateBehaveMap(BehaviorState state) {
    if (state == BehaviorState.active) {
      return 1;
    } else if (state == BehaviorState.normal) {
      return .6;
    } else {
      return .4;
    }
  }

  double _stateAvg(List<double> states) {
    return states.fold(
            0.0, (previousValue, element) => previousValue + element) /
        states.length;
  }
}
