import 'package:flutter/material.dart';

class TimeLineProvider extends ChangeNotifier {
  DateTime get nowDate => DateTime.now();
  late DateTime currentDay = DateTime(nowDate.year, nowDate.month, nowDate.day);
  void setCurrentDay(DateTime dateTime) {
    currentDay = dateTime;
    notifyListeners();
  }
}
