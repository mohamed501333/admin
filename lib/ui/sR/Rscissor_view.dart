// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/ui/recources/enums.dart';
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

        List<FractionModel> fractions =vm.getFractions_Cutted_On_Rscissor(myType, Rscissor);
       List<FinalProductModel> finalproducts= context.read<final_prodcut_controller>().SumTheTOw().where((element) => element.scissor==Rscissor+3&&element.actions.get_Date_of_action(finalProdcutAction.incert_finalProduct_from_cutingUnit.getactionTitle).formatt()==DateTime.now().formatt()).toList();
       
          List<int>  a= fractions.map((e) => e.stagenum).toSet().toList();
          List<int>  b= fractions.expand((element) => element.SubFractions).where((element) => element.Rscissor==Rscissor).map((e) => e.Rstagenum).toSet().toList();
          List<int>  c =finalproducts.map((e) => e.stageOfR).toSet().toList();
           List<int>  all=[];
           all.addAll(a);
           all.addAll(b);
           all.addAll(c);
            List<int> AllStages = all.toSet().toList().sortedBy<num>((element) => element).reversed.toList();
             
        int lastStage = AllStages.isEmpty ? 0 : AllStages.first;
        return Column(
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
         
         
          Expanded(child: SingleChildScrollView(
               scrollDirection: Axis.horizontal,
            reverse: true,
            child: SizedBox(
              width: 670,
              child: ListView(
                children: [
                  
               Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
          width: MediaQuery.of(context).size.width * .62,
          decoration: BoxDecoration(
              border: Border.all(),
              color: const Color.fromARGB(255, 170, 164, 164)),
          child: const Center(
              child: Text(" الوارد ",
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width * .62,
          decoration: BoxDecoration(
              border: Border.all(),
              color: const Color.fromARGB(255, 170, 164, 164)),
          child: const Center(
              child: Text(" الصادر ",
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width * .31,
          decoration: BoxDecoration(
              border: Border.all(),
              color: const Color.fromARGB(255, 170, 164, 164)),
          child: const Center(
              child: Text("دون التام",
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ),
      ].reversed.toList(),
    ),
                // الزر
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
              children: AllStages.map((e) => 
              
              Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        color: const Color.fromARGB(255, 231, 223, 223)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //رقم الدور
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
                        //الوارد
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
                        //الصادر
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
                                children: finalproducts
                                    .where((element) => element.stageOfR == e)
                                    .toList()
                                    .filteronfinalproduct()
                                    .map((f) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                "${f.color} ${f.type} ك${f.density.removeTrailingZeros}"),
                                            Text(
                                                "  ${f.lenth.removeTrailingZeros}*${f.width.removeTrailingZeros}*${f.hight.removeTrailingZeros} من "),
                                            Text(
                                                "${finalproducts.where((element) => element.stageOfR == f.stageOfR && element.color == f.color && element.type == f.type && element.width == f.width && element.lenth == f.lenth && element.hight == f.hight).length} "),
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
                       // دون التام
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
            ),
          )),
               
                 
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
