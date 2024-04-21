// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, empty_catches, camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/Order_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

class final_prodcut_controller extends ChangeNotifier {
  get_finalProdcut_data(BuildContext context) {
    FirebaseDatabase.instance
        .ref("finalproducts")
        .orderByKey()
        .onValue
        .first
        .then((value) {
      getInitialData(value.snapshot, context);
    }).then((value) => FirebaseDatabase.instance
                .ref("finalproducts")
                .orderByKey()
                .startAfter("${finalproducts.last.finalProdcut_ID}")
                .onChildAdded
                .listen((f) async {
              await refrech(f);
            }));

    FirebaseDatabase.instance.ref("finalproducts").onChildChanged.listen((vv) {
      refrech(vv);
    });
  }

  c() {
    // if (all.isNotEmpty) {
    //   for (var element
    //       in all.where((element) => element.item.type.contains('سوفت'))) {
    //     element.item.type = "سوفت";
    //   }
    //   for (var element
    //       in all.where((element) => element.item.type.contains('هارد'))) {
    //     element.item.type = "هارد";
    //   }
    //   var s = {};
    //   s.addEntries(all.map(
    //       (el) => MapEntry("${el.finalProdcut_ID}", el.toJson().toString())));

    //   FirebaseDatabase.instance.ref("finalproducts").set(s);
    // }
  }

  getInitialData(DataSnapshot v, BuildContext context) async {
    all.clear();
    Archived_finalproducts.clear();
    finalproducts.clear();
    for (var item in v.children) {
      all.add(FinalProductModel.fromJson(item.value.toString()));
    }

    finalproducts.addAll(all.where((element) =>
        element.actions.if_action_exist(
            finalProdcutAction.archive_final_prodcut.getactionTitle) ==
        false));
    Archived_finalproducts.addAll(all.where((element) =>
        element.actions.if_action_exist(
            finalProdcutAction.archive_final_prodcut.getactionTitle) ==
        true));
    notifyListeners();
    context.read<OrderController>().Refrsh_ui();
  }

  refrech(DatabaseEvent vv) async {
    FinalProductModel newvalue =
        FinalProductModel.fromJson(vv.snapshot.value as String);

//--------------------------------------------------
    all.removeWhere(
        (element) => element.finalProdcut_ID == newvalue.finalProdcut_ID);
    all.add(newvalue);
//--------------------------------------------------

    finalproducts.removeWhere(
        (element) => element.finalProdcut_ID == newvalue.finalProdcut_ID);

    if (newvalue.actions.if_action_exist(
            finalProdcutAction.archive_final_prodcut.getactionTitle) ==
        false) {
      finalproducts.add(newvalue);
    } else {
      Archived_finalproducts.add(newvalue);
    }

    notifyListeners();
    print("refresh datata of finalprodcuts");
  }

  List<FinalProductModel> all = [];
  List<FinalProductModel> finalproducts = [];
  List<FinalProductModel> Archived_finalproducts = [];

  deletefinalProudut(FinalProductModel user) {
    user.actions.add(finalProdcutAction.archive_final_prodcut.add);
    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.finalProdcut_ID}")
          .set(user.toJson());
    } catch (e) {}
  }

  addinvoice(List<FinalProductModel> finalss, int invoiceNum) {
    for (var x in finalss) {
      x.invoiceNum = invoiceNum;
      x.actions.add(finalProdcutAction.createInvoice.add);
      try {
        FirebaseDatabase.instance
            .ref("finalproducts/${x.finalProdcut_ID}")
            .set(x.toJson());
      } catch (e) {}
    }
  }

  quality_done(FinalProductModel user) {
    user.actions.add(finalProdcutAction.final_prodcut_DidQalityCheck.add);

    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.finalProdcut_ID}")
          .set(user.toJson());
    } catch (e) {}
  }

  incert_finalProduct_from_cutingUnit(FinalProductModel user) {
    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.finalProdcut_ID}")
          .set(user.toJson());
    } catch (e) {}
  }

  incert_finalProduct_from_Others(FinalProductModel user) {
    user.actions.add(finalProdcutAction.incert_finalProduct_from_Others.add);
    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.finalProdcut_ID}")
          .set(user.toJson());
    } catch (e) {}
  }

  incert_finalProduct(FinalProductModel user) {
    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.finalProdcut_ID}")
          .set(user.toJson());
    } catch (e) {}
  }

  finalProdcut_out_order(FinalProductModel user) {
    user.actions.add(finalProdcutAction.out_order.add);
    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.finalProdcut_ID}")
          .set(user.toJson());
    } catch (e) {}
  }

  edit_cell(int id, String cell, String newvalue) {
    FinalProductModel user =
        finalproducts.where((element) => element.finalProdcut_ID == id).first;

    user.actions.add(ActionModel(
        action: "edit $cell",
        who: FirebaseAuth.instance.currentUser!.email ?? "",
        when: DateTime.now()));
    cell == "amount" ? user.item.amount = newvalue.to_int() : DoNothingAction();
    cell == "type" ? user.item.type = newvalue : DoNothingAction();
    cell == "density"
        ? user.item.density = newvalue.to_double()
        : DoNothingAction();
    cell == "color" ? user.item.color = newvalue : DoNothingAction();
    cell == "customer" ? user.customer = newvalue : DoNothingAction();
    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.finalProdcut_ID}")
          .set(user.toJson());
    } catch (e) {}
  }

  edit_cell_size(int id, String cell, List<String> newvalue) {
    FinalProductModel user =
        finalproducts.where((element) => element.finalProdcut_ID == id).first;

    user.actions.add(ActionModel(
        action: "edit $cell",
        who: FirebaseAuth.instance.currentUser!.email ?? "",
        when: DateTime.now()));
    user.item.L = newvalue[0].to_double();
    user.item.W = newvalue[1].to_double();
    user.item.H = newvalue[2].to_double();

    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.finalProdcut_ID}")
          .set(user.toJson());
    } catch (e) {}
  }

  recevied_from_finalPrdcut_stck(
    FinalProductModel user,
  ) {
    user.actions.add(finalProdcutAction.recive_Done_Form_FinalProdcutStock.add);
    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.finalProdcut_ID}")
          .set(user.toJson());
    } catch (e) {}
  }

  Refresh_Ui() {
    notifyListeners();
  }

  List<String> selctedcolors = [];
  List<String> selctedtybes = [];
  List<String> selctedDensities = [];
  List<String> selctedsizes = [];
  List<String> selctedcustomers = [];
  String? selectedreport;
  DateTime? pickedDateFrom;
  DateTime? pickedDateTo;
  List<DateTime> AllDatesOfOfData() {
    List<DateTime> a = finalproducts
        .where((e) => e.actions.if_action_exist(
            finalProdcutAction.incert_finalProduct_from_Others.getactionTitle))
        .map((e) => e.actions.get_Date_of_action(
            finalProdcutAction.incert_finalProduct_from_Others.getactionTitle))
        .toList();
    List<DateTime> b = finalproducts
        .where((e) => e.actions.if_action_exist(finalProdcutAction
            .incert_finalProduct_from_cutingUnit.getactionTitle))
        .map((e) => e.actions.get_Date_of_action(finalProdcutAction
            .incert_finalProduct_from_cutingUnit.getactionTitle))
        .toList();
    var v = a + b;
    return v.isEmpty ? [DateTime.now()] : v;
  }
}
