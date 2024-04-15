// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/validation.dart';
import 'package:jason_company/controllers/bSubfractions.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/ui/commen/textformfield.dart';
import 'package:jason_company/ui/final_product_imported/Widgets.dart';
import 'package:jason_company/ui/sA/Ascissor_Viewmodel.dart';
import 'package:jason_company/ui/sA/conponants.dart';
import 'package:jason_company/ui/sR/Rscissor_view.dart';
import 'package:provider/provider.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/sR/Rscissor_viewModel.dart';

class RVeiw23 extends StatelessWidget {
  RVeiw23({
    super.key,
    required this.Ascissor,
  });
  final int Ascissor;
  Rscissor_veiwModel vm = Rscissor_veiwModel();
  AscissorViewModel vm2 = AscissorViewModel();

  @override
  Widget build(BuildContext context) {
    return Consumer2<final_prodcut_controller, SubFractions_Controller>(
      builder:
          (context, finalprodcutcontroller, subfractionecontroller, child) {
        List<SubFraction> subfractionsCuttedON_A =
            vm2.getSubfractions_cuttedOn_A(subfractionecontroller, 1);
        List<FinalProductModel> finalProdcuts_cuttedON_A = vm2
            .get_finalprodcuts_cuttedON_A(finalprodcutcontroller.finalproducts);
        List<int> AllStages = subfractionsCuttedON_A
            .map((e) => e.Astagenum)
            .toSet()
            .toList()
            .sortedBy<num>((element) => element)
            .reversed
            .toList();
        int lastStage = AllStages.isEmpty ? 0 : AllStages.first;
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(),
                  color: const Color.fromARGB(255, 175, 132, 132)),
              child: const Text(
                "      المقص الاونوماتيك      ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 2,
                child: ListView(
                  children: [
                    const HeaderOfThable(),
                    // ازرار الدور
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              size: 40,
                              color: Color.fromARGB(255, 64, 124, 255),
                            ))
                        // .permition(context,
                        //     UserPermition.Rshow_bottomOFfinalproduct),
                        ,
                        IconButton(
                            onPressed: () {
                              dialog_CuttSubfractions_ON_A(
                                  context,
                                  subfractionecontroller,
                                  Ascissor,
                                  lastStage + 1);
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 40,
                              color: Color.fromARGB(255, 39, 123, 3),
                            ))
                        // .permition(
                        //     context, UserPermition.Rshow_bottomOFFractions),
                      ],
                    ),

                    Column(
                      children: AllStages.map((stage) => Container(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                color:
                                    const Color.fromARGB(255, 231, 223, 223)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //رقم الدور
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .11,
                                  child: Center(
                                      child: Text(
                                    textAlign: TextAlign.center,
                                    "$stage",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                                //الوارد
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .59,
                                  decoration: const BoxDecoration(
                                      border: Border.symmetric(
                                          vertical: BorderSide()),
                                      color:
                                          Color.fromARGB(255, 231, 223, 223)),
                                  child: Center(
                                      child: Column(
                                    children: [
                                      Column(
                                        children: subfractionsCuttedON_A
                                            .where((element) =>
                                                element.Astagenum == stage)
                                            .toList()
                                            .filtersubfractions()
                                            .map((f) => Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        size: 24,
                                                      ),
                                                      color: Colors.red,
                                                    ),
                                                    Text(
                                                        "${f.item.color} ${f.item.type} ك${f.item.density.removeTrailingZeros}"),
                                                    Text(
                                                        "  ${f.item.L.removeTrailingZeros}*${f.item.W.removeTrailingZeros}*${f.item.H.removeTrailingZeros} من "),
                                                    Text(
                                                        "${vm2.getSubfractions_cuttedOn_A_OFAstage(subfractionsCuttedON_A, stage).map((e) => e.item).toList().countOf(f.item)} "),
                                                  ],
                                                ))
                                            .toList(),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                //TODO برمحة زر اضافة سبفراكشن فى الدور
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
                                  width:
                                      MediaQuery.of(context).size.width * .61,
                                  decoration: const BoxDecoration(
                                      border: Border.symmetric(
                                          vertical: BorderSide()),
                                      color:
                                          Color.fromARGB(255, 231, 223, 223)),
                                  child: Center(
                                      child: Column(
                                    children: [
                                      //انتاج المقص من الممنتد التام
                                      Column(
                                        children: finalProdcuts_cuttedON_A
                                            .where((element) =>
                                                element.stage == stage)
                                            .toList()
                                            .filteronfinalproduct()
                                            .map((f) => Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        "${f.item.color} ${f.item.type} ك${f.item.density.removeTrailingZeros}"),
                                                    Text(
                                                        "  ${f.item.L.removeTrailingZeros}*${f.item.W.removeTrailingZeros}*${f.item.H.removeTrailingZeros} من "),
                                                    Text(
                                                        "${finalProdcuts_cuttedON_A.countOf(f)} "),
                                                  ],
                                                ))
                                            .toList(),
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Rscissor_veiwModel vm =
                                                    Rscissor_veiwModel();

                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        insetPadding:
                                                            EdgeInsets.zero,
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        title: const Text(
                                                            'اضافة منتج تام'),
                                                        content: SizedBox(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: 200,
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Form(
                                                              key: vm.formKey,
                                                              child: Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        CustomTextFormField(
                                                                          keybordtupe:
                                                                              TextInputType.name,
                                                                          width:
                                                                              MediaQuery.of(context).size.width * .40,
                                                                          hint:
                                                                              "ملاحظات ",
                                                                          controller:
                                                                              vm.notes,
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            CustomTextFormField(
                                                                              width: MediaQuery.of(context).size.width * .23,
                                                                              hint: "عدد",
                                                                              controller: vm.amountcontroller,
                                                                              validator: Validation.validateothers,
                                                                            ),
                                                                            const Text(
                                                                              "من",
                                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SearchForSize(),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ),
                                                        actions: [
                                                          ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green),
                                                              onPressed: () {
                                                                if (vm.formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  vm.incert_finalProduct_from_cutingUnit(
                                                                      context,
                                                                      stage,
                                                                      7);
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              },
                                                              child: const Text(
                                                                  'ok')),
                                                        ],
                                                      );
                                                    });
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
                                // SizedBox(
                                //   width:
                                //       MediaQuery.of(context).size.width * .29,
                                //   child: Center(
                                //       child: Column(
                                //     children: [
                                //       Column(
                                //         children: fractions
                                //             .where((element) =>
                                //                 element.stagenum == e)
                                //             .expand((s) => s.notfinals)
                                //             .toList()
                                //             .filter_notfinals___()
                                //             .map((f) => Row(
                                //                   mainAxisAlignment:
                                //                       MainAxisAlignment.center,
                                //                   children: [
                                //                     SizedBox(
                                //                       width:
                                //                           MediaQuery.of(context)
                                //                                   .size
                                //                                   .width *
                                //                               .29,
                                //                       child: Text(
                                //                         "${f.type} kg ${fractions.where((element) => element.stagenum == e).expand((s) => s.notfinals).where((element) => element.type == f.type).map((e) => e.wight).reduce((n, m) => n + m).toStringAsFixed(2)}",
                                //                       ),
                                //                     ),
                                //                   ],
                                //                 ))
                                //             .toList(),
                                //       ),
                                //       Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.end,
                                //         children: [
                                //           IconButton(
                                //                   onPressed: () {
                                //                     dialogOfAddNotFinalToBlock4544(
                                //                         context,
                                //                         fractions
                                //                             .where((element) =>
                                //                                 element
                                //                                     .stagenum ==
                                //                                 e)
                                //                             .toList());
                                //                   },
                                //                   icon: const Icon(
                                //                     Icons.add,
                                //                     size: 30,
                                //                     color:
                                //                         Colors.deepOrangeAccent,
                                //                   ))
                                //               .permition(
                                //                   context,
                                //                   UserPermition
                                //                       .Rshow_bottomOFNotfinl)
                                //         ],
                                //       )
                                //     ],
                                //   )),
                                // ),
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
