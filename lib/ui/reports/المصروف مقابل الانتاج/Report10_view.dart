// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
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
    return Consumer<SettingController>(
      builder: (context, myType, child) {
        List<BlockModel> allblocks =
            context.read<BlockFirebasecontroller>().blocks;
        List<Itme> allunderoberationofFirstPeriod =
            allUnderOperationOfFirstPeriod(allblocks, myType, context);

        List<BlockModel> blocksconsumedBetweenTowDates =
            allblocks.filterConsumeDateBetween(
                DateTimeRange(start: myType.from, end: myType.to));
        //---------------------------------------------------------------------------

        List<FinalProductModel> finalproductsBetweenTowDates = context
            .read<final_prodcut_controller>()
            .finalproducts
            .filterFinalProductDateBetween(
                DateTimeRange(start: myType.from, end: myType.to));

        List<double> aa = [];
        List<double> bb = [];
        const textStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w700);
        return Scaffold(
          appBar: AppBar(
            title: const Text("مقارنة الانتاج بالمصروف"),
          ),
          body: Column(
            children: [
              const Row(
                children: [],
              ),
              const Text("تقرير الانتاج مقابل المصروف "),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DatepickerTo(),
                  DatePickerFrom(),
                ],
              ),
              SizedBox(
                width: 350,
                child: Column(
                  children: [
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(2),
                      },
                      border: TableBorder.all(),
                      children: [
                        TableRow(
                            children: [
                          const Center(
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
                          const Center(
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
                          const Center(
                            child: Text(
                              "اجمالى الانتاج (منتج تام)",
                              style: textStyle,
                            ),
                          ),
                          const Center(child: Text("")),
                        ].reversed.toList()),
                        TableRow(
                            children: [
                          const Center(
                              child: Text(
                            "اجمالى المتبقى (تحت التشغيل)",
                            style: textStyle,
                          )),
                          const Center(child: Text("")),
                        ].reversed.toList()),
                      ],
                    ),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                        3: FlexColumnWidth(2.8),
                      },
                      border: TableBorder.all(),
                      children: blocksconsumedBetweenTowDates
                          .filter_filter_type_and_density_color()
                          .map((e) {
                        var b =
                            vm.volOfResults(finalproductsBetweenTowDates, e);
                        bb.add(b);
                        var a =
                            vm.volOfConsumed(blocksconsumedBetweenTowDates, e);
                        aa.add(a);
                        return TableRow(
                            children: [
                          Center(
                            child: Text(
                                "${e.item.color} ${e.item.type} ك ${e.item.density.removeTrailingZeros}"),
                          ),
                          Center(child: Text(a.toStringAsFixed(1))),
                          Center(child: Text(b.toStringAsFixed(1))),
                          Center(child: Text((a - b).toStringAsFixed(1))),
                        ].reversed.toList());
                      }).toList(),
                    ),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                        3: FlexColumnWidth(2.8),
                      },
                      border: TableBorder.all(),
                      children: [
                        TableRow(
                            decoration: const BoxDecoration(color: Colors.grey),
                            children: [
                              const Center(child: Text("الاجمالى")),
                              Center(
                                  child: Text(
                                      "${aa.isEmpty ? 0 : aa.reduce((a, b) => a + b).toStringAsFixed(1)} ")),
                              Center(
                                  child: Text(
                                      "${bb.isEmpty ? 0 : bb.reduce((a, b) => a + b).toStringAsFixed(1)} ")),
                              Center(
                                  child: Text(((aa.isEmpty
                                          ? 0
                                          : aa.reduce((a, b) => a + b) -
                                              (bb.isEmpty
                                                  ? 0
                                                  : bb.reduce(
                                                      (a, b) => a + b))))
                                      .toStringAsFixed(1))),
                            ].reversed.toList()),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  List<Itme> allUnderOperationOfFirstPeriod(List<BlockModel> allblocks,
      SettingController myType, BuildContext context) {
    //---------------------------------------------------------------------------
    List<FractionModel>
        fractionsUnderOperation = //رصيد اول المده من تحت التشغيل
        allblocks
            .expand((r) => r.fractions)
            .toList()
            .ReturnFirstPiriodBalanceOFUnderoperationFractons(
                DateTimeRange(start: myType.from, end: myType.to));
    //---------------------------------------------------------------------------

    List<SubFraction>
        subfractionsUnderoperation = //رصيد اول المده من تحت التشغيل
        context
            .read<BlockFirebasecontroller>()
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
