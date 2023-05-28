import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:student_evaluation/models/home_work_model.dart';
import 'package:student_evaluation/transformers/collections.dart';

import '../models/user_model.dart';
import '../utils/providers_calls.dart';

class NotificationProvider extends ChangeNotifier {
  List<HomeWorkModel> homeWorks = [];
  List<HomeWorkModel> watchedHomeWorks = [];
  List<HomeWorkModel> get unwatchedHomeworks => homeWorks
      .where(
        (element) => !watchedHomeWorks
            .any((watchedElement) => element.id == watchedElement.id),
      )
      .toList();
  bool loadingWatchedHomeworks = false;

  Future<void> loadWatchedHomeWorks(String userID) async {
    watchedHomeWorks.clear();
    loadingWatchedHomeworks = true;
    notifyListeners();
    var res = await FirebaseDatabase.instance
        .ref(DBCollections.users)
        .child(userID)
        .child(DBCollections.watchedHomeWorks)
        .get();
    for (var doc in res.children) {
      var test = (doc.value as Map<dynamic, dynamic>);

      Map<String, dynamic> data = {};
      test.forEach((key, value) {
        data[key.toString()] = value;
      });
      HomeWorkModel homeWorkModel = HomeWorkModel.fromJSON(data);
      watchedHomeWorks.add(homeWorkModel);
    }
    loadingWatchedHomeworks = true;
    notifyListeners();
  }

  void addToHomeWorks(HomeWorkModel homeWorkModel) {
    if (homeWorks.any((element) => element.id == homeWorkModel.id)) return;
    homeWorks.add(homeWorkModel);
    notifyListeners();
  }

  void clearNotifications() {
    homeWorks.clear();
    notifyListeners();
  }

  void listenToHomeWorks(BuildContext context) {
    Future.delayed(Duration.zero).then((value) {
      clearNotifications();
      StudentModel studentModel =
          Providers.userPf(context).userModel! as StudentModel;
      FirebaseDatabase.instance
          .ref(DBCollections.homeWorks)
          .child(studentModel.studentGrade.name)
          .onValue
          .listen((event) {
        for (var doc in event.snapshot.children) {
          var test = (doc.value as Map<dynamic, dynamic>);

          Map<String, dynamic> data = {};
          test.forEach((key, value) {
            data[key.toString()] = value;
          });
          HomeWorkModel homeWorkModel = HomeWorkModel.fromJSON(data);

          addToHomeWorks(homeWorkModel);
        }
      });
    });
  }

  void watchAllNotifications(String userId) async {
    for (var element in unwatchedHomeworks) {
      await FirebaseDatabase.instance
          .ref(DBCollections.users)
          .child(userId)
          .child(DBCollections.watchedHomeWorks)
          .child(element.id!)
          .set(element.toJSON());
    }
    watchedHomeWorks = [...homeWorks];
    notifyListeners();
  }
}
