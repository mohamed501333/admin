// ignore_for_file: public_member_api_docs, sort_constructors_first, camel_case_types
// ignore_for_file: file_names

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/extentions/blockExtentions.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/services/pdfprevei.dart';
import 'package:jason_company/ui/commen/errmsg.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/reports/reportsForBlock/%D8%AA%D9%82%D8%B1%D9%8A%D8%B1%20%D8%A7%D8%B6%D8%A7%D9%81%D8%A7%D8%AA%20%D8%A7%D9%84%D8%A8%D9%84%D9%88%D9%83%D8%A7%D8%AA/featues.dart';
import 'package:jason_company/ui/reports/reportsForBlock/%D8%AA%D9%82%D8%B1%D9%8A%D8%B1%20%D8%A7%D8%B6%D8%A7%D9%81%D8%A7%D8%AA%20%D8%A7%D9%84%D8%A8%D9%84%D9%88%D9%83%D8%A7%D8%AA/pdf.dart';
import 'package:provider/provider.dart';

import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/models/moderls.dart';

//تقرير كل صبه
class BlockReport3 extends StatelessWidget {
  const BlockReport3({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, myType, child) {
        List<BlockModel> blocks = myType.blocks
            .where((element) =>
                element.serial == context.read<ObjectBoxController>().serial2)
            .sortedBy<num>((element) => element.number)
            .toList();
        return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () async {
                    generateAndSaveExcel(blocks);
                  },
                  icon: const Icon(Icons.explicit_outlined),
                ),
                IconButton(
                    onPressed: () {
                      permission().then((value) async {
                        PdfBlockReport2.generate(context, blocks)
                            .then((value) => context.gonext(
                                context,
                                PDfpreview(
                                  v: value.save(),
                                )));
                      });
                    },
                    icon: const Icon(Icons.picture_as_pdf)),
                const DropDdowen_forCode()
              ],
            ),
            body: ListView(children: [
              SingleChildScrollView(
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [   errmsg() ,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("اجمالى الصبه : ${blocks.length}"),
                            Text(
                                "اجمالى المنصرف : ${blocks.where((element) => element.actions.if_action_exist(BlockAction.consume_block.getactionTitle)).length}"),
                            Text(
                                "المتبقى  : ${blocks.length - blocks.where((element) => element.actions.if_action_exist(BlockAction.consume_block.getactionTitle)).length}"),
                          ],
                        ),
                      ],
                    ),
                    const Headerr(),
                    Column(
                      children: blocks
                          .map((e) => RowItem(item: e, i: blocks.indexOf(e)))
                          .toList(),
                    )
                  ],
                ),
              )
            ]));
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

class Headerr extends StatelessWidget {
  const Headerr({super.key});
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
            width: 120,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("كود")),
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
            width: 150,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("بيان")),
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
  const RowItem({
    super.key,
    required this.item,
    required this.i,
  });
  final BlockModel item;
  final int i;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: i % 2 == 1
              ? Colors.white
              : const Color.fromARGB(255, 153, 210, 218)),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text("${i + 1}")),
          ),
          Container(
            width: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text("${item.number}")),
          ),
          Container(
            width: 120,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(item.serial)),
          ),
          Container(
            width: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(item.item.density.toString())),
          ),
          Container(
            width: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(item.item.color)),
          ),
          Container(
            width: 80,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(item.item.L.removeTrailingZeros)),
          ),
          Container(
            width: 80,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(item.item.W.removeTrailingZeros)),
          ),
          Container(
            width: 80,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(item.item.H.removeTrailingZeros)),
          ),
          Container(
            width: 150,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(item.discreption)),
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
                    ? "غير منصرف"
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
