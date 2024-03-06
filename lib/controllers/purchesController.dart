// ignore_for_file: file_names, non_constant_identifier_names, empty_catches, avoid_function_literals_in_foreach_calls

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/models/moderls.dart';

class PurchesController extends ChangeNotifier {
  getDataOfPurches() {
    try {
      FirebaseDatabase.instance
          .ref("Purche")
          .orderByKey()
          .onValue
          .listen((event) {
        purchesOrders.clear();
        initalData.clear();
        if (event.snapshot.value != null) {
          Map<Object?, Object?> map =
              event.snapshot.value as Map<Object?, Object?>;
          for (var item in map.values.toList()) {
            initalData.add(PurcheOrder.fromJson(item.toString()));
          }
          purchesOrders.addAll(initalData);
        }

        notifyListeners();
      });
    } catch (e) {}
  }

  List<PurcheOrder> purchesOrders = [];
  List<PurcheOrder> initalData = [];

  Add_purche_item(PurcheOrder purcheOrder) async {
    try {
      FirebaseDatabase.instance
          .ref("Purche/${purcheOrder.Id}")
          .set(purcheOrder.toJson());
    } catch (e) {}
  }

  Refrech_UI() {
    notifyListeners();
  }
}
