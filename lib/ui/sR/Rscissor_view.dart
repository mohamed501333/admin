// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/ui/sR/componants.dart';
import 'package:provider/provider.dart';

import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/sR/Rscissor_viewModel.dart';

class RVeiw2 extends StatelessWidget {
  RVeiw2({
    super.key,
    required this.Rscissor,
  });
  final int Rscissor;
  Rscissor_veiwModel vm = Rscissor_veiwModel();

  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, myType, child) {
        List<FractionModel> fractions =
            vm.getFractions_Cutted_On_Rscissor(myType, Rscissor);
        List<int> AllStages = fractions
            .map((e) => e.stagenum)
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
                  "      مقص دائرى ( $Rscissor )     ",
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
                            context, myType, Rscissor, lastStage + 1);
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
                                      .where((element) => element.stagenum == e)
                                      .toList()
                                      .filter_Fractios___()
                                      .map((f) => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "${f.item.color} ${f.item.type} ك${f.item.density.removeTrailingZeros}"),
                                              Text(
                                                  "  ${f.item.L.removeTrailingZeros}*${f.item.W.removeTrailingZeros}*${f.item.H.removeTrailingZeros} من "),
                                              Text(
                                                  "${fractions.where((element) => element.stagenum == f.stagenum && element.item.color == f.item.color && element.item.type == f.item.type && element.item.W == f.item.W && element.item.L == f.item.L && element.item.H == f.item.H).length} "),
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
                                              context, myType, Rscissor, e);
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
                                      .where((element) => element.stagenum == e)
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
                                                  "${f.type} kg ${fractions.where((element) => element.stagenum == e).expand((s) => s.notfinals).where((element) => element.type == f.type).map((e) => e.wight).reduce((n, m) => n + m).toStringAsFixed(2)}",
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
                                                      element.stagenum == e)
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
