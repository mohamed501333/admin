// ignore_for_file: must_be_immutable, file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/final_product_outOrder/outOfStockOrder_veiwModel.dart';
import 'package:jason_company/ui/final_product_outOrder/wid.dart';
import 'package:jason_company/ui/recources/color_manager.dart';
import 'package:jason_company/ui/final_product_stock/Stock_of_finalProduct_ViewModel.dart';
import 'package:provider/provider.dart';
import 'package:jason_company/ui/recources/enums.dart';

import 'package:section_view/section_view.dart';

class outOfStockOrder extends StatelessWidget {
  outOfStockOrder({super.key});

  stockOfFinalProductsViewModel vm = stockOfFinalProductsViewModel();
  outOfStockOrderveiwModel vm2 = outOfStockOrderveiwModel();

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
          body: SectionView<GroupModel, ItemModel>(
              source: vm.source(scorce),
              onFetchListData: (header) => header.items,
              headerBuilder: (BuildContext context, GroupModel headerData,
                  int headerIndex) {
                return headerData.items
                            .map((e) => e.total)
                            .reduce((a, b) => a = b) ==
                        0
                    ? const SizedBox()
                    : Container(
                        color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          child: Text(
                            headerData.name.toString(),
                            style: const TextStyle(
                                fontSize: 18, color: ColorManager.white),
                          ),
                        ),
                      );
              },
              itemBuilder:
                  (context, itemData, itemIndex, headerData, headerIndex) =>
                      itemData.total == 0
                          ? const SizedBox()
                          : Container(
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  border: Border.all(width: .5)),
                              child: ListTile(
                                trailing: Text(
                                  "${itemData.total}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: ColorManager.red),
                                ),
                                leading: Text("${itemData.density}" "ك"),
                                title: Row(
                                  children: [
                                    Text(itemData.type.toString()),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text("${itemData.lenth.removeTrailingZeros}"
                                        "*"
                                        "${itemData.width.removeTrailingZeros}"
                                        "*"
                                        " ${itemData.hight.removeTrailingZeros}"),
                                    const SizedBox(
                                      width: 40,
                                    ),

                                    //
                                    OutOrder(
                                      headerData: headerData,
                                      itemData: itemData,
                                    )
                                  ],
                                ),
                              ),
                            )),
        );
      },
    );
  }
}
