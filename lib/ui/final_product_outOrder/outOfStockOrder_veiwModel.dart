// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/extentions/finalProdcutExtentions.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/controllers/invoice_controller.dart';
import 'package:jason_company/controllers/setting_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

class outOfStockOrderveiwModel extends BaseViewModel {
  //صرف المنتح التام
  void add(BuildContext context, FinalProdcutWithTOtal item) {
    if (formKey.currentState!.validate() &&
        item.amount > 0 &&
        item.amount >= int.parse(amountcontroller.text)) {
      double volume =
          item.W * item.L * item.H * int.parse(amountcontroller.text) / 1000000;
      context
          .read<final_prodcut_controller>()
          .updateFinalProdcut(FinalProductModel(
            block_ID: 0,
            fraction_ID: 0,
            sapa_ID: "",
            sapa_desc: "",
            subfraction_ID: 0,
            item: FinalProdcutItme(
                L: item.L,
                W: item.W,
                H: item.H,
                density: item.density,
                volume: volume.toStringAsFixed(2).to_double(),
                theowight: volume.toStringAsFixed(2).to_double() * item.density,
                realowight: 0.0,
                color: item.color,
                type: item.type,
                amount: -int.parse(amountcontroller.text),
                priceforamount: 0.0),
            invoiceNum: 0,
            worker: "",
            stage: 0,
            notes: notes.text,
            cuting_order_number: 0,
            actions: [finalProdcutAction.out_order.add],
            finalProdcut_ID: DateTime.now().millisecondsSinceEpoch,
            scissor: 0,
            customer: item.customer,
          ));
      clearfields();
    }
  }

  addInvoice(BuildContext context, List<FinalProductModel> finals) {
    List<Invoice> invoices = context.read<Invoice_controller>().invoices;

    if (finals
        .where((element) =>
            element.actions.if_action_exist(
                    finalProdcutAction.createInvoice.getactionTitle) ==
                false &&
            element.actions.if_action_exist(finalProdcutAction
                    .incert_From_StockChekRefresh.getactionTitle) ==
                false)
        .isNotEmpty) {
      if (formKey.currentState!.validate()) {
        List<InvoiceItem> items = finals
            .where((element) =>
                element.actions.if_action_exist(finalProdcutAction
                        .createInvoice.getactionTitle) ==
                    false &&
                element.actions.if_action_exist(
                        finalProdcutAction
                            .incert_From_StockChekRefresh.getactionTitle) ==
                    false)
            .map((e) => InvoiceItem(
                price: 0.0,
                amount: e.item.amount,
                lenth: e.item.L,
                width: e.item.W,
                hight: e.item.H,
                wight: double.parse(
                        "${e.item.amount * -1 * e.item.L * e.item.W * e.item.H * e.item.density / 1000000}")
                    .removeTrailingZeros
                    .to_double(),
                color: e.item.color,
                density: e.item.density,
                customer: customerName.text))
            .toList();
        var invoice = Invoice(
            biscole: 0.0,
            notes: "",
            id: DateTime.now().millisecondsSinceEpoch,
            number: context.read<SettingController>().switch1 == false
                ? invoices.map((element) => element.number).max +
                    1
                : invoiceNum.text.to_int(),
            date: DateTime.now(),
            driverName: driverName.text,
            carNumber: carnumber.text.to_int(),
            makeLoad: whoLoad.text,
            actions: [InvoiceAction.creat_invoice.add],
            items: items);
        context.read<Invoice_controller>().addInvoice(invoice);
        context.read<final_prodcut_controller>().addinvoice(
            finals
                .where((element) =>
                    element.actions.if_action_exist(
                            finalProdcutAction.createInvoice.getactionTitle) ==
                        false &&
                    element.actions.if_action_exist(finalProdcutAction
                            .incert_From_StockChekRefresh.getactionTitle) ==
                        false)
                .toList(),
            invoices.map<num>((element) => element.number).max.toInt() + 1);

        clearfields();
      }
    }
  }
}
