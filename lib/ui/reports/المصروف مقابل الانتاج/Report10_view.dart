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
        List<BlockModel> blocks = context
            .read<BlockFirebasecontroller>()
            .blocks
            .filterConsumeDateBetween(
                DateTimeRange(start: myType.from, end: myType.to));
        // print(myType.from);
        // print(myType.to);
        // print(blocks.length);
        List<FinalProductModel> finalproducts = context
            .read<final_prodcut_controller>()
            .finalproducts
            .filterFinalProductDateBetween(
                DateTimeRange(start: myType.from, end: myType.to));

        // var aa = vm.TotalvolOfConsumed(blocks);
        // var bb = vm.TotalvolOfResults(finalproducts);
        List<double> aa = [];
        List<double> bb = [];
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
                  DatepickerFrom(),
                ],
              ),
              SizedBox(
                width: 350,
                child: Column(
                  children: [
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
                            children: [
                          const Center(child: Text("البيان")),
                          const Center(child: Text("حجم المصروف")),
                          const Center(child: Text("حجم الانتاج")),
                          const Center(child: Text("حجم الفرق")),
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
                      children: blocks
                          .filter_filter_type_and_density_color()
                          .map((e) {
                        var b = vm.volOfResults(finalproducts, e);
                        bb.add(b);
                        var a = vm.volOfConsumed(blocks, e);
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
}

class DatepickerFrom extends StatefulWidget {
  const DatepickerFrom({super.key});

  @override
  State<DatepickerFrom> createState() => _DatepickerState();
}

class _DatepickerState extends State<DatepickerFrom> {
  Rscissor_viewmodel vm = Rscissor_viewmodel();

  @override
  Widget build(BuildContext context) {
    var vm2 = context.read<SettingController>();
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
                setState(() {
                  context.read<SettingController>().from = pickedDate;
                  context.read<SettingController>().Refresh_Ui();
                });
              } else {}
            },
            child: Column(
              children: [
                const Text(
                  "من",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.teal),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    vm2.from.formatt(),
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
  }
}

class DatepickerTo extends StatefulWidget {
  const DatepickerTo({super.key});

  @override
  State<DatepickerTo> createState() => _DatepickerStatef();
}

class _DatepickerStatef extends State<DatepickerTo> {
  Rscissor_viewmodel vm = Rscissor_viewmodel();
  @override
  Widget build(BuildContext context) {
    var vm2 = context.read<SettingController>();

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
                setState(() {
                  context.read<SettingController>().to = pickedDate;
                  context.read<SettingController>().Refresh_Ui();
                });
              } else {}
            },
            child: Column(
              children: [
                const Text(
                  "الى",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.teal),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    vm2.to.formatt(),
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
  }
}
