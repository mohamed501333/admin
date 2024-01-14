// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/Customer_controller.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/controllers/Order_controller.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';
import 'package:provider/provider.dart';

class CuttingOrderViewModel extends BaseViewModel {
  String date(DateTime d) {
    return DateFormat("yyyy-MM-dd").format(d);
  }

  addOrder(BuildContext context) {
    if (temp.isNotEmpty) {
      OrderModel order = OrderModel(
          notes: notes.text,
          dateTOOrder:
              DateTime.fromMillisecondsSinceEpoch(datecontroller.text.to_int()),
          datecreated: DateTime.now(),
          id: DateTime.now().millisecondsSinceEpoch,
          serial: context.read<OrderController>().orders.length + 1,
          customer:
              context.read<Customer_controller>().initialForRaido!.toString(),
          actions: [],
          items: temp);
      context.read<OrderController>().add_order(order);
      context.read<ObjectBoxController>().get();
      clearfields();
      temp.clear();
    }
  }

  addItem(BuildContext context, read) {
    temp.add(OperationOrederItems(
      id: DateTime.now().millisecondsSinceEpoch,
      color: read.initialcolor,
      type: read.initialtype,
      density: read.initialdensity,
      lenth: lenthcontroller.text.to_double(),
      widti: widthcontroller.text.to_double(),
      hight: hightncontroller.text.to_double(),
      Qantity: amountcontroller.text.to_int(),
    ));
    clearfields();
    context.read<ObjectBoxController>().get();
  }

  List<OperationOrederItems> temp = [];

  double petcentage_of_cutingOrder(
      BuildContext context, OrderModel order, OperationOrederItems item) {
    var a = context
        .read<final_prodcut_controller>()
        .finalproducts
        .where((e) =>
            e.cuting_order_number == order.serial &&
            e.lenth == item.lenth &&
            e.width == item.widti &&
            e.type == item.type &&
            e.density == item.density &&
            e.color == item.color &&
            e.hight == item.hight)
        .map((e) => e.amount);
    var b;

    if (a.isNotEmpty) {
      b = a.reduce((a, b) => a + b);
    }
    return b == null ? 0 : b / item.Qantity * 100;
  }

  List<BlockModel> filterd = [];
  String whatfilter = "";
}
