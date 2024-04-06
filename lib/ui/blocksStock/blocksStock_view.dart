// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable, file_names

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/CategorysController.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/controllers/setting_controller.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

import 'package:jason_company/app/validation.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/blocksStock/outofStock_viewmoder.dart';
import 'package:jason_company/ui/blocksStock/widgets.dart';
import 'package:jason_company/ui/commen/textformfield.dart';
import 'package:jason_company/ui/chips/constans_view.dart';

class BlocksStock extends StatelessWidget {
  BlocksStock({super.key});

  BlocksStockViewModel vm = BlocksStockViewModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  context.gonext(context, Archived());
                },
                icon: const Icon(Icons.archive_sharp)),
            IconButton(
                onPressed: () {
                  settingthedialog(context);
                },
                icon: const Icon(Icons.settings)),
          ],
          title: const Text("رصيد البلوكات"),
        ),
        body: Form(
            key: vm.formKey,
            child: Consumer<SettingController>(
              builder: (context, myType, child) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    myType.GroupvalueofRadio != 1
                        ? const SizedBox()
                        : Column(
                            children: [
                              Fields(vm: vm),
                              Chips(vm: vm),
                              Buttoms(vm: vm),
                            ],
                          ).permition(
                            context, UserPermition.incert_in_block_stock),
                    myType.GroupvalueofRadio != 2
                        ? const SizedBox()
                        : Column(
                            children: [
                              const DropDdowenFor_blockCategory(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomTextFormField(
                                    width:
                                        MediaQuery.of(context).size.width * .16,
                                    hint: "من ",
                                    keybordtupe: TextInputType.number,
                                    controller: vm.from,
                                    validator:
                                        Validation.validatefromTo(context, vm),
                                  ),
                                  CustomTextFormField(
                                    width:
                                        MediaQuery.of(context).size.width * .16,
                                    hint: "الى ",
                                    controller: vm.to,
                                    validator:
                                        Validation.validatefromTo(context, vm),
                                  ),
                                  CustomTextFormField(
                                    width:
                                        MediaQuery.of(context).size.width * .20,
                                    hint: "الطول ",
                                    controller: vm.lenthcontroller,
                                    validator: Validation.validateothers,
                                  ),
                                  CustomTextFormField(
                                    width:
                                        MediaQuery.of(context).size.width * .20,
                                    hint: "العرض",
                                    controller: vm.widthcontroller,
                                    validator: Validation.validateothers,
                                  ),
                                  CustomTextFormField(
                                    width:
                                        MediaQuery.of(context).size.width * .20,
                                    hint: "الارتفاع",
                                    controller: vm.hightncontroller,
                                    validator: Validation.validateothers,
                                  ),
                                ].reversed.toList(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomTextFormField(
                                      keybordtupe: TextInputType.name,
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      hint: "الكود ",
                                      controller: vm.codecontroller,
                                      validator: Validation.validateothers,
                                    ),
                                    CustomTextFormField(
                                      width: MediaQuery.of(context).size.width *
                                          .15,
                                      hint: "الوزن ",
                                      controller: vm.wightcontroller,
                                      validator: Validation.validateothers,
                                    ),
                                    CustomTextFormField(
                                      keybordtupe: TextInputType.name,
                                      width: MediaQuery.of(context).size.width *
                                          .25,
                                      hint: " ملاحظات",
                                      controller: vm.notes,
                                    ),
                                    CustomTextFormField(
                                      keybordtupe: TextInputType.name,
                                      width: MediaQuery.of(context).size.width *
                                          .25,
                                      label: "وارد من",
                                      hint: "الصبه",
                                      controller: vm.cummingFrom,
                                    ),
                                  ].reversed.toList(),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    if (vm.formKey.currentState!.validate() &&
                                        context
                                                .read<Category_controller>()
                                                .initialFordropdowen !=
                                            null) {
                                      vm.incertblock2(
                                        context,
                                      );
                                      vm.clearfields();
                                    }
                                  },
                                  child: const SizedBox(
                                    width: 90,
                                    height: 45,
                                    child: Center(
                                      child: Text(
                                        "اضافة",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                    TheTable(vm: vm),
                  ],
                );
              },
            )),
      ),
    );
  }
}

class Buttoms extends StatelessWidget {
  const Buttoms({
    super.key,
    required this.vm,
  });

