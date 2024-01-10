import 'package:flutter/material.dart';

class MainController extends ChangeNotifier {
  int currentIndex = 3;

  changecurrenIndexogbuttonNav(val) {
    currentIndex = val;
    notifyListeners();
  }
}
