import 'package:flutter/material.dart';

class MainController extends ChangeNotifier {
  int currentIndex = 2;

  changecurrenIndexogbuttonNav(val) {
    currentIndex = val;
    notifyListeners();
  }
}
