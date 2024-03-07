// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, empty_catches

import 'package:firebase_auth/firebase_auth.dart';
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
        print("get data of order");
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

  OperationOrederItems? item;
  OrderModel? order;
  edit_cell(dynamic oldvalue, int id, int id2, String cell, String newvalue) {
    OrderModel user = orders.where((element) => element.id == id).first;

    user.actions.add(ActionModel(
        action:
            "edit $cell of order  ${user.serial}  from  $oldvalue  to  $newvalue",
        who: FirebaseAuth.instance.currentUser!.email ?? "",
        when: DateTime.now()));

    cell == "serial" ? user.serial = newvalue.to_int() : DoNothingAction();
    cell == "len"
        ? user.items.where((element) => element.id == id2).first.lenth =
            newvalue.to_double()
        : DoNothingAction();
    cell == "wed"
        ? user.items.where((element) => element.id == id2).first.widti =
            newvalue.to_double()
        : DoNothingAction();
    cell == "hight"
        ? user.items.where((element) => element.id == id2).first.hight =
            newvalue.to_double()
        : DoNothingAction();
    cell == "den"
        ? user.items.where((element) => element.id == id2).first.density =
            newvalue.to_double()
        : DoNothingAction();
    cell == "type"
        ? user.items.where((element) => element.id == id2).first.type = newvalue
        : DoNothingAction();
    cell == "color"
        ? user.items.where((element) => element.id == id2).first.color =
            newvalue
        : DoNothingAction();
    cell == "amount"
        ? user.items.where((element) => element.id == id2).first.Qantity =
            newvalue.to_int()
        : DoNothingAction();
    try {
      FirebaseDatabase.instance.ref("orders/${user.id}").set(user.toJson());
    } catch (e) {}
  }

  Refrsh_ui() {
    notifyListeners();
  }

  get_blockCategory_data() {}


}
