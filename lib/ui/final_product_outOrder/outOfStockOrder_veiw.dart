// ignore_for_file: must_be_immutable, file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/final_product_outOrder/outOfStockOrder_veiwModel.dart';
import 'package:jason_company/ui/final_product_outOrder/wid.dart';
import 'package:jason_company/ui/recources/color_manager.dart';
import 'package:provider/provider.dart';
import 'package:jason_company/ui/recources/enums.dart';

class outOfStockOrder extends StatelessWidget {
  outOfStockOrder({super.key});

  outOfStockOrderveiwModel vm = outOfStockOrderveiwModel();
  List<FinalProductModel> finals = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, finalproducts, child) {
        List<FinalProductModel> scorce = finalproducts.finalproducts
            .where((e) =>
                e.actions.if_action_exist(
                    finalProdcutAction.archive_final_prodcut.getactionTitle) ==
                false)
            .where((e) =>
                e.actions.if_action_exist(finalProdcutAction
                        .recive_Done_Form_FinalProdcutStock.getactionTitle) ==
                    true ||
                e.actions.if_action_exist(finalProdcutAction
                        .incert_finalProduct_from_Others.getactionTitle) ==
                    true ||
                e.actions.if_action_exist(finalProdcutAction.out_order.getactionTitle) ==
                    true ||
                e.actions.if_action_exist(finalProdcutAction.createInvoice.getactionTitle) == true)
            .toList();

        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () => context.gonext(context, HistoryOfLoaded()),
                  icon: const Icon(Icons.history)),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                  onPressed: () => context.gonext(context, InvoiceM()),
                  icon: const Icon(Icons.add_shopping_cart)),
            ],
            title: const Center(child: Text("صرف منتج تام")),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: ColorManager.gray),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: ColorManager.gray,
                      )),
                  onChanged: (value) {
                    finals.clear();
                    finals = vm.sourcesearshing(scorce, value);

                    finalproducts.Refresh_Ui();
                  },
                ),
                Column(
                  children: finals
                      // .take(33)
                      .map((i) => vm.get_total(scorce, i) == 0
                          ? const SizedBox()
                          : Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  border: Border.all(width: .5)),
                              child: ListTile(
                                trailing: Text(
                                  "${vm.get_total(scorce, i)}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: ColorManager.red),
                                ),
                                title: Row(
                                  children: [
                                    Text("${i.density}" "ك"),
                                    const SizedBox(
                                      width: 9,
                                    ),
                                    Text("${i.color}"),
                                    const SizedBox(
                                      width: 9,
                                    ),
                                    Text(i.type.toString()),
                                    const SizedBox(
                                      width: 9,
                                    ),
                                    Text("${i.lenth.removeTrailingZeros}"
                                        "*"
                                        "${i.width.removeTrailingZeros}"
                                        "*"
                                        " ${i.hight.removeTrailingZeros}"),
                                    const SizedBox(
                                      width: 9,
                                    ),
                                    OutOrder(
                                        item: i, total: vm.get_total(scorce, i))
                                  ],
                                ),
                              ),
                            ))
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
