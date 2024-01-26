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
    print("get data");

    try {
      FirebaseDatabase.instance
          .ref("finalproducts")
          .orderByKey()
          .onValue
          .listen((event) {
        finalproducts.clear();
        initalData.clear();
        isfinal_false.clear();
        if (event.snapshot.value != null) {
          Map<Object?, Object?> map =
              event.snapshot.value as Map<Object?, Object?>;
          for (var item in map.values.toList()) {
            initalData.add(FinalProductModel.fromJson(item.toString()));
          }
          finalproducts.addAll(initalData.where((element) =>
              element.actions.if_action_exist(finalProdcutAction
                      .archive_final_prodcut.getactionTitle) ==
                  false &&
              element.isfinal == true));
          //
          isfinal_false.addAll(initalData.where((element) =>
              element.actions.if_action_exist(finalProdcutAction
                      .archive_final_prodcut.getactionTitle) ==
                  false &&
              element.isfinal == false));
        }
        print("get data of final prodctu");

        notifyListeners();
        context.read<OrderController>().Refrsh_ui();
      });
    } catch (e) {}
  }

  // c() {
  //   print("5555555");
  //   for (var el in finalproducts.where((element) => element.amount < 0)) {
  //     el.actions.removeWhere(
  //         (element) => element.action == "recive_Done_Form_FinalProdcutStock");

  //     FirebaseDatabase.instance.ref("finalproducts/${el.id}").set(el.toJson());
  //   }
  // }

  // cd() {
  //   print("5555555");
  //   for (var el in finalproducts) {
  //     while (el.actions
  //             .where((element) => element.action == "createInvoice")
  //             .toList()
  //             .length >=
  //         2) {
  //       el.actions.removeWhere((element) => element.action == "createInvoice");
  //     }

  //     FirebaseDatabase.instance.ref("finalproducts/${el.id}").set(el.toJson());
  //   }
  // }

  List<FinalProductModel> finalproducts = [];
  List<FinalProductModel> search = [];
  List<FinalProductModel> initalData = [];
  List<FinalProductModel> isfinal_false = [];
  List<FinalProductModel> SumTheTOw() => isfinal_false + finalproducts;

  deletefinalProudut(FinalProductModel user) {
    user.actions.add(finalProdcutAction.archive_final_prodcut.add);
    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.id}")
          .set(user.toJson());
      notifyListeners();
    } catch (e) {}
  }

  addinvoice(List<FinalProductModel> finalss, int invoiceNum) {
    for (var x in finalss) {
      x.invoiceNum = invoiceNum;
      x.actions.add(finalProdcutAction.createInvoice.add);
      try {
        FirebaseDatabase.instance.ref("finalproducts/${x.id}").set(x.toJson());
      } catch (e) {}
      notifyListeners();
    }
  }

  quality_done(FinalProductModel user) {
    user.actions.add(finalProdcutAction.final_prodcut_DidQalityCheck.add);

    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.id}")
          .set(user.toJson());
      notifyListeners();
    } catch (e) {}
  }

  incert_finalProduct_from_cutingUnit(FinalProductModel user) {
    user.actions
        .add(finalProdcutAction.incert_finalProduct_from_cutingUnit.add);
    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.id}")
          .set(user.toJson());
      notifyListeners();
    } catch (e) {}
  }

  incert_finalProduct_from_Others(FinalProductModel user) {
    user.actions.add(finalProdcutAction.incert_finalProduct_from_Others.add);
    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.id}")
          .set(user.toJson());
      notifyListeners();
    } catch (e) {}
  }

  finalProdcut_out_order(FinalProductModel user) {
    user.actions.add(finalProdcutAction.out_order.add);
    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.id}")
          .set(user.toJson());
      notifyListeners();
    } catch (e) {}
  }

  edit_cell(int id, String cell, String newvalue) {
    FinalProductModel user =
        finalproducts.where((element) => element.id == id).first;

    user.actions.add(ActionModel(
        action: "edit $cell",
        who: FirebaseAuth.instance.currentUser!.email ?? "",
        when: DateTime.now()));
    cell == "amount" ? user.amount = newvalue.to_int() : DoNothingAction();
    cell == "type" ? user.type = newvalue : DoNothingAction();
    cell == "density" ? user.density = newvalue.to_double() : DoNothingAction();
    cell == "color" ? user.color = newvalue : DoNothingAction();
    cell == "customer" ? user.customer = newvalue : DoNothingAction();
    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.id}")
          .set(user.toJson());
    } catch (e) {}
  }

  edit_cell_size(int id, String cell, List<String> newvalue) {
    FinalProductModel user =
        finalproducts.where((element) => element.id == id).first;

    user.actions.add(ActionModel(
        action: "edit $cell",
        who: FirebaseAuth.instance.currentUser!.email ?? "",
        when: DateTime.now()));
    user.lenth = newvalue[0].to_double();
    user.width = newvalue[1].to_double();
    user.hight = newvalue[2].to_double();

    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.id}")
          .set(user.toJson());
    } catch (e) {}
  }

  recevied_from_finalPrdcut_stck(
    FinalProductModel user,
  ) {
    user.actions.add(finalProdcutAction.recive_Done_Form_FinalProdcutStock.add);
    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.id}")
          .set(user.toJson());
      notifyListeners();
    } catch (e) {}
  }

  Refresh_Ui() {
    notifyListeners();
  }
}
