// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/Order_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

class final_prodcut_controller extends ChangeNotifier {
  get_finalProdcut_data(BuildContext context) {
    try {
      FirebaseDatabase.instance
          .ref("finalproducts")
          .orderByKey()
          .onValue
          .listen((event) {
        print("get final product");
        finalproducts.clear();
        initalData.clear();
        if (event.snapshot.value != null) {
          Map<Object?, Object?> map =
              event.snapshot.value as Map<Object?, Object?>;
          for (var item in map.values.toList()) {
            initalData.add(FinalProductModel.fromJson(item.toString()));
          }
          finalproducts.addAll(initalData.where((element) =>
              element.actions.if_action_exist(
                  finalProdcutAction.archive_final_prodcut.getactionTitle) ==
              false));
        }

        notifyListeners();
        context.read<OrderController>().Refrsh_ui();
      });
    } catch (e) {
      print(e);
      print("erorr on get finalprodcuts");
    }
  }

  List<FinalProductModel> finalproducts = [];
  List<FinalProductModel> initalData = [];

  deletefinalProudut(FinalProductModel user) {
    user.actions.add(finalProdcutAction.archive_final_prodcut.add);
    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.id}")
          .set(user.toJson());
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  addinvoice(List<FinalProductModel> finalss) {
    for (var x in finalss) {
      x.actions.add(finalProdcutAction.createInvoice.add);
      try {
        FirebaseDatabase.instance.ref("finalproducts/${x.id}").set(x.toJson());
        notifyListeners();

        print("erorr on get cu");
      } catch (e) {
        print(e);
      }
    }
  }

  quality_done(FinalProductModel user) {
    user.actions.add(finalProdcutAction.final_prodcut_DidQalityCheck.add);

    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.id}")
          .set(user.toJson());
      notifyListeners();

      print("erorr on get cu");
    } catch (e) {
      print(e);
    }
  }

  incert_finalProduct_from_cutingUnit(FinalProductModel user) {
    user.actions
        .add(finalProdcutAction.incert_finalProduct_from_cutingUnit.add);
    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.id}")
          .set(user.toJson());
      notifyListeners();

      print("erorr on get cu");
    } catch (e) {
      print(e);
    }
  }

  incert_finalProduct_from_Others(FinalProductModel user) {
    user.actions.add(finalProdcutAction.incert_finalProduct_from_Others.add);
    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.id}")
          .set(user.toJson());
      notifyListeners();

      print("erorr on get cu");
    } catch (e) {
      print(e);
    }
  }

  finalProdcut_out_order(FinalProductModel user) {
    user.actions.add(finalProdcutAction.out_order.add);
    try {
      FirebaseDatabase.instance
          .ref("finalproducts/${user.id}")
          .set(user.toJson());
      notifyListeners();

      print("erorr on get cu");
    } catch (e) {
      print(e);
    }
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

      print("erorr on get cu");
    } catch (e) {
      print(e);
    }
  }
}
