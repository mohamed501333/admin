// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, camel_case_types, empty_catches

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/models/moderls.dart';

class Invoice_controller extends ChangeNotifier {
  get_invice_data() {
    try {
      FirebaseDatabase.instance
          .ref("invoice")
          .orderByKey()
          .onValue
          .listen((event) {
        invoices.clear();
        if (event.snapshot.value != null) {
          Map<Object?, Object?> map =
              event.snapshot.value as Map<Object?, Object?>;
          for (var item in map.values.toList()) {
            invoices.add(Invoice.fromJson(item.toString()));
            edits = invoices;
          }
        }
        print("get data of invoice");
        notifyListeners();
      });
    } catch (e) {}
  }

  List<Invoice> invoices = [];
  List<Invoice> edits = [];
  int x = 0;

  // rr() async {
  //   print("v");
  //   for (var t in edits.sortedBy<num>((element) => element.id)) {
  //     x++;
  //     print("++");

  //     var n = Invoice(
  //         id: t.id,
  //         number: 2061 + t.number,
  //         date: t.date,
  //         driverName: t.driverName,
  //         carNumber: t.carNumber,
  //         makeLoad: t.makeLoad,
  //         notes: t.notes,
  //         biscole: t.biscole,
  //         actions: t.actions,
  //         items: t.items
  //         // .map((e) => InvoiceItem(
  //         //     lenth: e.lenth,
  //         //     width: e.width,
  //         //     hight: e.hight,
  //         //     wight: e.wight,
  //         //     color: e.color,
  //         //     density: e.density,
  //         //     price: e.price,
  //         //     customer: e.customer,
  //         //     amount: e.amount)
  //         //     )
  //         // .toList()
  //         );

  //     await FirebaseDatabase.instance.ref("invoice/${n.id}").set(n.toJson());
  //   }
  // }

  addInvoice(Invoice invoice) async {
    try {
      await FirebaseDatabase.instance
          .ref("invoice/${invoice.id}")
          .set(invoice.toJson())
          .then((value) {});
    } catch (e) {}
  }
}
