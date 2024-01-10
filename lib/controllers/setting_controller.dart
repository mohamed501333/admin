// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:provider/provider.dart';

class SettingController extends ChangeNotifier {
  int currentday = 0;
  increaseDay() {
    currentday++;
    notifyListeners();
  }

  decreaseDay() {
    currentday--;
    notifyListeners();
  }

  String currentDate() {
    return DateFormat('yyyy/MM/dd')
        .format(DateTime.now().subtract(Duration(days: currentday)));
  }

  bool valueOfRadio1 = false;
  bool valueOfRadio11() {
    return valueOfRadio1;
  }

  changevalueOfRadio11(v) {
    valueOfRadio1 = v;
    notifyListeners();
  }

  bool valueOfRadio2 = false;
  bool valueOfRadio22() {
    return valueOfRadio2;
  }

  changevalueOfRadio22(v) {
    valueOfRadio2 = v;
    number = 1;
    notifyListeners();
  }

  int number = 1;
  inceasenumber() {
    number++;
    notifyListeners();
  }

  int s = 5;
  inrcreas_s(BuildContext context) {
    s++;
    notifyListeners();
    context.read<BlockFirebasecontroller>().Refresh_the_UI();
  }

  decreas_s(BuildContext context) {
    s--;
    notifyListeners();
    context.read<BlockFirebasecontroller>().Refresh_the_UI();
  }
}
