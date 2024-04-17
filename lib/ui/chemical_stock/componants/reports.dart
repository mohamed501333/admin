// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/setting_controller.dart';
import 'package:provider/provider.dart';

import 'package:jason_company/controllers/ChemicalsController.dart';
import 'package:jason_company/ui/chemical_stock/ChemicalStock_viewModel.dart';

class R_FOR_onlyAvilableQuantity extends StatelessWidget {
  R_FOR_onlyAvilableQuantity({
    super.key,
  });
  ChemicalStockViewModel vm = ChemicalStockViewModel();

  @override
  Widget build(BuildContext context) {
    return Consumer<Chemicals_controller>(
      builder: (context, myType, child) {
        return Column(
          children: [
            Table(
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(1),
              },
              border: TableBorder.all(width: 1, color: Colors.black),
              children: [
                TableRow(
                    decoration: const BoxDecoration(
                      color:
                          // Colors.teal[50]:
                          Color.fromARGB(122, 26, 163, 140),
                    ),
                    children: const [
                      Center(child: Text("م")),
                      Center(child: Text("العائله")),
                      Center(child: Text("الصنف")),
                      Center(child: Text("الكميه")),
                    ].reversed.toList())
              ],
            ),
            Column(
              children: vm
                  .getDataForReport(
                      context,
                      myType.selctedNames,
                      myType.selctedFamilys,
                      myType.Chemicals.FilterDateBetween_balance(
                          context.read<SettingController>().to2))
                  .map((e) => Table(
                        columnWidths: const {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(2),
                          2: FlexColumnWidth(2),
                          3: FlexColumnWidth(1),
                        },
                        border: TableBorder.all(width: 1, color: Colors.black),
                        children: [
                          TableRow(
                              decoration: const BoxDecoration(
                                color:
                                    // Colors.teal[50]:
                                    Color.fromARGB(121, 186, 237, 230),
                              ),
                              children: [
                                const Center(child: Text("")),
                                Center(child: Text(e.family.toString())),
                                Center(child: Text(e.name.toString())),
                                Center(
                                    child: Text(
                                        e.totalQuantity.toStringAsFixed(1))),
                              ].reversed.toList())
                        ],
                      ))
                  .toList(),
            )
          ],
        );
      },
    );
  }
}

class R_FOR_stock_actions extends StatelessWidget {
  const R_FOR_stock_actions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Chemicals_controller>(
      builder: (context, myType, child) {
        return Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: SizedBox(
                width: 500,
                child: ListView(
                  children: [
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                        3: FlexColumnWidth(1),
                        4: FlexColumnWidth(1),
                        5: FlexColumnWidth(1),
                      },
                      children: [
                        TableRow(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                            children: const [
                              Center(
                                child: Text("العائله"),
                              ),
                              Center(
                                child: Text("الصنف"),
                              ),
                              Center(
                                child: Text("رصيد اول المده"),
                              ),
                              Center(
                                child: Text("الوارد"),
                              ),
                              Center(
                                child: Text("المنصرف"),
                              ),
                              Center(
                                child: Text("الكميه المتوفره"),
                              ),
                            ].reversed.toList()),
                        ...myType.Chemicals.filterItemsPasedONFamilys(
                                context, myType.selctedFamilys)
                            .filterItemsPasedONnames(
                                context, myType.selctedNames)
                            .map((e) => TableRow(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 236, 235, 235),
                                ),
                                children: const [
                                  Center(
                                    child: Text("العائله"),
                                  ),
                                  Center(
                                    child: Text("الصنف"),
                                  ),
                                  Center(
                                    child: Text("رصيد اول المده"),
                                  ),
                                  Center(
                                    child: Text("الوارد"),
                                  ),
                                  Center(
                                    child: Text("المنصرف"),
                                  ),
                                  Center(
                                    child: Text("الكميه المتوفره"),
                                  ),
                                ].reversed.toList()))
                      ],
                      border: TableBorder.all(width: 1, color: Colors.black),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