  final BlocksStockViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ChipsForBlocks(),
        ElevatedButton(
            onPressed: () {
              if (vm.formKey.currentState!.validate()) {
                vm.incertblock(context);
                vm.clearfields();
              }
            },
            child: const SizedBox(
              width: 90,
              height: 45,
              child: Center(
                child: Text(
                  "اضافة",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            )),
        const SizedBox(
          width: 40,
        ),
        IconButton(
            onPressed: () {
              context
                  .read<BlockFirebasecontroller>();
              context.read<BlockFirebasecontroller>().Refresh_the_UI();
            },
            icon: const Icon(Icons.search)),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}

class Chips extends StatelessWidget {
  const Chips({
    super.key,
    required this.vm,
  });

  final BlocksStockViewModel vm;

  @override
  Widget build(BuildContext context) {
    bool co = context.read<SettingController>().valueOfRadio2;

    return SizedBox(
      height: 100,
      child: Selector<ObjectBoxController, List<ChipBlockModel>>(
        selector: (_, myType) => ObjectBoxController().chips,
        builder: (context, chips, child) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Wrap(
                    spacing: 9,
                    children: chips
                        .map((e) => InkWell(
                              onLongPress: () {
                                context
                                    .read<ObjectBoxController>()
                                    .deletechip(e.id);
                              },
                              onTap: () {
                                co == true
                                    ? vm.incertblockformchip(context, e)
                                    : vm.fillFields(e);
                              },
                              child: Chip(
                                  labelStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  label: Text(e.title.toString())),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Fields extends StatelessWidget {
  const Fields({
    super.key,
    required this.vm,
  });

  final BlocksStockViewModel vm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SizedBox(
        height: 210,
        child: Column(
          children: [
            SizedBox(
              height: 105,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextFormField(
                    keybordtupe: TextInputType.name,
                    width: MediaQuery.of(context).size.width * .16,
                    hint: " البيان",
                    controller: vm.blockdesription,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .16,
                    hint: "الكثافه",
                    controller: vm.densitycontroller,
                    validator: Validation.validateothers,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .16,
                    hint: "اللون",
                    keybordtupe: TextInputType.text,
                    controller: vm.colercontroller,
                    validator: Validation.validateothers,
                  ),
                  CustomTextFormField(
                    keybordtupe: TextInputType.name,
                    width: MediaQuery.of(context).size.width * .16,
                    hint: "الكود ",
                    controller: vm.codecontroller,
                    validator: Validation.validateothers,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .16,
                    hint: "النوع",
                    keybordtupe: TextInputType.name,
                    controller: vm.typecontroller,
                    validator: Validation.validateothers,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .16,
                    hint: "الوزن ",
                    controller: vm.wightcontroller,
                    validator: Validation.validateothers,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 105,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextFormField(
                    keybordtupe: TextInputType.name,
                    width: MediaQuery.of(context).size.width * .16,
                    hint: " ملاحظات",
                    controller: vm.notes,
                  ),
                  CustomTextFormField(
                    keybordtupe: TextInputType.name,
                    width: MediaQuery.of(context).size.width * .16,
                    hint: "وارد من",
                    controller: vm.cummingFrom,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .16,
                    hint: "الارتفاع",
                    controller: vm.hightncontroller,
                    validator: Validation.validateothers,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .16,
                    hint: "العرض",
                    controller: vm.widthcontroller,
                    validator: Validation.validateothers,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .16,
                    hint: "الطول ",
                    controller: vm.lenthcontroller,
                    validator: Validation.validateothers,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .16,
                    hint: "رقم البلوك",
                    controller: vm.blocknumbercontroller,
                    validator: Validation.validate_if_block_exist(context, vm),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TheTable extends StatelessWidget {
  const TheTable({
    super.key,
    required this.vm,
  });
  final BlocksStockViewModel vm;
  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, blocks, child) {
        return Expanded(
          flex: 4,
          child: SingleChildScrollView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 1300,
              child: ListView(
                children: [
                  const HeaderOftable1(),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(.8),
                      1: FlexColumnWidth(1.2),
                      2: FlexColumnWidth(1.2),
                      3: FlexColumnWidth(1),
                      4: FlexColumnWidth(3),
                      5: FlexColumnWidth(3),
                      6: FlexColumnWidth(1),
                      7: FlexColumnWidth(1),
                      8: FlexColumnWidth(1),
                      9: FlexColumnWidth(1.6),
                      10: FlexColumnWidth(.7),
                      11: FlexColumnWidth(.7),
                      12: FlexColumnWidth(1),
                      13: FlexColumnWidth(1),
                      14: FlexColumnWidth(1.8),
                      15: FlexColumnWidth(.8),
                      16: FlexColumnWidth(.8),
                    },
                    children: blocks.search.reversed
                        .sortedBy<num>((element) => element.Block_Id)
                        .reversed
                        .take(context
                            .read<SettingController>()
                            .amountofshowinaddBlock)
                        .toList()
                        .reversed
                        .map((user) {
                          return TableRow(
                              decoration: BoxDecoration(
                                color: blocks.search
                                                .sortedBy<num>((element) =>
                                                    element.Block_Id)
                                                .indexOf(user) %
                                            2 ==
                                        0
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
                                            context
                                                .read<BlockFirebasecontroller>()
                                                .deleteblock(user);
                                          }
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(child: Text(user.notes))),
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
                                      child: Text(user.item.type.toString(),
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600)),
                                    )),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                      child: Text(
                                        user.item.density.toString(),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child:
                                            Text(user.item.color.toString()))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child:
                                            Text(user.item.wight.toString()))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                      child: Text(
                                          "${user.item.H.removeTrailingZeros}*${user.item.W.removeTrailingZeros}*${user.item.L.removeTrailingZeros}"),
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
                                    child: Center(
                                        child: Text(
                                            "${1 + blocks.search.sortedBy<num>((element) => element.Block_Id).indexOf(user)}"))),
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

class Archived extends StatelessWidget {
  Archived({super.key});
  BlocksStockViewModel vm = BlocksStockViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ارشيف المحزوفات"),
      ),
      body: ArchivedTheTable(vm: vm),
    );
  }
}

class ArchivedTheTable extends StatelessWidget {
  const ArchivedTheTable({
    super.key,
    required this.vm,
  });
  final BlocksStockViewModel vm;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<BlockFirebasecontroller>(
          builder: (context, blocks, child) {
            return Expanded(
              flex: 4,
              child: SingleChildScrollView(
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 1300,
                  child: ListView(
                    children: [
                      const HeaderOftable1(),
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(.8),
                          1: FlexColumnWidth(1.2),
                          2: FlexColumnWidth(1.2),
                          3: FlexColumnWidth(1),
                          4: FlexColumnWidth(3),
                          5: FlexColumnWidth(3),
                          6: FlexColumnWidth(1),
                          7: FlexColumnWidth(1),
                          8: FlexColumnWidth(1),
                          9: FlexColumnWidth(1.6),
                          10: FlexColumnWidth(.7),
                          11: FlexColumnWidth(.7),
                          12: FlexColumnWidth(1),
                          13: FlexColumnWidth(1),
                          14: FlexColumnWidth(1.8),
                          15: FlexColumnWidth(.8),
                          16: FlexColumnWidth(.8),
                        },
                        children: blocks.search.reversed
                            .sortedBy<num>((element) => element.actions
                                .get_Date_of_action(
                                    BlockAction.archive_block.getactionTitle)
                                .millisecondsSinceEpoch)
                            .reversed
                            .take(context
                                .read<SettingController>()
                                .amountofshowinaddBlock)
                            .toList()
                            .map((user) {
                              return TableRow(
                                  decoration: BoxDecoration(
                                    color: blocks.search
                                                    .sortedBy<num>((element) =>
                                                        element.Block_Id)
                                                    .indexOf(user) %
                                                2 ==
                                            0
                                        ? Colors.blue[50]
                                        : Colors.amber[50],
                                  ),
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(4),
                                        child: GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<
                                                      BlockFirebasecontroller>()
                                                  .undeleteblock(user);
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))),
                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Center(child: Text(user.notes))),
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
                                            ? Text(DateFormat(
                                                    'dd-MM-yy/hh:mm a')
                                                .format(user.actions
                                                    .get_Date_of_action(
                                                        BlockAction
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
                                            ? Text(user.actions
                                                .get_block_Who_Of(
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
                                            ? Text(DateFormat(
                                                    'dd-MM-yy/hh:mm a')
                                                .format(user.actions
                                                    .get_Date_of_action(
                                                        BlockAction.create_block
                                                            .getactionTitle))
                                                .toString()
                                                .toString()
                                                .toString())
                                            : const SizedBox(),
                                        user.actions.if_action_exist(BlockAction
                                                    .create_block
                                                    .getactionTitle) ==
                                                true
                                            ? Text(user.actions
                                                .get_block_Who_Of(
                                                    BlockAction.create_block))
                                            : const SizedBox(),
                                      ],
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Center(
                                            child:
                                                Text(user.OutTo.toString()))),
                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Center(
                                            child: Text(
                                                user.cumingFrom.toString()))),
                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Center(
                                            child: Text(
                                                user.Hscissor.toString()))),
                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Center(
                                          child: Text(
                                            user.serial.toString(),
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        )),
                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Center(
                                          child: Text(user.item.type.toString(),
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600)),
                                        )),
                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Center(
                                          child: Text(
                                            user.item.density.toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )),
                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Center(
                                            child: Text(
                                                user.item.color.toString()))),
                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Center(
                                            child: Text(
                                                user.item.wight.toString()))),
                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Center(
                                          child: Text(
                                              "${user.item.H.removeTrailingZeros}*${user.item.W.removeTrailingZeros}*${user.item.L.removeTrailingZeros}"),
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
                                        child: Center(
                                            child: Text(
                                                "${1 + blocks.search.sortedBy<num>((element) => element.Block_Id).indexOf(user)}"))),
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
        ),
      ],
    );
  }
}
