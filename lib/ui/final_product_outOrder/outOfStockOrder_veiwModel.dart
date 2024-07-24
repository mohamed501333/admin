// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/biscol.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/controllers/invoice_controller.dart';
import 'package:jason_company/controllers/setting_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/recources/strings_manager.dart';
import 'package:provider/provider.dart';

class outOfStockOrderveiwModel extends BaseViewModel {
  //صرف المنتح التام
  void add(BuildContext context, FinalProductModel item) {
    if (item.item.amount > 0 &&
        item.item.amount >= int.parse(amountcontroller.text)) {
      double volume = item.item.W *
          item.item.L *
          item.item.H *
          int.parse(amountcontroller.text) /
          1000000;
      context
          .read<final_prodcut_controller>()
          .updateFinalProdcut(FinalProductModel(
            updatedat: DateTime.now().microsecondsSinceEpoch,
            block_ID: 0,
            fraction_ID: 0,
            sapa_ID: "",
            sapa_desc: "",
            subfraction_ID: 0,
            item: FinalProdcutItme(
                L: item.item.L,
                W: item.item.W,
                H: item.item.H,
                density: item.item.density,
                volume: volume.toStringAsFixed(1).to_double(),
                theowight:
                    volume.toStringAsFixed(1).to_double() * item.item.density,
                realowight: 0.0,
                color: item.item.color,
                type: item.item.type,
                amount: -int.parse(amountcontroller.text),
                priceforamount: 0.0),
            invoiceNum: 0,
            worker: "",
            stage: 0,
            notes: notes.text,
            cuting_order_number: 0,
            actions: [
              finalProdcutAction.out_order.add,
              finalProdcutAction.recive_Done_Form_FinalProdcutStock.add
            ],
            finalProdcut_ID: DateTime.now().millisecondsSinceEpoch,
            scissor: 0,
            customer: item.customer,
          ));
      clearfields();
    }
  }

  addInvoice(BuildContext context) {
    Iterable<int> invoices =
        Provider.of<Invoice_controller>(context, listen: false)
            .invoices
            .map((e) => e.serial);
    List<FinalProductModel> finals = context
        .read<final_prodcut_controller>()
        .finalproducts
        .where((element) =>
            element.item.amount < 0 &&
            element.actions.if_action_exist(
                    finalProdcutAction.createInvoice.getactionTitle) ==
                false &&
            element.actions.if_action_exist(finalProdcutAction
                    .incert_From_StockChekRefresh.getactionTitle) ==
                false)
        .toList();

    int serial = context.read<SettingController>().switch1 == false
        ? invoices.isEmpty
            ? 0
            : invoices.max + 1
        : invoiceNum.text.to_int();

    if (formKey.currentState!.validate() && finals.isNotEmpty) {
      List<InvoiceItem> invoiceItems = finals
          .map((e) => InvoiceItem(
              finalprodcut_ID: e.fraction_ID,
              invoiceItem_ID: DateTime.now().microsecondsSinceEpoch,
              type: e.item.type,
              reallWight: 0.0,
              price: 0.0,
              quantity: e.item.amount,
              lenth: e.item.L,
              width: e.item.W,
              hight: e.item.H,
              theoriticalWight: double.parse(
                      "${e.item.amount * -1 * e.item.L * e.item.W * e.item.H * e.item.density / 1000000}")
                  .removeTrailingZeros
                  .to_double(),
              color: e.item.color,
              density: e.item.density,
              customer: customerName.text))
          .toList();

      var invoice = Invoice(
          updatedat: DateTime.now().microsecondsSinceEpoch,
          notes: "",
          invoice_ID: DateTime.now().millisecondsSinceEpoch,
          serial: serial,
          driverName: driverName.text,
          carNumber: carnumber.text.to_int(),
          dispatcher: SringsManager.myemail,
          actions: [InvoiceAction.creat_invoice.add],
          items: invoiceItems);

      context.read<Invoice_controller>().addInvoice(invoice);

      context
          .read<final_prodcut_controller>()
          .updateItemsWith_actionAndInvioceNum(finals, serial);
      if (context.read<final_prodcut_controller>().indexOfRadioButon == 0) {
        final record = context.read<Hivecontroller>().ini!;
        record.carNum = carnumber.text.to_int();
        record.driverName = driverName.text;
        record.customerName = customerName.text;
        context.read<Hivecontroller>().updateRecord(record, serial);
      }

      clearfields();
    }
  }
}
