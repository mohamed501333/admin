// ignore_for_file: must_be_immutable, file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/extentions/finalProdcutExtentions.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/ui/final_product_outOrder/wid.dart';
import 'package:jason_company/ui/recources/color_manager.dart';
import 'package:provider/provider.dart';

class outOfStockOrder extends StatelessWidget {
  const outOfStockOrder({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, finalproducts, child) {
        List<FinalProdcutWithTOtal> scorce = finalproducts.finalproducts
            .Removefinalprodcuts_NOTrecevedFromStock()
            .ReturnItmeWithTotalAndRemovewhreTotalZeto();

        var column = Column(
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
                context.read<final_prodcut_controller>().searchin_OutOFStock =
                    value;
                context.read<final_prodcut_controller>().Refresh_Ui();
              },
            ),
            Consumer<final_prodcut_controller>(
              builder: (context, myType, child) {
                return Column(
                  children: scorce
                      .searchforSize(context
                          .read<final_prodcut_controller>()
                          .searchin_OutOFStock)
                      .map((i) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                              color: Colors.blue[50],
                              border: Border.all(width: .5)),
                          child: ListTile(
                            trailing: Text(
                              "${i.amount}",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.red),
                            ),
                            title: Row(
                              children: [
                                Text("${i.density.removeTrailingZeros}"
                                    "ك"),
                                const SizedBox(
                                  width: 9,
                                ),
                                Text(i.color),
                                const SizedBox(
                                  width: 9,
                                ),
                                Text(i.type.toString()),
                                const SizedBox(
                                  width: 9,
                                ),
                                Text("${i.L.removeTrailingZeros}"
                                    "*"
                                    "${i.W.removeTrailingZeros}"
                                    "*"
                                    " ${i.H.removeTrailingZeros}"),
                                const SizedBox(
                                  width: 9,
                                ),
                                OutOrder(item: i)
                              ],
                            ),
                          ),
                        );
                      })
                      .toList()
                      .toList(),
                );
              },
            ),
          ],
        );
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 50,
            title: const RadiobuttomForFInalProdcutOUtOrder(),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (finalproducts.indexOfRadioButon == 1) InvoiceM(),
                if (finalproducts.indexOfRadioButon == 0) column
              ],
            ),
          ),
        );
      },
    );
  }
}
