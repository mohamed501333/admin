// ignore_for_file: file_names, must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/bFractionsController.dart';
import 'package:jason_company/controllers/bSubfractions.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/controllers/setting_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/reports/%D8%A7%D9%84%D9%85%D8%B5%D8%B1%D9%88%D9%81%20%D9%85%D9%82%D8%A7%D8%A8%D9%84%20%D8%A7%D9%84%D8%A7%D9%86%D8%AA%D8%A7%D8%AC/Report10_viewMdel.dart';

import 'package:provider/provider.dart';

class Report10View extends StatelessWidget {
  Report10View({super.key});
  Rscissor_viewmodel vm = Rscissor_viewmodel();

  @override
  Widget build(BuildContext context) {
    return Consumer3<SettingController, BlockFirebasecontroller,
        final_prodcut_controller>(
      builder: (context, myType, blockscontroller, finalprodcuts, child) {
        List<BlockModel> allblocks = blockscontroller.blocks;
        List<Itme> allunderoberationofFirstPeriod =
            allUnderOperationOfFirstPeriod(allblocks, myType, context);

        List<BlockModel> blocksconsumedBetweenTowDates =
            allblocks.filterConsumeDateBetween(
                DateTimeRange(start: myType.from, end: myType.to));
        //---------------------------------------------------------------------------

        List<FinalProductModel> finalproductsBetweenTowDates =
            finalprodcuts.finalproducts.filterFinalProductDateBetween(
                DateTimeRange(start: myType.from, end: myType.to));

        return Scaffold(
          appBar: AppBar(
            title: const Text("مقارنة الانتاج بالمصروف"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Text("تقرير الانتاج مقابل المصروف "),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DatepickerTo(),
                    DatePickerFrom(),
                  ],
                ),
                TableOfTotals(
                    allunderoberationofFirstPeriod:
                        allunderoberationofFirstPeriod,
                    blocksconsumedBetweenTowDates:
                        blocksconsumedBetweenTowDates,
                    finalproductsBetweenTowDates: finalproductsBetweenTowDates,
                    vm: vm),
                TableOfFiretPeriodUnderOperationInDetals(
                    allunderoberationofFirstPeriod:
                        allunderoberationofFirstPeriod),
                DetailsOfFinlProdcuts(
                    finalproductsBetweenTowDates: finalproductsBetweenTowDates)
              ],
            ),
          ),
        );
      },
    );
  }

  List<Itme> allUnderOperationOfFirstPeriod(List<BlockModel> allblocks,
      SettingController myType, BuildContext context) {
    Fractions_Controller fractrioncontroller = Fractions_Controller();

    //---------------------------------------------------------------------------
    List<FractionModel>
        fractionsUnderOperation = //رصيد اول المده من تحت التشغيل
        fractrioncontroller.fractions
            .where((element) => element.underOperation == true)
            .toList()
            .ReturnFirstPiriodBalanceOFUnderoperationFractons(
                DateTimeRange(start: myType.from, end: myType.to));
    //---------------------------------------------------------------------------

    List<SubFraction>
        subfractionsUnderoperation = //رصيد اول المده من تحت التشغيل
        context
            .read<SubFractions_Controller>()
            .subfractions
            .ReturnFirstPiriodBalanceOFUnderoperationSubFractons(
                DateTimeRange(start: myType.from, end: myType.to));
    //---------------------------------------------------------------------------
    List<Itme> allunderoberationofFirstPeriod =
        fractionsUnderOperation.map((element) => element.item).toList() +
            subfractionsUnderoperation.map((element) => element.item).toList();
    return allunderoberationofFirstPeriod;
  }
}

class DetailsOfFinlProdcuts extends StatelessWidget {
  const DetailsOfFinlProdcuts({
    super.key,
    required this.finalproductsBetweenTowDates,
  });

