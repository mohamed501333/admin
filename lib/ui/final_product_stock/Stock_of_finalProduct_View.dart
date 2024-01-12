// ignore_for_file: must_be_immutable, file_names

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/Customer_controller.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/color_manager.dart';
import 'package:jason_company/ui/final_product_stock/Stock_of_finalProduct_ViewModel.dart';
import 'package:jason_company/ui/final_product_stock/widgets.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

class FinalProductStockView extends StatelessWidget {
  FinalProductStockView({super.key});

  stockOfFinalProductsViewModel vm = stockOfFinalProductsViewModel();

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
              AddToStock(),
              IconButton(
                  onPressed: () =>
                      context.gonext(context, HistoryOfAdingToStock()),
                  icon: const Icon(Icons.history))
            ],
            title: const Center(child: Text("رصيد منتج تام الصنع")),
          ),
          body: ListView(
              children: vm
                  .source(scorce)
                  .sortedBy<num>((element) => element.name.to_int())
                  .map(
                    (e) => ExpansionTile(
                        title: Text(
                          " (${e.name}) ${context.read<Customer_controller>().customers.where((element) => element.serial.toString() == e.name).first.name}",
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                        children: e.items
                            .map((i) => GestureDetector(
                                  onTap: () {
                                    dialog(context, vm, i, e);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(.5),
                                    decoration: BoxDecoration(
                                        color: Colors.blue[50],
                                        border: Border.all(width: .5)),
                                    child: ListTile(
                                      trailing: Text(
                                        "${i.total}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: ColorManager.red),
                                      ),
                                      leading: Text("${i.density}" "ك"),
                                      title: Row(
                                        children: [
                                          Text(i.type.toString()),
                                          const SizedBox(
                                            width: 40,
                                          ),
                                          Text("${i.lenth.removeTrailingZeros}"
                                              "*"
                                              "${i.width.removeTrailingZeros}"
                                              "*"
                                              " ${i.hight.removeTrailingZeros}"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                            .toList()),
                  )
                  .toList()),
        );
      },
    );
  }
}
