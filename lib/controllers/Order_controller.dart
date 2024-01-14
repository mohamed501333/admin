// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, empty_catches

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/models/moderls.dart';

import 'package:jason_company/ui/recources/enums.dart';

class OrderController extends ChangeNotifier {
  get_Order_data() {
    try {
      FirebaseDatabase.instance
          .ref("orders")
          .orderByKey()
          .onValue
          .listen((event) {
        orders.clear();
        initalData.clear();
        if (event.snapshot.value != null) {
          Map<Object?, Object?> map =
              event.snapshot.value as Map<Object?, Object?>;
          for (var item in map.values.toList()) {
            initalData.add(OrderModel.fromJson(item.toString()));
          }
          orders.addAll(initalData.where((element) =>
              element.actions
                  .if_action_exist(OrderAction.Archive_order.getTitle) ==
              false));
        }

        notifyListeners();
      });
    } catch (e) {}
  }

  // gggg() {
  //   for (var el in orders) {
  //     OrderModel e = OrderModel(
  //       id: el.id,
  //       notes: "",
  //       serial: el.serial,
  //       datecreated: el.datecreated,
  //       dateTOOrder: el.dateTOOrder,
  //       customer: el.customer,
  //       actions: el.actions,
  //       items: el.items,
  //     );

  //     FirebaseDatabase.instance.ref("orders/${el.id}").set(e.toJson());
  //   }
  // }

  List<OrderModel> orders = [];
  List<OrderModel> initalData = [];

  add_order(OrderModel order) {
    order.actions.add(OrderAction.create_order.add);
    try {
      FirebaseDatabase.instance.ref("orders/${order.id}").set(order.toJson());
      notifyListeners();
    } catch (e) {}
  }

  addAction(OrderModel item, OrderAction action) {
    item.actions.add(action.add);
    try {
      FirebaseDatabase.instance.ref("orders/${item.id}").set(item.toJson());
      notifyListeners();
    } catch (e) {}
  }

  // chosen order serial
  OrderModel? initionalForRadio_order_Serials;

  List<OrderModel> getOrdersForRadio_order_Serials() {
    return orders
        .where((e) =>
            e.actions.if_action_exist(
                OrderAction.order_aproved_from_calculation.getTitle) ==
            true)
        .where((element) =>
            element.actions.if_action_exist(
                OrderAction.order_aproved_from_control.getTitle) ==
            true)
        .where((element) =>
            element.actions
                .if_action_exist(OrderAction.order_colosed.getTitle) ==
            false)
        .toList();
  }

//chosen item
  OperationOrederItems? initionalForRadio_order_sizes;

  List<OperationOrederItems> getOrdersForRadio_order_sizes() {
    if (initionalForRadio_order_Serials != null) {
      return orders
          .where((element) => element == initionalForRadio_order_Serials)
          .first
          .items;
    } else {
      return [];
    }
  }

  Refrsh_ui() {
    notifyListeners();
  }
}
