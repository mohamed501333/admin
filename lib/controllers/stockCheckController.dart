// ignore_for_file: non_constant_identifier_names, empty_catches, file_names, camel_case_types

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';

class StokCheck_Controller extends ChangeNotifier {
  get_StokCheck_data() async {
    await FirebaseDatabase.instance
        .ref("FstockCheck")
        .onValue
        .listen((value) async {
      await getInitialData(value.snapshot);
    });

    // FirebaseDatabase.instance.ref("fractions").onValue.listen((event) {
    //   refrech(event);
    // });
  }

  getInitialData(DataSnapshot v) async {
    all.clear();
    archived_stockChecks.clear();
    stockChecks.clear();
    for (var item in v.children) {
      all.add(StockCheckModel.fromJson(item.value.toString()));
    }

    stockChecks.addAll(all.where((element) =>
        element.actions
            .if_action_exist(StockCheckAction.archive_StockCheck.getTitle) ==
        false));
    archived_stockChecks.addAll(all.where((element) =>
        element.actions
            .if_action_exist(StockCheckAction.archive_StockCheck.getTitle) ==
        true));
    notifyListeners();
    if (kDebugMode) {
      print("get initial data of stockChecks");
    }
  }

  refrech(DatabaseEvent vv) async {
    StockCheckModel newvalue =
        StockCheckModel.fromJson(vv.snapshot.children.last.value as String);
    print(newvalue.stockCheck_ID);
//--------------------------------------------------
    all.removeWhere(
        (element) => element.stockCheck_ID == newvalue.stockCheck_ID);
    all.add(newvalue);
//--------------------------------------------------

    stockChecks.removeWhere(
        (element) => element.stockCheck_ID == newvalue.stockCheck_ID);

    if (newvalue.actions
            .if_action_exist(StockCheckAction.archive_StockCheck.getTitle) ==
        false) {
      stockChecks.add(newvalue);
    } else {
      archived_stockChecks.add(newvalue);
    }

    notifyListeners();
    print("refrech datata of stockChecks");
  }

  List<StockCheckModel> all = [];
  List<StockCheckModel> stockChecks = [];
  List<StockCheckModel> archived_stockChecks = [];

  Refresh_the_UI() {
    notifyListeners();
  }

  addNewStockCheck(StockCheckModel stockCheck) async {
    await FirebaseDatabase.instance
        .ref("FstockCheck/${stockCheck.stockCheck_ID}")
        .set(stockCheck.toJson());
  }

  deleteStockCheck(StockCheckModel stockCheck) {
    stockCheck.actions.add(StockCheckAction.archive_StockCheck.add);
    FirebaseDatabase.instance
        .ref("FstockCheck/${stockCheck.stockCheck_ID}")
        .set(stockCheck.toJson());
  }

  MakeRefreshOfData(StockCheckModel stockCheck) {
    stockCheck.actions.add(StockCheckAction.refrechDone.add);
    FirebaseDatabase.instance
        .ref("FstockCheck/${stockCheck.stockCheck_ID}")
        .set(stockCheck.toJson());
  }

  undeleteFraction(StockCheckModel stockCheck) {
    int index = stockCheck.actions.indexWhere((element) =>
        element.action == StockCheckAction.archive_StockCheck.getTitle);
    stockCheck.actions.removeAt(index);
    FirebaseDatabase.instance
        .ref("FstockCheck/${stockCheck.stockCheck_ID}")
        .set(stockCheck.toJson());
    notifyListeners();
  }

  String? selectedreport;
  DateTime? pickedDateFrom;
  DateTime? pickedDateTo;
  List<DateTime> AllDatesOfOfData() {
    List<DateTime> v = stockChecks
        .where((e) => e.actions
            .if_action_exist(StockCheckAction.creat_new_StockCheck.getTitle))
        .map((e) => e.actions
            .get_Date_of_action(StockCheckAction.creat_new_StockCheck.getTitle))
        .toList();
    return v.isEmpty ? [DateTime(2101)] : v;
  }
}
