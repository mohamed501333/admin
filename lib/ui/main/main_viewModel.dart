// ignore_for_file: avoid_unnecessary_containers, file_names

import 'package:flutter/material.dart';
import 'package:jason_company/ui/home/home_view.dart';
import 'package:jason_company/ui/reports/reports_view.dart';
import 'package:jason_company/ui/scissors/scissors_view.dart';

import '../../setings/Setings.dart';

class MainViewModel {
  List<Widget> screens = [
    Setings(),
    ReportsView(),
    ScissorsView(),
    const HomeView(),
  ];

  indexOfAppBar(int indexOgNavButton, int indexOfRadioButton) {
    if (indexOgNavButton == 2) {
      return appBarStrings[2][indexOfRadioButton];
    } else {
      return appBarStrings[indexOgNavButton];
    }
  }

  List appBarStrings = [
    "الاعدادات",
    "التقارير",
    [
      "مقص راسى1",
      "مقص راسى 2",
      "مقص راسى 3",
      "مقص دائرى 1",
      "مقص دائرى 2",
      "مقص دائرى 3",
      "مقص ترددى"
    ],
    "janssen foam"
  ];
}
