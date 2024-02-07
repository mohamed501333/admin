// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/models/moderls.dart';

class BlockReport2 extends StatelessWidget {
  const BlockReport2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: [],
      ),
    );
  }
}

//تقرير كل صبه
class BlockReport3 extends StatelessWidget {
  const BlockReport3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: const [DropDdowen_forCode()],
        ),
        body: Consumer<BlockFirebasecontroller>(
          builder: (context, myType, child) {
            List<BlockModel> blocks = myType.blocks
                .where((element) =>
                    element.serial ==
                    context.read<ObjectBoxController>().serial2)
                .sortedBy<num>((element) => element.number)
                .toList();
            return ListView(children: [
              SingleChildScrollView(
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: Text("اجمالى الصبه : ${blocks.length}"),
                            ),
                            Container(
                              child: Text(
                                  "اجمالى المنصرف : ${blocks.where((element) => element.actions.if_action_exist(BlockAction.consume_block.getactionTitle)).length}"),
                            ),
                            Container(
                              child: Text(
                                  "المتبقى  : ${blocks.length - blocks.where((element) => element.actions.if_action_exist(BlockAction.consume_block.getactionTitle)).length}"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Header(),
                    Column(
                      children: blocks.map((e) => RowItem(item: e)).toList(),
                    )
                  ],
                ),
              )
            ]);
          },
        ));
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
            value: context.read<ObjectBoxController>().serial2,
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
                context.read<ObjectBoxController>().serial2 = v;
                context.read<ObjectBoxController>().get();
                context.read<BlockFirebasecontroller>().Refresh_the_UI();
              }
            });
      },
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("م")),
          ),
          Container(
            width: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("رقم")),
          ),
          Container(
            width: 100,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("كود")),
          ),
          Container(
            width: 150,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("بيان")),
          ),
          Container(
            width: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("كثافه")),
          ),
          Container(
            width: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("لون")),
          ),
          Container(
            width: 80,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("طول")),
          ),
          Container(
            width: 80,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("عرض")),
          ),
          Container(
            width: 80,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("ارتفاع")),
          ),
          Container(
            width: 130,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("ملاحظات")),
          ),
          Container(
            width: 130,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("تاريخ الصرف")),
          ),
        ].reversed.toList(),
      ),
    );
  }
}

class RowItem extends StatelessWidget {
  RowItem({
    Key? key,
    required this.item,
  }) : super(key: key);
  final BlockModel item;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("${1}")),
          ),
          Container(
            width: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text("${item.number}")),
          ),
          Container(
            width: 100,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(item.serial)),
          ),
          Container(
            width: 150,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(item.discreption)),
          ),
          Container(
            width: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(item.density.toString())),
          ),
          Container(
            width: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(item.color)),
          ),
          Container(
            width: 80,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text("${item.lenth}")),
          ),
          Container(
            width: 80,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text("${item.width}")),
          ),
          Container(
            width: 80,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text("${item.hight}")),
          ),
          Container(
            width: 130,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(item.notes)),
          ),
          Container(
            width: 130,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(
                child: Text(item.actions.if_action_exist(
                            BlockAction.consume_block.getactionTitle) ==
                        false
                    ? "غير مصروف"
                    : item.actions
                        .get_Date_of_action(
                            BlockAction.consume_block.getactionTitle)
                        .formatt())),
          ),
        ].reversed.toList(),
      ),
    );
  }
}
