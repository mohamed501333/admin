// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names, use_super_parameters
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jason_company/controllers/setting_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/ui/final_product_imported/Widgets.dart';
import 'package:jason_company/ui/final_product_imported/finalProductStock_viewmodel.dart';

// ignore: must_be_immutable
class FinalProductView extends StatelessWidget {
  FinalProductView({super.key});

  FinalProductStockViewModel vm = FinalProductStockViewModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Form(
          key: vm.formKey,
          child: Column(
            children: [
              Fields(vm: vm),
              // Chips2(vm: vm),
              Buttoms(vm: vm),
              TheTable(vm: vm),
            ],
          ),
        ),
      ),
    );
  }
}

class TheTable extends StatelessWidget {
  const TheTable({
    Key? key,
    required this.vm,
  }) : super(key: key);
  final FinalProductStockViewModel vm;
  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, finalproducts, child) {
        int x = 0;

        return Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: SizedBox(
              width: 1100,
              child: ListView(
                children: [
                  const HeaderOftable(),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(3),
                      3: FlexColumnWidth(3),
                      4: FlexColumnWidth(1),
                      5: FlexColumnWidth(1),
                      6: FlexColumnWidth(2),
                      7: FlexColumnWidth(1),
                      8: FlexColumnWidth(1),
                      9: FlexColumnWidth(2),
                      10: FlexColumnWidth(.8),
                      11: FlexColumnWidth(.7),
                    },
                    children: finalproducts.finalproducts
                        .where((element) => element.actions.if_action_exist(
                            finalProdcutAction
                                .incert_finalProduct_from_cutingUnit
                                .getactionTitle))
                        .where((element) =>
                            DateFormat('yyyy/MM/dd').format(element.actions
                                .get_finalProdcutDateOf(finalProdcutAction
                                    .incert_finalProduct_from_cutingUnit)) ==
                            context.read<SettingController>().currentDate())
                        .sortedBy<num>(
                          (element) => element.id,
                        )
                        .map((user) {
                          x++;
                          return TableRow(
                              decoration: BoxDecoration(
                                color:
                                    finalproducts.finalproducts.indexOf(user) %
                                                2 ==
                                            0
                                        ? Colors.teal[50]
                                        : Colors.amber[50],
                              ),
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    child: GestureDetector(
                                        onTap: () {
                                          if (user.actions.if_action_exist(
                                                  finalProdcutAction
                                                      .final_prodcut_DidQalityCheck
                                                      .getactionTitle) ==
                                              false) {
                                            showmyAlertDialog(
                                                context, vm, user, "delete");
                                          }
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))),
                                //تم التخزين
                                GestureDetector(
                                  onTap: () {
                                    user.actions.if_action_exist(
                                                finalProdcutAction
                                                    .final_prodcut_DidQalityCheck
                                                    .getactionTitle) ==
                                            true
                                        ? showmyAlertDialog(
                                            context, vm, user, "stock")
                                        : DoNothingAction();
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Column(
                                        children: [
                                          //icon true if stocked
                                          Icon(user.actions.if_action_exist(
                                                      finalProdcutAction
                                                          .recive_Done_Form_FinalProdcutStock
                                                          .getactionTitle) ==
                                                  true
                                              ? Icons.check
                                              : Icons.close),
                                          // show date when stocked
                                          user.actions.if_action_exist(
                                                      finalProdcutAction
                                                          .recive_Done_Form_FinalProdcutStock
                                                          .getactionTitle) ==
                                                  true
                                              ? Text(DateFormat(
                                                      'dd-MM-yy/hh:mm a')
                                                  .format(user.actions
                                                      .get_finalProdcutDateOf(
                                                          finalProdcutAction
                                                              .incert_finalProduct_from_cutingUnit))
                                                  .toString()
                                                  .toString()
                                                  .toString())
                                              : const SizedBox(),
                                          // show user who stocked
                                          user.actions.if_action_exist(
                                                      finalProdcutAction
                                                          .recive_Done_Form_FinalProdcutStock
                                                          .getactionTitle) ==
                                                  true
                                              ? Text(user.actions
                                                  .get_finalProdcut_Who_Of(
                                                      finalProdcutAction
                                                          .recive_Done_Form_FinalProdcutStock))
                                              : const SizedBox(),
                                        ],
                                      )),
                                ),
                                //تم الجوده
                                GestureDetector(
                                  onTap: () {
                                    user.actions.if_action_exist(finalProdcutAction
                                                    .incert_finalProduct_from_cutingUnit
                                                    .getactionTitle) ==
                                                true &&
                                            user.actions.if_action_exist(
                                                    finalProdcutAction
                                                        .final_prodcut_DidQalityCheck
                                                        .getactionTitle) ==
                                                false
                                        ? showmyAlertDialog(
                                            context, vm, user, "q")
                                        : DoNothingAction();
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Column(
                                        children: [
                                          Icon(user.actions.if_action_exist(
                                                      finalProdcutAction
                                                          .final_prodcut_DidQalityCheck
                                                          .getactionTitle) ==
                                                  true
                                              ? Icons.check
                                              : Icons.close),
                                          user.actions.if_action_exist(
                                                      finalProdcutAction
                                                          .final_prodcut_DidQalityCheck
                                                          .getactionTitle) ==
                                                  true
                                              ? Text(DateFormat(
                                                      'dd-MM-yy/hh:mm a')
                                                  .format(user.actions
                                                      .get_finalProdcutDateOf(
                                                          finalProdcutAction
                                                              .final_prodcut_DidQalityCheck))
                                                  .toString()
                                                  .toString()
                                                  .toString())
                                              : const SizedBox(),
                                          //اليوزر اذا تم الجوده
                                          user.actions.if_action_exist(
                                                      finalProdcutAction
                                                          .final_prodcut_DidQalityCheck
                                                          .getactionTitle) ==
                                                  true
                                              ? Text(user.actions
                                                  .get_finalProdcut_Who_Of(
                                                      finalProdcutAction
                                                          .final_prodcut_DidQalityCheck))
                                              : const SizedBox(),
                                        ],
                                      )),
                                ),
                                //تم الاستلام
                                GestureDetector(
                                  onTap: () {
                                    //TOO:
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Column(
                                        children: [
                                          Icon(user.actions.if_action_exist(
                                                      finalProdcutAction
                                                          .incert_finalProduct_from_cutingUnit
                                                          .getactionTitle) ==
                                                  true
                                              ? Icons.check
                                              : Icons.close),
                                          user.actions.if_action_exist(
                                                      finalProdcutAction
                                                          .incert_finalProduct_from_cutingUnit
                                                          .getactionTitle) ==
                                                  true
                                              ? Text(DateFormat(
                                                      'dd-MM-yy/hh:mm a')
                                                  .format(user.actions
                                                      .get_finalProdcutDateOf(
                                                          finalProdcutAction
                                                              .incert_finalProduct_from_cutingUnit))
                                                  .toString()
                                                  .toString()
                                                  .toString())
                                              : const SizedBox(),
                                          //اليوزر اذا تم الاستلام
                                          user.actions.if_action_exist(
                                                      finalProdcutAction
                                                          .incert_finalProduct_from_cutingUnit
                                                          .getactionTitle) ==
                                                  true
                                              ? Text(user.actions
                                                  .get_finalProdcut_Who_Of(
                                                      finalProdcutAction
                                                          .incert_finalProduct_from_cutingUnit))
                                              : const SizedBox(),
                                        ],
                                      )),
                                ),

                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(user.scissor.toString()))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(user.density.toString()))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(user.customer.toString()))),
                                Container(
                                    padding: const EdgeInsets.all(1),
                                    child: Center(
                                        child: Text(user.type.toString()))),
                                Container(
                                    padding: const EdgeInsets.all(0),
                                    child: Center(child: Text(user.color))),
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    child: Center(
                                      child: Text(
                                          "${user.hight.removeTrailingZeros}*${user.width.removeTrailingZeros}*${user.lenth.removeTrailingZeros}"),
                                    )),
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    child: Center(
                                      child: Text(
                                        user.amount.toString(),
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 221, 2, 75)),
                                      ),
                                    )),
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    child: Center(child: Text("$x"))),
                              ]);
                        })
                        .toList()
                        .reversed
                        .toList(),
                    border: TableBorder.all(width: 1, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

showmyAlertDialog(BuildContext context, FinalProductStockViewModel vm,
    FinalProductModel item, String casefun) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('  ?'),
          content: const SizedBox(
            height: 200,
            child: Column(children: [
              Text('هل انت متاكد'),
            ]),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No')),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  switch (casefun) {
                    case "c":
                      break;

                    case "q":
                      context
                          .read<final_prodcut_controller>()
                          .quality_done(item);
                      break;
                    case "stock":
                      context
                          .read<final_prodcut_controller>()
                          .recevied_from_finalPrdcut_stck(item);
                      break;
                    case "delete":
                      context
                          .read<final_prodcut_controller>()
                          .deletefinalProudut(item);
                      break;
                  }
                  Navigator.pop(context);
                },
                child: const Text(
                  'yes',
                )),
          ],
        );
      });
}
