// ignore: non_constant_identifier_names
// ignore_for_file: avoid_print, argument_type_not_assignable_to_error_handler

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/controllers/users_controllers.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/setings/login.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

// ignore: non_constant_identifier_names

pickDateTimeRange(BuildContext context) {
  DateTimeRange(start: DateTime.now(), end: DateTime.now());
// ignore: unused_local_variable
  Future<DateTimeRange?> newDateRange = showDateRangePicker(
      context: context, firstDate: DateTime(200), lastDate: DateTime.now());
}

Future<void> permission() async {
  var status = await Permission.manageExternalStorage.status;
  if (!status.isGranted) {
    await Permission.manageExternalStorage.request();
  }
  var status1 = await Permission.storage.status;
  if (!status1.isGranted) {
    await Permission.storage.request();
  }
}

checkAuth(BuildContext context) {
  Connectivity().checkConnectivity().then((value) {
    if (value == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You\'re not connected to a network')));
    } else {
      try {
        if (FirebaseAuth.instance.currentUser != null) {
          try {
            FirebaseAuth.instance.currentUser!.reload();
          } catch (e) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (c) => const MyloginPage()),
                (f) => true);
          }
          FirebaseAuth.instance.currentUser!.reload().then((value) {});
          print("reload auth");
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (c) => const MyloginPage()),
              (f) => true);
        }
      } catch (e) {
        print("fail auth");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (c) => const MyloginPage()),
            (f) => true);
      }
    }
  });
}

List<DateTime> getDaysInBeteween(DateTime startDate, DateTime endDate) {
  List<DateTime> days = [];
  for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
    days.add(DateTime(
        startDate.year,
        startDate.month,
        // In Dart you can set more than. 30 days, DateTime will do the trick
        startDate.day + i));
  }
  return days;
}

bool permitionss(BuildContext context, UserPermition permition) {
  List<Users> users = context
      .read<Users_controller>()
      .users
      .where((element) =>
          element.uidemail == FirebaseAuth.instance.currentUser!.email)
      .toList();
  if (users.isNotEmpty) {
    return users.first.permitions
            .map((e) => e.tittle)
            .contains(permition.getTitle) ||
        users.first.permitions.map((e) => e.tittle).contains("show_all");
  } else {
    return false;
  }
}
bool permitionssForOne(BuildContext context, UserPermition permition) {
  List<Users> users = context.read<Users_controller>().users.where((element) =>element.uidemail == FirebaseAuth.instance.currentUser!.email)
      .toList();
  if (users.isNotEmpty) {
    return users.first.permitions
            .map((e) => e.tittle)
            .contains(permition.getTitle) ;
  } else {
    return false;
  }
}
