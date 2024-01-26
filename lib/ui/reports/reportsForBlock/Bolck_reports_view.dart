// ignore_for_file: must_be_immutable, file_names

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/reports/block%20reports%20details.com/block_details_view.dart';
import 'package:jason_company/ui/reports/reportsForBlock/W.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class BlockReportsView extends StatelessWidget {
  const BlockReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تقارير مخزن البلوكات"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            //جدول الاجماليات
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  const HeaderOftable4(),
                  TheTable2(),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 200,
                height: 60,
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(9))),
                child: const Center(
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "جرد مخزن البلوك",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_downward),
                            Icon(Icons.arrow_downward),
                            Icon(Icons.arrow_downward),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Consumer<BlockFirebasecontroller>(
              builder: (context, myType, child) {
                return DefaultTextStyle.merge(
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Table(
                          columnWidths: const {
                            0: FlexColumnWidth(3),
                          },
                          border: TableBorder.all(width: 1),
                          children: const [
                            TableRow(children: [Text("الصف"), Text("الكميه")])
                          ],
                        ),
                        Table(
                            columnWidths: const {
                              0: FlexColumnWidth(3),
                            },
                            border: TableBorder.all(width: 1),
                            children: myType.blocks
                                .where((element) =>
                                    element.actions.if_action_exist(BlockAction
                                        .consume_block.getactionTitle) ==
                                    false)
                                .toList()
                                .filter_description()
                                .sortedBy<num>(
                                    (element) => element.serial.to_int())
                                .sortedBy<String>(
                                    (element) => element.discreption)
                                .map((e) => TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(e.discreption),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "${myType.blocks.where((element) => element.actions.if_action_exist(BlockAction.consume_block.getactionTitle) == false).toList().where((element) => element.discreption == e.discreption).length}"),
                                      ),
                                    ]))
                                .toList()),
                        Table(
                          columnWidths: const {
                            0: FlexColumnWidth(3),
                          },
                          border: TableBorder.all(width: 1),
                          children: [
                            TableRow(children: [
                              const Text("الاجمالى"),
                              Container(
                                color: Colors.grey[500],
                                child: Text(
                                    "${myType.blocks.where((element) => element.actions.if_action_exist(BlockAction.consume_block.getactionTitle) == false).toList().length}"),
                              )
                            ])
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            )

            //جرد مخزن البلوك
            // const BlockStockInventory()
          ],
        ),
      ),
    ).permition(context, UserPermition.show_Reports_totals_of_blocks);
  }
}

class DailyBlockReportsView extends StatelessWidget {
  DailyBlockReportsView({super.key});
  final GlobalKey<SfDataGridState> kkkkk = GlobalKey<SfDataGridState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              createAndopenEXL(kkkkk);
            },
            icon: const Icon(Icons.explicit_outlined),
          )
        ],
        title: const Text(" تقارير يومية بلوكات"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          //جدول الاجماليات
          const HeaderOftable422(),
          TheTable222(),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 200,
              height: 60,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(9))),
              child: const Center(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "  البلوكات المصرفه اليوم",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_downward),
                          Icon(Icons.arrow_downward),
                          Icon(Icons.arrow_downward),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          //جرد مخزن البلوك
          BlockStockInventory22(
            kkkkk: kkkkk,
          )
        ],
      ),
    ).permition(context, UserPermition.show_Reports_consume_boock);
  }
}
