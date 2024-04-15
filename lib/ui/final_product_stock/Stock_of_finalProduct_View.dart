// ignore_for_file: must_be_immutable, file_names

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/fromExcel.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/controllers/Customer_controller.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/final_product_outOrder/outOfStockOrder_veiwModel.dart';
import 'package:jason_company/ui/recources/color_manager.dart';
import 'package:jason_company/ui/final_product_stock/Stock_of_finalProduct_ViewModel.dart';
import 'package:jason_company/ui/final_product_stock/widgets.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

class FinalProductStockView extends StatelessWidget {
  FinalProductStockView({super.key});

  stockOfFinalProductsViewModel vm = stockOfFinalProductsViewModel();
  outOfStockOrderveiwModel vm2 = outOfStockOrderveiwModel();

  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, finalproducts, child) {
        List<FinalProductModel> scorce =
            vm2.getfinalprodcuts_recevedFromStock(finalproducts.finalproducts);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () => context.gonext(context, const bulkUpload()),
                  icon: const Icon(Icons.explicit_outlined)),
              AddToStock().permition(
                  context, UserPermition.incert_in_final_prodcutStock),
              IconButton(
                  onPressed: () =>
                      context.gonext(context, HistoryOfAdingToStock()),
                  icon: const Icon(Icons.history)),
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
                                    permitionss(
                                            context,
                                            UserPermition
                                                .incert_in_final_prodcutStock)
                                        ? dialog(context, vm, i, e)
                                        : DoNothingAction();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(.5),
                                    decoration: BoxDecoration(
                                        color: Colors.blue[50],
                                        border: Border.all(width: .5)),
                                    child: i.total < 1
                                        ? const SizedBox()
                                        : ListTile(
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
                                                Text(
                                                    "${i.lenth.removeTrailingZeros}"
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
