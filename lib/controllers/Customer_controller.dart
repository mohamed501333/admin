// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';

class Customer_controller extends ChangeNotifier {
  get_Customers_data() {
    try {
      FirebaseDatabase.instance
          .ref("customers")
          .orderByKey()
          .onValue
          .listen((event) {
        customers.clear();
        initalData.clear();
        if (event.snapshot.value != null) {
          Map<Object?, Object?> map =
              event.snapshot.value as Map<Object?, Object?>;
          for (var item in map.values.toList()) {
            initalData.add(CustomerModel.fromJson(item.toString()));
          }
          customers.addAll(initalData.where((element) =>
              element.actions
                  .if_action_exist(customerAction.archive_customer.getTitle) ==
              false));
        }

        notifyListeners();
      });
    } catch (e) {}
  }

  List<CustomerModel> customers = [];
  List<CustomerModel> initalData = [];

  Add_new_customer(CustomerModel customer) {
    customer.actions.add(customerAction.create_new_customer.add);
    try {
      FirebaseDatabase.instance
          .ref("customers/${customer.id}")
          .set(customer.toJson());
      notifyListeners();
    } catch (e) {}
  }

  int? initialForRaido;
  Refrsh_ui() {
    notifyListeners();
  }
}
