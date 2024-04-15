// ignore_for_file: must_be_immutable, file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/final_product_outOrder/outOfStockOrder_veiwModel.dart';
import 'package:jason_company/ui/final_product_outOrder/wid.dart';
import 'package:jason_company/ui/recources/color_manager.dart';
import 'package:provider/provider.dart';

class outOfStockOrder extends StatelessWidget {
  outOfStockOrder({super.key});

  outOfStockOrderveiwModel vm = outOfStockOrderveiwModel();
  List<FinalProductModel> finals = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, finalproducts, child) {
        List<FinalProductModel> scorce =
            vm.getfinalprodcuts_recevedFromStock(finalproducts.finalproducts);

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
                  children: finals.map((i) {
                    var a = scorce.countOf(i);
                    return a == 0
                        ? const SizedBox()
                        : Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                                color: Colors.blue[50],
                                border: Border.all(width: .5)),
                            child: ListTile(
                              trailing: Text(
                                "$a",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.red),
                              ),
                              title: Row(
                                children: [
                                  Text("${i.item.density}" "ك"),
                                  const SizedBox(
                                    width: 9,
                                  ),
                                  Text(i.item.color),
                                  const SizedBox(
                                    width: 9,
                                  ),
                                  Text(i.item.type.toString()),
                                  const SizedBox(
                                    width: 9,
                                  ),
                                  Text("${i.item.L.removeTrailingZeros}"
                                      "*"
                                      "${i.item.W.removeTrailingZeros}"
                                      "*"
                                      " ${i.item.H.removeTrailingZeros}"),
                                  const SizedBox(
                                    width: 9,
                                  ),
                                  OutOrder(item: i, total: a)
                                ],
                              ),
                            ),
                          );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
