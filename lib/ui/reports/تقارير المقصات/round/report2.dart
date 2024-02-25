// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/main.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/services/pdfprevei.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/reports/%D8%AA%D9%82%D8%A7%D8%B1%D9%8A%D8%B1%20%D8%A7%D9%84%D9%85%D9%82%D8%B5%D8%A7%D8%AA/round/report2pdf.dart';
import 'package:jason_company/ui/reports/All_reports_veiwModel.dart';
import 'package:provider/provider.dart';

class Report2ForR extends StatefulWidget {
  Report2ForR({super.key});

  @override
  State<Report2ForR> createState() => _Report2ForRState();
}

class _Report2ForRState extends State<Report2ForR> {
  AllReportsViewModel vm = AllReportsViewModel();

  @override
  Widget build(BuildContext context) {
    String chosenDate = format.format(DateTime.now());

    List<FinalProductModel> finalProdcuts = finalprodcuts(context, chosenDate);

    List<FractionModel> fractions1 = frac(context, 1, chosenDate);
    List<int> allStages1 = allstage(fractions1, finalProdcuts);

    List<FractionModel> fractions2 = frac(context, 2, chosenDate);
    List<int> allStages2 = allstage(fractions2, finalProdcuts);

    List<FractionModel> fractions3 = frac(context, 3, chosenDate);
    List<int> allStages3 = allstage(fractions3, finalProdcuts);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                permission().then((value) async {
                  Pdf2ForR.generate(
                          context,
                          allStages1,
                          allStages2,
                          allStages3,
                          vm,
                          fractions1,
                          fractions2,
                          fractions3,
                          finalProdcuts,
                          chosenDate)
                      .then((value) => context.gonext(
                          context,
                          PDfpreview(
                            v: value.save(),
                          )));
                });
              },
              icon: const Icon(Icons.picture_as_pdf)),
          TextButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  setState(() {
                    String formattedDate = format.format(pickedDate);
                    chosenDate = formattedDate;
                  });
                } else {}
              },
              child: Text(
                chosenDate,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              )),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 800,
                child: ListView(
                  children: [
                    Details(
                        allStages: allStages1,
                        vm: vm,
                        scissor: 1,
                        fractions: fractions1,
                        finalProdcuts: finalProdcuts),
                    Details(
                        allStages: allStages2,
                        vm: vm,
                        scissor: 2,
                        fractions: fractions2,
                        finalProdcuts: finalProdcuts),
                    Details(
                        allStages: allStages3,
                        vm: vm,
                        scissor: 3,
                        fractions: fractions3,
                        finalProdcuts: finalProdcuts),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<int> allstage(
      List<FractionModel> fractions, List<FinalProductModel> finalProdcuts) {
    List<int> allStages = fractions.map((e) => e.stage).toList() +
        finalProdcuts.map((e) => e.stageOfR).toList();
    return allStages;
  }

  List<FractionModel> frac(
      BuildContext context, int scissor, String chosenDate) {
    List<FractionModel> fractions = context
        .read<BlockFirebasecontroller>()
        .blocks
        .expand((element) => element.fractions)
        .where((element) =>
            element.Rscissor == scissor &&
            element.actions
                    .get_Date_of_action(
                        FractionActon.cut_fraction_OnRscissor.getTitle)
                    .formatt() ==
                chosenDate)
        .toList();
    return fractions;
  }

  List<FinalProductModel> finalprodcuts(
      BuildContext context, String chosenDate) {
    List<FinalProductModel> finalProdcuts = context
        .read<final_prodcut_controller>()
        .finalproducts
        .where((element) =>
            element.actions
                .get_Date_of_action(finalProdcutAction
                    .incert_finalProduct_from_cutingUnit.getactionTitle)
                .formatt() ==
            chosenDate)
        .toList();
    return finalProdcuts;
  }
}

class Details extends StatelessWidget {
  Details({
    super.key,
    required this.allStages,
    required this.vm,
    required this.scissor,
    required this.fractions,
    required this.finalProdcuts,
  });

  final List<int> allStages;
  final AllReportsViewModel vm;
  final int scissor;
  final List<FractionModel> fractions;
  final List<FinalProductModel> finalProdcuts;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: Text("الدائرى $scissor")),
        Table(
          border: TableBorder.all(width: 1, color: Colors.black),
          columnWidths: const {
            0: FlexColumnWidth(1.3),
            1: FlexColumnWidth(3),
            2: FlexColumnWidth(3),
            3: FlexColumnWidth(.3),
          },
          children: const [
            TableRow(decoration: BoxDecoration(color: Colors.amber), children: [
              Center(child: Text("دون التام")),
              Center(child: Text("الناتج")),
              Center(child: Text("الوارد")),
              Center(child: Text("دور")),
            ])
          ],
        ),
        Table(
          border: TableBorder.all(width: 1, color: Colors.black),
          columnWidths: const {
            0: FlexColumnWidth(1.3),
            1: FlexColumnWidth(3),
            2: FlexColumnWidth(3),
            3: FlexColumnWidth(.3),
          },
          children: allStages
              .toSet()
              .toList()
              .sortedBy<num>((element) => element)
              .map((k) => TableRow(
                    children: [
                      Center(child: Text("$k")),
                      //الوارد
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: vm
                            .getIncomingOnScissor(
                                context,
                                scissor,
                                fractions
                                    .where((element) => element.stage == k)
                                    .toList())
                            .map((e) => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                      //التام
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: vm
                            .totalAndDescriptionOfFinal(
                                context, finalProdcuts, k, scissor)
                            .map((e) => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: Colors.grey.shade400,
                                      child: Text(
                                          "حجم${(e.total * e.volume).toStringAsFixed(1)}"),
                                    ),
                                    Text(e.description),
                                    const Text("من"),
                                    Text("${e.total}"),
                                  ],
                                ))
                            .toList(),
                      ),
                      //دون التام
                      Column(
                        children: fractions
                            .where((element) => element.stage == k)
                            .expand((s) => s.notfinals)
                            .toList()
                            .filter_notfinals___()
                            .map((f) => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .29,
                                      child: Text(
                                        "${f.type} kg ${fractions.where((element) => element.stage == k).expand((s) => s.notfinals).where((element) => element.type == f.type).map((e) => e.wight).reduce((n, m) => n + m).removeTrailingZeros}",
                                      ),
                                    ),
                                  ],
                                ))
                            .toList(),
                      )
                    ].reversed.toList(),
                  ))
              .toList(),
        ),
        Table(
          border: TableBorder.all(width: 1, color: Colors.black),
          columnWidths: const {
            0: FlexColumnWidth(1.3),
            1: FlexColumnWidth(3),
            2: FlexColumnWidth(3),
            3: FlexColumnWidth(.3),
          },
          children: const [
            TableRow(decoration: BoxDecoration(color: Colors.amber), children: [
              Center(child: Text("اجمالى دون التام")),
              Center(child: Text("اجمالى الناتج")),
              Center(child: Text("اجمالى الوارد")),
            ])
          ],
        ),
        Table(
          border: TableBorder.all(width: 1, color: Colors.black),
          columnWidths: const {
            0: FlexColumnWidth(1.3),
            1: FlexColumnWidth(3),
            2: FlexColumnWidth(3),
            3: FlexColumnWidth(.3),
          },
          children: [
            TableRow(
              children: [
                //الوارد
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: vm
                      .getIncomingOnScissor(context, scissor, fractions)
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                            ),
                          ))
                      .toList(),
                ),

                // التام

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: vm
                      .totalAndDescriptionOfFinalWithNoStage(
                          context, finalProdcuts, scissor)
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  color: Colors.grey.shade400,
                                  child: Text(
                                      "حجم${(e.total * e.volume).toStringAsFixed(1)}"),
                                ),
                                Text(e.description),
                                const Text("من"),
                                Text("${e.total}"),
                              ],
                            ),
                          ))
                      .toList(),
                ),
                //دون التام
                Column(
                  children: fractions
                      .expand((s) => s.notfinals)
                      .toList()
                      .filter_notfinals___()
                      .map((f) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .29,
                                child: Text(
                                  "${f.type} kg ${fractions.expand((s) => s.notfinals).where((element) => element.type == f.type).map((e) => e.wight).reduce((n, m) => n + m).removeTrailingZeros}",
                                ),
                              ),
                            ],
                          ))
                      .toList(),
                )
              ].reversed.toList(),
            ),
            TableRow(
                decoration: const BoxDecoration(color: Colors.grey),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        "${vm.getIncomingOnScissor(context, scissor, fractions).map((e) => e.total * e.voluem / 1000000).isEmpty ? 0 : vm.getIncomingOnScissor(context, scissor, fractions).map((e) => e.total * e.voluem / 1000000).reduce((a, b) => a + b).removeTrailingZeros}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                          "${vm.totalAndDescriptionOfFinalWithNoStage(context, finalProdcuts, scissor).map((e) => e.volume * e.total).isEmpty ? 0 : vm.totalAndDescriptionOfFinalWithNoStage(context, finalProdcuts, scissor).map((e) => e.volume * e.total).reduce((a, b) => a + b).removeTrailingZeros}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                          " kg ${fractions.expand((s) => s.notfinals).map((e) => e.wight).reduce((n, m) => n + m).removeTrailingZeros}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                    ),
                  ),
                ].reversed.toList())
          ],
        ),
      ],
    );
  }
}
