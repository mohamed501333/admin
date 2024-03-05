// ignore_for_file: file_names, non_constant_identifier_names, empty_catches, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/models/moderls.dart';

class PurchesController extends ChangeNotifier {
  getDataOfPurches() {
    try {
      FirebaseFirestore.instance
          .collection('Purche')
          .orderBy("id")
          .snapshots()
          .listen((event) {
        purchesOrders.clear();
        purchesOrders.addAll(
            event.docs.map((doc) => PurcheOrder.fromMap(doc.data())).toList());
        notifyListeners();
      });
    } catch (e) {}
  }

  List<PurcheOrder> purchesOrders = [];

  Add_purche_item(PurcheOrder purcheOrder) async {
    try {
      await FirebaseFirestore.instance
          .collection('Purche')
          .add(purcheOrder.toMap());
    } catch (e) {}
  }

  Refrech_UI() {
    notifyListeners();
  }

  delete_not_FInals(id) {
    try {
      FirebaseFirestore.instance
          .collection('Purche')
          .where('id', isEqualTo: id)
          .get()
          .then((value) => value.docs.forEach((element) {
                element.reference.delete();
              }));
    } catch (e) {}
  }
}
