// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/Order_controller.dart';
import 'package:jason_company/controllers/dropDowen_controller.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

class FinalProductStockViewModel extends BaseViewModel {
  OrderModel find(List<OrderModel> orders, OperationOrederItems item) {
    return orders
        .where((element) => element.items.map((e) => e.id).contains(item.id))
        .first;
  }

  incert_finalProduct_from_cutingUnit(BuildContext context) {
    int? scissor = context.read<dropDowenContoller>().initioalFor_Scissors;

    OrderController my = context.read<OrderController>();
    if (my.order != null && my.item != null && scissor != null && validate()) {
      double volume = my.item!.widti *
          my.item!.lenth *
          my.item!.hight *
          int.parse(amountcontroller.text) /
          1000000;
      context
          .read<final_prodcut_controller>()
          .updateFinalProdcut(FinalProductModel(
            block_ID: 0,
            fraction_ID: 0,
            sapa_ID: "",
            sapa_desc: "",
            subfraction_ID: 0,
            invoiceNum: 0,
            worker: "",
            stage: context.read<dropDowenContoller>().N.text.to_int(),
            notes: notes.text,
            cuting_order_number: my.order!.serial,
            actions: [
              finalProdcutAction.incert_finalProduct_from_cutingUnit.add
            ],
            finalProdcut_ID: DateTime.now().millisecondsSinceEpoch,
            item: FinalProdcutItme(
                L: my.item!.lenth,
                W: my.item!.widti,
                H: my.item!.hight,
                density: my.item!.density,
                volume: volume.toStringAsFixed(2).to_double(),
                theowight:
                    volume.toStringAsFixed(2).to_double() * my.item!.density,
                realowight: 0.0,
                color: my.item!.color,
                type: my.item!.type,
                amount: int.parse(amountcontroller.text),
                priceforamount: 0.0),
            scissor: scissor,
            customer: my.order!.customer,
          ));
      amountcontroller.clear();
      notes.clear();
      N.clear();
      context.read<dropDowenContoller>().initioalFor_Scissors = null;
      my.order = null;
      my.item = null;
      my.Refrsh_ui();
      context.read<dropDowenContoller>().Refrsh_ui();
    }
  }

  add_unregular(BuildContext context, bool isfinal) {
    double volume = int.parse(amountcontroller.text) *
        widthcontroller.text.to_double() *
        lenthcontroller.text.to_double() *
        hightncontroller.text.to_double() /
        1000000;
    FinalProductModel user = FinalProductModel(
      block_ID: 0,
      fraction_ID: 0,
      sapa_ID: "",
      sapa_desc: "",
      subfraction_ID: 0,
      invoiceNum: 0,
      item: FinalProdcutItme(
          L: lenthcontroller.text.to_double(),
          W: widthcontroller.text.to_double(),
          H: hightncontroller.text.to_double(),
          density: densitycontroller.text.to_double(),
          volume: volume.toStringAsFixed(2).to_double(),
          theowight: volume.toStringAsFixed(2).to_double() *
              densitycontroller.text.to_double(),
          realowight: 0.0,
          color: colercontroller.text,
          type: typecontroller.text,
          amount: int.parse(amountcontroller.text),
          priceforamount: 0.0),
      stage: N.text.to_int(),
      finalProdcut_ID: DateTime.now().millisecondsSinceEpoch,
      scissor: scissorcontroller.text.to_int(),
      customer: companycontroller.text,
      worker: '',
      notes: "",
      cuting_order_number: 0,
      actions: [finalProdcutAction.incert_finalProduct_from_cutingUnit.add],
    );
    if (formKey.currentState!.validate()) {
      context.read<final_prodcut_controller>().updateFinalProdcut(user);
      clearfields();
    }
  }
}
