// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:jason_company/controllers/Order_controller.dart';
import 'package:jason_company/controllers/dropDowen_controller.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';
import 'package:provider/provider.dart';

class FinalProductStockViewModel extends BaseViewModel {
  incert_finalProduct_from_cutingUnit(BuildContext context) {
    OrderModel? order =
        context.read<OrderController>().initionalForRadio_order_Serials;
    OperationOrederItems? item =
        context.read<OrderController>().initionalForRadio_order_sizes;
    int? scissor = context.read<dropDowenContoller>().initioalFor_Scissors;
    if (order != null && item != null && scissor != null && validate()) {
      context
          .read<final_prodcut_controller>()
          .incert_finalProduct_from_cutingUnit(FinalProductModel(
            worker: "",
            stageOfR: 0,
            isfinal: true,
            notes: notes.text,
            cuting_order_number: order.serial,
            actions: [],
            id: DateTime.now().millisecondsSinceEpoch,
            color: item.color,
            density: item.density,
            type: item.type,
            amount: int.parse(amountcontroller.text),
            scissor: scissor,
            width: item.widti,
            lenth: item.lenth,
            hight: item.hight,
            customer: order.customer,
          ));
      amountcontroller.clear();
      notes.clear();
      context.read<dropDowenContoller>().initioalFor_Scissors = null;
      context.read<dropDowenContoller>().Refrsh_ui();
    }
  }
}
