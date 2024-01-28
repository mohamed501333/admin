// ignore_for_file: file_names, must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';

import 'package:jason_company/ui/blocksStock/outofStock_viewmoder.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

class ReportwForHView extends StatelessWidget {
  ReportwForHView({super.key, required this.scissor});
  BlocksStockViewModel vm = BlocksStockViewModel();
  final int scissor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TheTable0001(
            vm: vm,
            scissor: scissor,
          )
        ],
      ),
    );
  }
}

class TheTable0001 extends StatelessWidget {
  const TheTable0001({
    super.key,
    required this.vm,
    required this.scissor,
  });
  final BlocksStockViewModel vm;
  final int scissor;
  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, blocks, child) {
        int x = 0;
        return Expanded(
          flex: 4,
          child: SingleChildScrollView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 1600,
              child: ListView(
                children: [
                  const HeaderOftable0011(),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                      4: FlexColumnWidth(1),
                      5: FlexColumnWidth(1),
                      6: FlexColumnWidth(3),
                      7: FlexColumnWidth(3),
                      8: FlexColumnWidth(3),
                      9: FlexColumnWidth(3),
                      10: FlexColumnWidth(1),
                      11: FlexColumnWidth(1),
                      12: FlexColumnWidth(1),
                      13: FlexColumnWidth(1),
                      14: FlexColumnWidth(1),
                      15: FlexColumnWidth(1),
                      16: FlexColumnWidth(2),
                      17: FlexColumnWidth(1),
                      18: FlexColumnWidth(1),
                    },
                    children: blocks.blocks
                        .where((element) => element.Hscissor == scissor)
                        .toList()
                        .where((element) =>
                            element.actions.block_action_Stutus(
                                BlockAction.consume_block) ==
                            true)
                        .sortedBy<num>((element) => element.actions
                            .get_Date_of_action(
                                BlockAction.cut_block_on_H.getactionTitle)
                            .millisecondsSinceEpoch)
                        .map((user) {
                          x++;
                          return TableRow(
                              decoration: BoxDecoration(
                                color: x.isEven
                                    ? Colors.blue[50]
                                    : Colors.amber[50],
                              ),
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    child: GestureDetector(
                                        onTap: () {
                                          context
                                              .read<BlockFirebasecontroller>()
                                              .Delete_fraction(block: user);
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(vm
                                            .percentage(user)
                                            .removeTrailingZeros))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(vm
                                            .difrence(user)
                                            .removeTrailingZeros))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(vm
                                            .wight_of_notfinal(user)
                                            .removeTrailingZeros))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(vm
                                            .wight_of_fractions(user)
                                            .removeTrailingZeros))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(user.wight.toString()))),
                                Column(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Icon(user.actions
                                                .if_action_exist(BlockAction
                                                    .consume_block
                                                    .getactionTitle)
                                            ? Icons.check
                                            : Icons.close)),
                                    user.actions.if_action_exist(BlockAction
                                            .consume_block.getactionTitle)
                                        ? Text(DateFormat('dd-MM-yy/hh:mm a')
                                            .format(user.actions
                                                .get_Date_of_action(BlockAction
                                                    .consume_block
                                                    .getactionTitle))
                                            .toString()
                                            .toString()
                                            .toString())
                                        : const SizedBox(),
                                    user.actions.if_action_exist(BlockAction
                                                .consume_block
                                                .getactionTitle) ==
                                            true
                                        ? Text(user.actions.get_block_Who_Of(
                                            BlockAction.consume_block))
                                        : const SizedBox(),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Icon(user.actions
                                                .if_action_exist(BlockAction
                                                    .create_block
                                                    .getactionTitle)
                                            ? Icons.check
                                            : Icons.close)),
                                    user.actions.if_action_exist(BlockAction
                                            .create_block.getactionTitle)
                                        ? Text(DateFormat('dd-MM-yy/hh:mm a')
                                            .format(user.actions
                                                .get_Date_of_action(BlockAction
                                                    .create_block
                                                    .getactionTitle))
                                            .toString()
                                            .toString()
                                            .toString())
                                        : const SizedBox(),
                                    user.actions.if_action_exist(BlockAction
                                                .create_block.getactionTitle) ==
                                            true
                                        ? Text(user.actions.get_block_Who_Of(
                                            BlockAction.create_block))
                                        : const SizedBox(),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Text(user.Hscissor.toString())),
                                    user.actions.if_action_exist(BlockAction
                                            .cut_block_on_H.getactionTitle)
                                        ? Text(DateFormat('dd-MM-yy/hh:mm a')
                                            .format(user.actions
                                                .get_Date_of_action(BlockAction
                                                    .cut_block_on_H
                                                    .getactionTitle))
                                            .toString()
                                            .toString()
                                            .toString())
                                        : const SizedBox(),
                                    user.actions.if_action_exist(BlockAction
                                                .cut_block_on_H
                                                .getactionTitle) ==
                                            true
                                        ? Text(user.actions.get_block_Who_Of(
                                            BlockAction.cut_block_on_H))
                                        : const SizedBox(),
                                  ],
                                ),
                                Column(
                                  children: user.fractions
                                      .map(
                                        (e) => Container(
                                            padding: const EdgeInsets.all(2),
                                            child: Text(
                                                "${e.lenth}*${e.wedth}*${e.hight}")),
                                      )
                                      .toList(),
                                ),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(user.OutTo.toString()))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child:
                                            Text(user.cumingFrom.toString()))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                      child: Text(
                                        user.serial.toString(),
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    )),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                      child: Text(user.type.toString(),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600)),
                                    )),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                      child: Text(
                                        user.density.toString(),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(user.color.toString()))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                      child: Text(
                                          "${user.hight}*${user.width}*${user.lenth}"),
                                    )),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                      child: Text(
                                        user.number.toString(),
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 221, 2, 75)),
                                      ),
                                    )),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(child: Text("${x}"))),
                              ]);
                        })
                        .toList()
                        .reversed
                        .toList(),
                    border: TableBorder.all(width: 1, color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class HeaderOftable0011 extends StatelessWidget {
  const HeaderOftable0011({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
        4: FlexColumnWidth(1),
        5: FlexColumnWidth(1),
        6: FlexColumnWidth(3),
        7: FlexColumnWidth(3),
        8: FlexColumnWidth(3),
        9: FlexColumnWidth(3),
        10: FlexColumnWidth(1),
        11: FlexColumnWidth(1),
        12: FlexColumnWidth(1),
        13: FlexColumnWidth(1),
        14: FlexColumnWidth(1),
        15: FlexColumnWidth(1),
        16: FlexColumnWidth(2),
        17: FlexColumnWidth(1),
        18: FlexColumnWidth(1),
      },
      border: TableBorder.all(width: 1, color: Colors.black),
      children: [
        TableRow(
            decoration: BoxDecoration(
              color: Colors.blue[50],
            ),
            children: [
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text(' حذف'))),
              Container(
                  padding: const EdgeInsets.all(1),
                  child: const Center(
                      child: Text(
                    '% نسبة الهالك ',
                    style: TextStyle(fontSize: 12),
                  ))),
              Container(
                  padding: const EdgeInsets.all(1),
                  child: const Center(
                      child: Text(
                    'فرق الانتاج كج',
                    style: TextStyle(fontSize: 12),
                  ))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('وزن الهالك'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('وزن النواتج'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Text('وزن البلوك')),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('تم الصرف'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('تم الانشاء'))),
              Container(
                  padding: const EdgeInsets.all(1),
                  child: const Center(
                      child: Text(
                    'المقص',
                    style: TextStyle(fontSize: 12),
                  ))),
              Container(
                  padding: const EdgeInsets.all(1),
                  child: const Center(
                      child: Text(
                    'النواتج',
                    style: TextStyle(fontSize: 12),
                  ))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('صادر الى'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('وارد من'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Text('الكود',
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Text('النوع',
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold))),
              Container(
                  padding: const EdgeInsets.all(0),
                  child: const Center(
                    child: Text('الكثافه',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold)),
                  )),
              Container(
                  padding: const EdgeInsets.all(4), child: const Text('لون')),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('مقاس'))),
              Container(
                  padding: const EdgeInsets.all(4), child: const Text('رقم')),
              Container(
                  padding: const EdgeInsets.all(4), child: const Text('م')),
            ])
      ],
    );
  }
}
