// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/controllers/invoice_controller.dart';
import 'package:jason_company/controllers/setting_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

class outOfStockOrderveiwModel extends BaseViewModel {
  List<FinalProductModel> sourcesearshing(
      List<FinalProductModel> finalproducts, String enterkeyword) {
    var x = finalproducts;
    return x
        .filter_density_type_size()
        .where((element) => (element.lenth.removeTrailingZeros +
                element.width.removeTrailingZeros +
                element.hight.removeTrailingZeros)
            .contains(enterkeyword))
        .toList();
  }

//ارجاع اجمالى العدد لكل مقاس
  get_total(List<FinalProductModel> finalproducts, FinalProductModel e) {
    return finalproducts
        .where((element) =>
            element.density == e.density &&
            element.type == e.type &&
            element.width == e.width &&
            element.hight == e.hight &&
            element.lenth == e.lenth)
        .map((e) => e.amount)
        .reduce((a, b) => a + b);
  }

  //صرف المنتح التام
  void add(BuildContext context, FinalProductModel item, int total) {
    if (formKey.currentState!.validate() &&
        total > 0 &&
        total >= int.parse(amountcontroller.text)) {
      double volume = item.width *
          item.lenth *
          item.hight *
          int.parse(amountcontroller.text);
      context
          .read<final_prodcut_controller>()
          .finalProdcut_out_order(FinalProductModel(
            volume: volume,
            whight: volume * item.density,
            invoiceNum: 0,
            price: 0.0,
            worker: "",
            stageOfR: 0,
            isfinal: true,
            notes: notes.text,
            cuting_order_number: 0,
            actions: [],
            id: DateTime.now().millisecondsSinceEpoch,
            color: item.color,
            density: item.density,
            type: item.type,
            amount: -int.parse(amountcontroller.text),
            scissor: int.tryParse(scissorcontroller.text) ?? 0,
            width: item.width,
            lenth: item.lenth,
            hight: item.hight,
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
            false)
        .isNotEmpty) {
      if (formKey.currentState!.validate()) {
        List<InvoiceItem> items = finals
            .where((element) =>
                element.actions.if_action_exist(
                    finalProdcutAction.createInvoice.getactionTitle) ==
                false)
            .map((e) => InvoiceItem(
                price: 0.0,
                amount: e.amount,
                lenth: e.lenth,
                width: e.width,
                hight: e.hight,
                wight: double.parse(
                        "${e.amount * -1 * e.lenth * e.width * e.hight * e.density / 1000000}")
                    .removeTrailingZeros
                    .to_double(),
                color: e.color,
                density: e.density,
                customer: customerName.text))
            .toList();
        var invoice = Invoice(
            biscole: 0.0,
            notes: "",
            id: DateTime.now().millisecondsSinceEpoch,
            number: context.read<SettingController>().switch1 == false
                ? invoices.sortedBy<num>((element) => element.id).last.number +
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
                    false)
                .toList(),
            invoices.sortedBy<num>((element) => element.id).last.number + 1);

        clearfields();
      }
    }
  }
}
