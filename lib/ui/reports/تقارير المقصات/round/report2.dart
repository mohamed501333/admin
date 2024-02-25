// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/ui/reports/All_reports_veiwModel.dart';

class Report2ForR extends StatelessWidget {
  Report2ForR({super.key});
  AllReportsViewModel vm = AllReportsViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 700,
                child: ListView(
                  children: [
                    Text("الدائرى 1"),
                    Table(
                      border: TableBorder.all(width: 1, color: Colors.black),
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(3),
                        2: FlexColumnWidth(3),
                        3: FlexColumnWidth(.2),
                      },
                      children: vm
                          .getIncomingOnScissor(context, 1)
                          .sortedBy<num>((element) => element.stage)
                          .map((e) => TableRow(
                                children: [
                                  Center(child: Text("${e.stage}")),
                                  Container(
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: e.itemsInEeachStage
                                          .map((e) => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    color: Colors.grey.shade400,
                                                    child: Text(
                                                        "حجم${(e.total * e.voluem / 1000000).toStringAsFixed(1)}"),
                                                  ),
                                                  Text(e.descrioption),
                                                  const Text("من"),
                                                  Text("${e.total}"),
                                                ],
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                  Container(
                                    child: Text("1"),
                                  ),
                                  Container(
                                    child: Center(child: Text("2")),
                                  )
                                ].reversed.toList(),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
