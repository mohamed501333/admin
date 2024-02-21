// ignore_for_file: avoid_unnecessary_containers, file_names

import 'package:flutter/material.dart';
import 'package:jason_company/ui/home/home_view.dart';
import 'package:jason_company/ui/reports/reports_view.dart';

import '../../setings/Setings.dart';

class MainViewModel {
  List<Widget> screens = [
    Setings(),
    ReportsView(),
    const HomeView(),
  ];

  indexOfAppBar(int indexOgNavButton, int indexOfRadioButton) {
    return appBarStrings[indexOgNavButton];
  }

  List appBarStrings = ["الاعدادات", "التقارير", "janssen foam"];
}
