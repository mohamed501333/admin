// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, camel_case_types, empty_catches

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/data/sharedprefs.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/recources/publicVariables.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class Customer_controller extends ChangeNotifier {
  List<CustomerModel> customers = [];
  List<CustomerModel> initalData = [];
  static late WebSocketChannel channel;

  getData() {
    if (internet == true) {
      customers_From_firebase();
    } else {
      customers_From_Server();
    }
  }

  customers_From_firebase() {
    // print('get custorerms firvase');
    // Firestore.instance.collection('customers').get().then((val) {
    //   customers.clear();

    //   for (var element in val) {
    //     var customer = CustomerModel.fromMap(element.map);
    //     if (customer.actions
    //             .if_action_exist(customerAction.archive_customer.getTitle) ==
    //         false) {
    //       customers.add(customer);
    //     }
    //   }
  
    // });
  }

  customers_From_Server() async {
    // get for the first time
    Uri uri = Uri.http('$ip:8080', '/customers');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      customers.clear();
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var customer = CustomerModel.fromMap(element);
        if (customer.actions
                .if_action_exist(BlockAction.archive_block.getactionTitle) ==
            false) {
          customers.add(customer);
        }
      }
      notifyListeners();
    }
    //
    Uri uri2 = Uri.parse('ws://$ip:8080/customers/ws').replace(
        queryParameters: {
          'username': Sharedprfs.getemail(),
          'password': Sharedprfs.getpassword()
        });
    channel = WebSocketChannel.connect(uri2);
    channel.stream.forEach((u) {
      CustomerModel customer = CustomerModel.fromJson(u);
      var index = customers
          .map((e) => e.customer_id)
          .toList()
          .indexOf(customer.customer_id);
      if (customer.actions
              .if_action_exist(customerAction.archive_customer.getTitle) ==
          false) {
        if (index == -1) {
          customers.add(customer);
        } else {
          customers.removeAt(index);
          customers.add(customer);
        }
      }
      notifyListeners();
    });
  }

  Add_new_customer(CustomerModel customer) {
    if (internet == true) {
      FirebaseFirestore.instance
          .collection('customers')
          .doc(customer.customer_id.toString())
          .set(customer.toMap());
    } else {
      channel.sink.add(customer.toJson());
    }
  }

  String? initialForRaido;
  // String? initialForcustomer;
  Refrsh_ui() {
    notifyListeners();
  }
}
