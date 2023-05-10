import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  int _activeNavBarIndex = 0;
  int get activeNavBarIndex => _activeNavBarIndex;
  void setActiveNavBar(int i) {
    _activeNavBarIndex = i;
    notifyListeners();
  }

  void resetNavBar() {
    _activeNavBarIndex = 0;
    notifyListeners();
  }
}
