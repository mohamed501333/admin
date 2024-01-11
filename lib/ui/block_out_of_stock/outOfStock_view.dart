// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names, camel_case_types
// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/blocksStock/outofStock_viewmoder.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';
import 'package:jason_company/app/validation.dart';
import 'package:jason_company/ui/commen/textformfield.dart';
import 'package:jason_company/ui/block_out_of_stock/outOfStock_viewModel.dart';

class OutOfStockView extends StatelessWidget {
  OutOfStockView({super.key});
  OutOfStockViewModel vm = OutOfStockViewModel();
  BlocksStockViewModel vm2 = BlocksStockViewModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("صرف بلوكات"),
      ),
      body: Consumer<BlockFirebasecontroller>(
        builder: (context, b, child) {
          return Column(
            children: [
              SizedBox(
                height: 160,
                child: Form(
                  key: vm.formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Fieldss(
                            vm: vm,
                          ),
                          Buttoms(vm: vm)
                        ],
                      ),
                      Column(
                        children: [
                          DropDdowenFor_blockColor(b: b.blocks),
                          const DropDdowen_forCode(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              TheTable0001(vm: vm2, vm2: vm)
            ],
          );
        },
      ),
    ));
  }
}

class Buttoms extends StatelessWidget {
  const Buttoms({
    super.key,
    required this.vm,
  });

  final OutOfStockViewModel vm;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          vm.consumeBlock(context);
        },
        child: const SizedBox(
          width: 90,
          height: 45,
          child: Center(
            child: Text(
              "صرف",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}

class Fieldss extends StatelessWidget {
  const Fieldss({
    super.key,
    required this.vm,
  });

  final OutOfStockViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            CustomTextFormField(
              keybordtupe: TextInputType.name,
              width: MediaQuery.of(context).size.width * .23,
              hint: "صادر الى",
              controller: vm.outTo,
            ),
            const SizedBox(
              width: 20,
            ),
            CustomTextFormField(
              width: MediaQuery.of(context).size.width * .23,
              hint: "رقم البلوك",
              controller: vm.blocknumbercontroller,
              validator:
                  Validation.validate_if_block_in_Stock_or_already_consumed(
                      context, vm),
            ),
          ],
        ),
      ],
    );
  }
}

class TheTable0001 extends StatelessWidget {
  const TheTable0001({
    super.key,
    required this.vm,
    required this.vm2,
  });
  final BlocksStockViewModel vm;
  final OutOfStockViewModel vm2;
  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, blocks, child) {
        int x = 0;
        blocks.runFilter(vm.blocknumbercontroller.text);
        return Expanded(
          flex: 4,
          child: SingleChildScrollView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 1200,
              child: ListView(
                children: [
                  const HeaderOftable001(),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(.8),
                      1: FlexColumnWidth(1.1),
                      2: FlexColumnWidth(1.2),
                      3: FlexColumnWidth(1.2),
                      4: FlexColumnWidth(3),
                      5: FlexColumnWidth(3),
                      6: FlexColumnWidth(1),
                      7: FlexColumnWidth(1),
                      8: FlexColumnWidth(.7),
                      9: FlexColumnWidth(1.3),
                      10: FlexColumnWidth(1),
                      11: FlexColumnWidth(1),
                      12: FlexColumnWidth(1),
                      13: FlexColumnWidth(1),
                      14: FlexColumnWidth(1.8),
                      15: FlexColumnWidth(.8),
                      16: FlexColumnWidth(.8),
                    },
                    children: blocks.blocks.reversed
                        .toList()
                        .filter_date_consumed(context)
                        .sortedBy<DateTime>((element) => element.actions
                            .get_BlockDateOf(BlockAction.consume_block))
                        .where((element) =>
                            element.actions.block_action_Stutus(
                                BlockAction.consume_block) ==
                            true)
                        .map((user) {
                          x++;
                          return TableRow(
                              decoration: BoxDecoration(
                                color: blocks.search.indexOf(user) % 2 == 0
                                    ? Colors.blue[50]
                                    : Colors.amber[50],
                              ),
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    child: GestureDetector(
                                        onTap: () {
                                          if (user.actions.if_action_exist(
                                                  BlockAction.cut_block_on_H
                                                      .getactionTitle) ==
                                              false) {
                                            vm2.unconsumeBlock(context, user);
                                          }
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(
                                            "${user.wight.removeTrailingZeros.to_double() - vm.wight_of_fractions(user).removeTrailingZeros.to_double() - vm.wight_of_notfinal(user).removeTrailingZeros.to_double()}"))),
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
                                                .get_BlockDateOf(
                                                    BlockAction.consume_block))
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
                                                .get_BlockDateOf(
                                                    BlockAction.create_block))
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
                                        child: Text(user.Hscissor.toString()))),
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
                                        child: Text(user.wight.toString()))),
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
                                    child: Center(child: Text("$x"))),
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