  final List<FinalProductModel> finalproductsBetweenTowDates;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: const [
              TableRow(
                  decoration: BoxDecoration(color: Colors.grey),
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("اجمالى الانتاج تفصيلى "),
                        ],
                      ),
                    ),
                  ]),
            ],
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
            },
            border: TableBorder.all(),
            children: const [
              TableRow(children: [
                Center(
                  child: Text("من"),
                ),
                Center(
                  child: Text("عدد"),
                )
              ]),
            ],
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
            },
            border: TableBorder.all(),
            children: finalproductsBetweenTowDates
                .filteronfinalproduct()
                .sortedBy<num>((element) => element.item.density)
                .map((e) => TableRow(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              textDirection: TextDirection.rtl,
                              "      ${e.item.color} ${e.item.type} ك ${e.item.density.removeTrailingZeros}"),
                          Text(
                              textDirection: TextDirection.rtl,
                              "${e.item.L.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.H.removeTrailingZeros}"),
                        ],
                      ),
                      Center(
                        child: Text(
                            finalproductsBetweenTowDates.countOf(e).toString()),
                      ),
                    ]))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class TableOfFiretPeriodUnderOperationInDetals extends StatelessWidget {
  const TableOfFiretPeriodUnderOperationInDetals({
    super.key,
    required this.allunderoberationofFirstPeriod,
  });

  final List<Itme> allunderoberationofFirstPeriod;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: const [
              TableRow(
                  decoration: BoxDecoration(color: Colors.grey),
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(" رصيد اول المده (تحت التشغيل) تفصيلى"),
                        ],
                      ),
                    ),
                  ]),
            ],
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
            },
            border: TableBorder.all(),
            children: const [
              TableRow(children: [
                Center(
                  child: Text("من"),
                ),
                Center(
                  child: Text("عدد"),
                )
              ]),
            ],
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
            },
            border: TableBorder.all(),
            children: allunderoberationofFirstPeriod
                .filterRepeats()
                .sortedBy<num>((element) => element.density)
                .map((e) => TableRow(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              textDirection: TextDirection.rtl,
                              "      ${e.color} ${e.type} ك ${e.density.removeTrailingZeros}"),
                          Text(
                              textDirection: TextDirection.rtl,
                              "${e.L.removeTrailingZeros}*${e.W.removeTrailingZeros}*${e.H.removeTrailingZeros}"),
                        ],
                      ),
                      Center(
                        child: Text(allunderoberationofFirstPeriod
                            .countOf(e)
                            .toString()),
                      ),
                    ]))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class TableOfTotals extends StatelessWidget {
  TableOfTotals({
    super.key,
    required this.allunderoberationofFirstPeriod,
    required this.blocksconsumedBetweenTowDates,
    required this.finalproductsBetweenTowDates,
    required this.vm,
  });

  final List<Itme> allunderoberationofFirstPeriod;
  final List<BlockModel> blocksconsumedBetweenTowDates;
  final List<FinalProductModel> finalproductsBetweenTowDates;
  final Rscissor_viewmodel vm;

  final TextStyle textStyle =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: const [
              TableRow(
                  decoration: BoxDecoration(color: Colors.grey),
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("تقرير اجمالى  حجم"),
                        ],
                      ),
                    ),
                  ]),
            ],
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
            },
            border: TableBorder.all(),
            children: [
              TableRow(
                  children: [
                Center(
                  child: Text(
                    "رصيد اول المده (تحت التشغيل)",
                    style: textStyle,
                  ),
                ),
                Center(
                    child: Text(allunderoberationofFirstPeriod
                        .volume()
                        .removeTrailingZeros)),
              ].reversed.toList()),
              TableRow(
                  children: [
                Center(
                  child: Text(
                    "اجمالى المنصرف (بلوكات )",
                    style: textStyle,
                  ),
                ),
                Center(
                    child: Text(blocksconsumedBetweenTowDates
                        .map((e) => e.item)
                        .toList()
                        .volume()
                        .removeTrailingZeros)),
              ].reversed.toList()),
              TableRow(
                  children: [
                Center(
                  child: Text(
                    "اجمالى الانتاج (منتج تام)",
                    style: textStyle,
                  ),
                ),
                Center(
                    child: Text(
                        "${finalproductsBetweenTowDates.isEmpty ? 0 : finalproductsBetweenTowDates.map((e) => e.item.amount * e.item.L * e.item.W * e.item.H / 1000000).reduce((a, b) => a + b).toStringAsFixed(1)}")),
              ].reversed.toList()),
              TableRow(
                  children: [
                Center(
                    child: Text(
                  "اجمالى المتبقى (تحت التشغيل)",
                  style: textStyle,
                )),
                const Center(child: Text("")),
              ].reversed.toList()),
            ],
          ),

          // Table(
          //   columnWidths: const {
          //     0: FlexColumnWidth(1),
          //     1: FlexColumnWidth(1),
          //     2: FlexColumnWidth(1),
          //     3: FlexColumnWidth(2.8),
          //   },
          //   border: TableBorder.all(),
          //   children: blocksconsumedBetweenTowDates
          //       .filter_filter_type_and_density_color()
          //       .map((e) {
          //     var b = vm.volOfResults(finalproductsBetweenTowDates, e);
          //     bb.add(b);
          //     var a = vm.volOfConsumed(blocksconsumedBetweenTowDates, e);
          //     aa.add(a);
          //     return TableRow(
          //         children: [
          //       Center(
          //         child: Text(
          //             "${e.item.color} ${e.item.type} ك ${e.item.density.removeTrailingZeros}"),
          //       ),
          //       Center(child: Text(a.toStringAsFixed(1))),
          //       Center(child: Text(b.toStringAsFixed(1))),
          //       Center(child: Text((a - b).toStringAsFixed(1))),
          //     ].reversed.toList());
          //   }).toList(),
          // ),
          // Table(
          //   columnWidths: const {
          //     0: FlexColumnWidth(1),
          //     1: FlexColumnWidth(1),
          //     2: FlexColumnWidth(1),
          //     3: FlexColumnWidth(2.8),
          //   },
          //   border: TableBorder.all(),
          //   children: [
          //     TableRow(
          //         decoration: const BoxDecoration(color: Colors.grey),
          //         children: [
          //           const Center(child: Text("الاجمالى")),
          //           Center(
          //               child: Text(
          //                   "${aa.isEmpty ? 0 : aa.reduce((a, b) => a + b).toStringAsFixed(1)} ")),
          //           Center(
          //               child: Text(
          //                   "${bb.isEmpty ? 0 : bb.reduce((a, b) => a + b).toStringAsFixed(1)} ")),
          //           Center(
          //               child: Text(((aa.isEmpty
          //                       ? 0
          //                       : aa.reduce((a, b) => a + b) -
          //                           (bb.isEmpty
          //                               ? 0
          //                               : bb.reduce((a, b) => a + b))))
          //                   .toStringAsFixed(1))),
          //         ].reversed.toList()),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class DatepickerTo extends StatelessWidget {
  const DatepickerTo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingController>(
      builder: (context, myType, child) {
        return Column(
          children: [
            TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: context.read<SettingController>().from,
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    context.read<SettingController>().to = pickedDate;
                    context.read<SettingController>().Refresh_Ui();
                  } else {}
                },
                child: Column(
                  children: [
                    const Text(
                      "الى",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.teal),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        myType.to.formatt(),
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 97, 92, 92),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }
}

class DatePickerFrom extends StatelessWidget {
  const DatePickerFrom({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingController>(
      builder: (context, myType, child) {
        return Column(
          children: [
            TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    context.read<SettingController>().from = pickedDate;
                    context.read<SettingController>().Refresh_Ui();
                  } else {}
                },
                child: Column(
                  children: [
                    const Text(
                      "من",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.teal),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        myType.from.formatt(),
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 97, 92, 92),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }
}
