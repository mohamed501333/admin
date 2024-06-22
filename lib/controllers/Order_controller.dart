// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, empty_catches

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/data/sharedprefs.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/notification.dart';

import 'package:jason_company/ui/recources/enums.dart';
import 'package:http/http.dart' as http;
import 'package:jason_company/ui/recources/publicVariables.dart';
import 'package:jason_company/ui/recources/strings_manager.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class OrderController extends ChangeNotifier {
  List<cutingOrder> cuttingOrders = [];
  List<cutingOrder> initalData = [];
  static late WebSocketChannel channel;
  getData() {
    if (internet == true) {
      cuttingOrders_From_firebase();
    } else {
      cuttingOrders_From_Server();
    }
  }

  cuttingOrders_From_firebase() {


    
    // print('get orders firbase');Firestore.instance.collection('cuttingOrders').stream.where(test)
    // Firestore.instance.collection('cuttingOrders').where('cuttingOrder_ID',isEqualTo:1704617197825 ).get().then((val) {
    //   cuttingOrders.clear();

    //   for (var element in val) {
    //     var order = cutingOrder.fromMap(element.map);
    //     if (order.actions.if_action_exist(OrderAction.Archive_order.getTitle) ==
    //         false) {
    //       cuttingOrders.add(order);
    //     }
    //   }
    // });
    // FirebaseFirestore.instance.collection('cuttingOrders').get().then((val) {
    //   cuttingOrders.clear();
    //   for (var element in val.docChanges) {
    //     var order = cutingOrder.fromMap(element.doc.data()!);
    //     if (order.actions.if_action_exist(OrderAction.Archive_order.getTitle) ==
    //         false) {
    //       cuttingOrders.add(order);
    //     }
    //   }
    // });
  }

  cuttingOrders_From_Server() async {
    // get for the first time
    Uri uri = Uri.http('$ip:8080', '/cuttingOrders');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      cuttingOrders.clear();
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var cittingorder = cutingOrder.fromMap(element);
        if (cittingorder.actions
                .if_action_exist(OrderAction.Archive_order.getTitle) ==
            false) {
          cuttingOrders.add(cittingorder);
        }
      }
      notifyListeners();
    }
    //
    Uri uri2 = Uri.parse('ws://$ip:8080/cuttingOrders/ws').replace(
        queryParameters: {
          'username': Sharedprfs.email,
          'password': Sharedprfs.password
        });
    channel = WebSocketChannel.connect(uri2);
    channel.stream.forEach((u) {
      cutingOrder order = cutingOrder.fromJson(u);
      var index = cuttingOrders
          .map((e) => e.cuttingOrder_ID)
          .toList()
          .indexOf(order.cuttingOrder_ID);

      if (index == -1) {
        if (order.actions.if_action_exist(OrderAction.Archive_order.getTitle) ==
            false) {
          cuttingOrders.add(order);
        } else {
          cuttingOrders.removeAt(index);
          if (order.actions
                  .if_action_exist(OrderAction.Archive_order.getTitle) ==
              false) {
            cuttingOrders.add(order);
          }
        }
      }
      notifyListeners();
    });
  }

  add_order(cutingOrder order) async {
    String dataNotifications = '{ '
        ' "to" : "/topics/myTopic1" , '
        ' "notification" : {'
        ' "title":"(${order.serial})امر شغل جديد    " , '
        ' "body":"${order.actions.get_Who_Of(OrderAction.create_order.getTitle)}" '
        ' "sound":"default" '
        ' } '
        ' } ';

    if (internet == true) {
      FirebaseFirestore.instance
          .collection('cuttingOrders')
          .doc(order.cuttingOrder_ID.toString())
          .set(order.toMap());
      sendnotification(dataNotifications);
    } else {
      channel.sink.add(order.toJson());
    }

    notifyListeners();
  }

  updatecuttingOrder(cutingOrder item, OrderAction action) async {
    item.actions.add(action.add);
    if (internet == true) {
      FirebaseFirestore.instance
          .collection('cuttingOrders')
          .doc(item.cuttingOrder_ID.toString())
          .set(item.toMap());
      if (action.add.action == "order_aproved_from_calculation") {
        String dataNotifications = '{ '
            ' "to" : "/topics/myTopic1" , '
            ' "notification" : {'
            ' "title":" (${item.serial})موافقة الحسابات    " , '
            ' "body":"${SringsManager.myemail}" '
            ' "sound":"default" '
            ' } '
            ' } ';

        sendnotification(dataNotifications);
      }
      if (action.add.action == "order_aproved_from_control") {
        String dataNotifications = '{ '
            ' "to" : "/topics/myTopic1" , '
            ' "notification" : {'
            ' "title":" (${item.serial})موافقة الكنترول    " , '
            ' "body":"${SringsManager.myemail}" '
            ' "sound":"default" '
            ' } '
            ' } ';
        sendnotification(dataNotifications);
      }
    } else {}
    try {
      channel.sink.add(item.toJson());
    } catch (e) {}
  }

  sendnotification(String data) async {
    await http.post(
      Uri.parse(Constants.BASE_URL),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key= ${Constants.KEY_SERVER}',
      },
      body: data,
    );
  }

  OperationOrederItems? item;
  cutingOrder? order;
  edit_cell(dynamic oldvalue, int id, int id2, String cell, String newvalue) {
    cutingOrder user =
        cuttingOrders.where((element) => element.cuttingOrder_ID == id).first;

    // user.actions.add(ActionModel(
    //     action:
    //         "edit $cell of order  ${user.serial}  from  $oldvalue  to  $newvalue",
    //     who: FirebaseAuth.instance.currentUser!.email ?? "",
    //     when: DateTime.now()));

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
      FirebaseDatabase.instance
          .ref("orders/${user.cuttingOrder_ID}")
          .set(user.toJson());
    } catch (e) {}
  }

  Refrsh_ui() {
    notifyListeners();
  }
}