class HeaderOftable001 extends StatelessWidget {
  const HeaderOftable001({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(.8),
        1: FlexColumnWidth(1.1),
        2: FlexColumnWidth(1.2),
        3: FlexColumnWidth(1.2),
        4: FlexColumnWidth(3),
        5: FlexColumnWidth(3),
        6: FlexColumnWidth(1),
        7: FlexColumnWidth(1),
        8: FlexColumnWidth(.7),
        9: FlexColumnWidth(1.3),
        10: FlexColumnWidth(1),
        11: FlexColumnWidth(1),
        12: FlexColumnWidth(1),
        13: FlexColumnWidth(1),
        14: FlexColumnWidth(1.8),
        15: FlexColumnWidth(.8),
        16: FlexColumnWidth(.8),
      },
      border: TableBorder.all(width: 1, color: Colors.black),
      children: [
        TableRow(
            decoration: BoxDecoration(
              color: Colors.amber[50],
            ),
            children: [
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text(' حذف'))),
              Container(
                  padding: const EdgeInsets.all(1),
                  child: const Center(
                      child: Text(
                    'فرق الانتاج',
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
                  child: const Center(child: Text('تم الصرف'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('تم الانشاء'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('صادر الى'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('وارد من'))),
              Container(
                  padding: const EdgeInsets.all(1),
                  child: const Center(
                      child: Text(
                    'المقص',
                    style: TextStyle(fontSize: 12),
                  ))),
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
                  padding: const EdgeInsets.all(4), child: const Text('الوزن')),
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

class DropDdowenFor_blockColor extends StatelessWidget {
  const DropDdowenFor_blockColor({super.key, required this.b});
  final List<BlockModel> b;

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectBoxController>(
      builder: (context, myType, child) {
        myType.getBlocks(context);

        return DropdownButton(
            value: context.read<ObjectBoxController>().initialcolor,
            items: myType
                .filtercolor(context.read<BlockFirebasecontroller>().blocks)
                .map((e) => e)
                .toList()
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toString()),
                    ))
                .toList(),
            onChanged: (v) {
              if (v != null) {
                myType.getBlocks(context);
                context.read<ObjectBoxController>().initialcolor = v;
                myType.serial = null;
                context.read<ObjectBoxController>().get();
              }
            });
      },
    );
  }
}

class DropDdowen_forCode extends StatelessWidget {
  const DropDdowen_forCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectBoxController>(
      builder: (context, mytype, child) {
        mytype.getBlocks(context);
        return DropdownButton(
            value: context.read<ObjectBoxController>().serial,
            items: mytype.blocks
                .filterserials()
                .map((e) => e.serial)
                .toList()
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toString()),
                    ))
                .toList(),
            onChanged: (v) {
              if (v != null) {
                mytype.getBlocks(context);
                context.read<ObjectBoxController>().serial = v;
                mytype.getBlocks(context);
                context.read<ObjectBoxController>().get();
              }
            });
      },
    );
  }
}
