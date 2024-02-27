// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/ui/sR/componants.dart';
import 'package:provider/provider.dart';

import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/sR/Rscissor_viewModel.dart';

class RVeiw2 extends StatelessWidget {
  RVeiw2({
    super.key,
    required this.scissor,
  });
  final int scissor;
  Rscissor_veiwModel vm = Rscissor_veiwModel();

  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, myType, child) {
        List<FractionModel> fractions = vm.getFractions(myType, scissor);
        List<int> AllStages = fractions
            .map((e) => e.stage)
            .toSet()
            .toList()
            .sortedBy<num>((element) => element)
            .reversed
            .toList();
        int lastStage = AllStages.isEmpty ? 0 : AllStages.first;
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(),
                    color: const Color.fromARGB(255, 175, 132, 132)),
                child: Text(
                  "      مقص دائرى ( $scissor )     ",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const Header(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        showmyAlertDialog1414(
                            context, myType, scissor, lastStage + 1);
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 40,
                        color: Colors.deepOrangeAccent,
                      ))
                ],
              ),
              Column(
                children: AllStages.map((e) => Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          color: const Color.fromARGB(255, 231, 223, 223)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .11,
                            child: Center(
                                child: Text(
                              textAlign: TextAlign.center,
                              "$e",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                          Container(
                            // height: 40,
                            width: MediaQuery.of(context).size.width * .59,
                            decoration: const BoxDecoration(
                                border:
                                    Border.symmetric(vertical: BorderSide()),
                                color: Color.fromARGB(255, 231, 223, 223)),
                            child: Center(
                                child: Column(
                              children: [
                                Column(
                                  children: fractions
                                      .where((element) => element.stage == e)
                                      .toList()
                                      .filter_Fractios___()
                                      .map((f) => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "${f.color} ${f.type} ك${f.density.removeTrailingZeros}"),
                                              Text(
                                                  "  ${f.lenth}*${f.wedth}*${f.hight} من "),
                                              Text(
                                                  "${fractions.where((element) => element.stage == f.stage && element.color == f.color && element.type == f.type && element.wedth == f.wedth && element.lenth == f.lenth && element.hight == f.hight).length} "),
                                            ],
                                          ))
                                      .toList(),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showmyAlertDialog1414(
                                              context, myType, scissor, e);
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          size: 30,
                                          color: Colors.deepOrangeAccent,
                                        ))
                                  ],
                                )
                              ],
                            )),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .29,
                            child: Center(
                                child: Column(
                              children: [
                                Column(
                                  children: fractions
                                      .where((element) => element.stage == e)
                                      .expand((s) => s.notfinals)
                                      .toList()
                                      .filter_notfinals___()
                                      .map((f) => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .29,
                                                child: Text(
                                                  "${f.type} kg ${fractions.where((element) => element.stage == e).expand((s) => s.notfinals).where((element) => element.type == f.type).map((e) => e.wight).reduce((n, m) => n + m).toStringAsFixed(2)}",
                                                ),
                                              ),
                                            ],
                                          ))
                                      .toList(),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          dialogOfAddNotFinalToBlock4544(
                                              context,
                                              fractions
                                                  .where((element) =>
                                                      element.stage == e)
                                                  .toList());
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          size: 30,
                                          color: Colors.deepOrangeAccent,
                                        ))
                                  ],
                                )
                              ],
                            )),
                          ),
                        ].reversed.toList(),
                      ),
                    )).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .11,
          height: 40,
          decoration: BoxDecoration(
              border: Border.all(),
              color: const Color.fromARGB(255, 170, 164, 164)),
          child: const Center(
              child: Text(
            "الدور",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width * .60,
          decoration: BoxDecoration(
              border: Border.all(),
              color: const Color.fromARGB(255, 170, 164, 164)),
          child: const Center(
              child: Text(" الوارد ",
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width * .29,
          decoration: BoxDecoration(
              border: Border.all(),
              color: const Color.fromARGB(255, 170, 164, 164)),
          child: const Center(
              child: Text("دون التام",
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ),
      ].reversed.toList(),
    );
  }
}

class Rscissor extends StatelessWidget {
  Rscissor({super.key, required this.scissor});
  final int scissor;
  Rscissor_veiwModel vm = Rscissor_veiwModel();

  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, myType, child) {
        return Row(
          children: [
            SizedBox(
              child: Column(
                children: [
                  const DropDdowen0023(),
                  ElevatedButton(
                      onPressed: () {
                        context.gonext(
                            context,
                            ReportsFroH(
                              scissor: scissor,
                            ));
                      },
                      child: const Text("تقرير"))
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class DropDdowen0023 extends StatelessWidget {
  const DropDdowen0023({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectBoxController>(
      builder: (context, v, child) {
        return DropdownButton(
            value: context.read<ObjectBoxController>().initial2,
            items: v.notfials
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toString()),
                    ))
                .toList(),
            onChanged: (v) {
              if (v != null) {
                context.read<ObjectBoxController>().initial2 = v;
                context.read<ObjectBoxController>().get();
              }
            });
      },
    );
  }
}

class ReportsFroH extends StatelessWidget {
  const ReportsFroH({super.key, required this.scissor});
  final int scissor;
  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, myType, child) {
        List<FractionModel> fractions = myType.blocks
            .map((e) => e.fractions)
            .toList()
            .expand((element) => element)
            .toList()
            .where((element) => element.Rscissor == scissor)
            .where((element) =>
                element.actions
                    .get_Date_of_action(FractionActon.creat_fraction.getTitle)
                    .formatt() ==
                DateTime.now().formatt())
            .toList();

//المنتج التام لهاذا اليوم
        var output = context
            .read<final_prodcut_controller>()
            .finalproducts
            .where((element) =>
                element.actions
                    .get_Date_of_action(finalProdcutAction
                        .incert_finalProduct_from_cutingUnit.getactionTitle)
                    .formatt() ==
                DateTime.now().formatt())
            .where((element) => element.scissor == scissor + 3);
        //اجمالى حجم المنتج التام لهذا اليوم
        double totalOUtput = output.isNotEmpty
            ? output
                .map((e) =>
                    e.lenth *
                    e.width *
                    e.hight *
                    e.density *
                    e.amount /
                    1000000)
                .reduce((a, b) => a + b)
            : 0;

        //اجمالى حجم الفرد لهذا اليوم
        double totalinput = fractions.isNotEmpty
            ? fractions
                .map((element) =>
                    element.lenth *
                    element.wedth *
                    element.hight *
                    element.density /
                    1000000)
                .reduce((a, b) => a + b)
            : 0;
        //هوالك الدائرى فى الفرد
        //اجمالى الهالك
        double totalNotfinal = fractions.isNotEmpty
            ? fractions
                .map((element) => element.notfinals.map((e) => e.wight))
                .expand((element) => element)
                .reduce((a, b) => a + b)
            : 0;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Text(
                "         total input kg     ${totalinput.removeTrailingZeros}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "  total notFinal kg     ${totalNotfinal.removeTrailingZeros}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "         total output kg     ${totalOUtput.removeTrailingZeros}",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        );
      },
    );
  }
}
