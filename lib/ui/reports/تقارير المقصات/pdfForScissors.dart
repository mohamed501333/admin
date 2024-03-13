import 'package:flutter/services.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/reports/%D8%AA%D9%82%D8%A7%D8%B1%D9%8A%D8%B1%20%D8%A7%D9%84%D9%85%D9%82%D8%B5%D8%A7%D8%AA/horizintal/scissor_viewmodel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfBlockReport123 {
  static Future<Document> generate(
      c, List<BlockModel> blocks, chosenDate) async {
    var data = await rootBundle.load("assets/fonts/HacenTunisia.ttf");
    var arabicFont = Font.ttf(data);
    final pdf = Document();
    const double inch = 72.0;
    const double cm = inch / 2.54;
    pdf.addPage(
      MultiPage(
        textDirection: TextDirection.rtl,
        theme: ThemeData(
            tableCell: TextStyle(font: arabicFont, fontSize: 13),
            defaultTextStyle: TextStyle(font: arabicFont, fontSize: 10)),
        pageFormat: const PdfPageFormat(21.0 * cm, 29.7 * cm, marginAll: 3),
        orientation: PageOrientation.landscape,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        build: (context) {
          return [
            SizedBox(height: 10),
            Center(
                child: Container(
                    decoration: const BoxDecoration(color: PdfColors.grey500),
                    child: Text("يومية المقصات  الراسى $chosenDate",
                        style: const TextStyle(fontSize: 14)))),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [
                    Center(
                        child: Text("يومية المقص الراسى(1)",
                            style: const TextStyle(fontSize: 14))),
                    table0(blocks, 1, chosenDate),
                  ]),
                  Column(children: [
                    Center(
                        child: Text("يومية المقص الراسى(2)",
                            style: const TextStyle(fontSize: 14))),
                    table0(blocks, 2, chosenDate),
                  ]),
                  Column(children: [
                    Center(
                        child: Text("يومية المقص الراسى(3)",
                            style: const TextStyle(fontSize: 14))),
                    table0(blocks, 3, chosenDate),
                  ]),
                ]),
          ];
        },
      ),
    );
    return pdf;
  }
}

table0(List<BlockModel> b, int s, String chosenDate) {
  List<BlockModel> a = b
      .where((element) =>
          element.Hscissor == s &&
          element.actions
                  .get_Date_of_action(BlockAction.cut_block_on_H.getactionTitle)
                  .formatt() ==
              chosenDate)
      .toList();
  List<FractionModel> fractions =
      a.expand((element) => element.fractions).toList();
  List<NotFinalmodel> notfinals =
      a.expand((element) => element.notfinals).toList();
  scissor_viewmodel vm = scissor_viewmodel();
  var totalblockvolume =
      a.map((e) => e.lenth * e.width * e.hight / 1000000).isEmpty
          ? 0
          : a
              .map((e) => e.lenth * e.width * e.hight / 1000000)
              .reduce((value, element) => value + element)
              .toStringAsFixed(1)
              .to_double();

  var totlresultsvolume =
      a.map((e) => e.lenth * e.width * e.hight / 1000000).isEmpty
          ? 0
          : a
              .map((e) => e.fractions)
              .expand((element) =>
                  element.map((e) => e.item.L * e.item.W * e.item.H / 1000000))
              .reduce((a, b) => a + b)
              .toStringAsFixed(1)
              .to_double();

  return Column(children: [
    Row(children: [
      Container(
        height: 14,
        width: 80,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(child: Text("عدد البلوكات")),
      ),
      Container(
        height: 14,
        width: 50,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(child: Text(" ${a.length}")),
      ),
    ]),
    Row(children: [
      Container(
        height: 14,
        width: 80,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(child: Text("حجم البلوكات")),
      ),
      Container(
        height: 14,
        width: 50,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(child: Text(" $totalblockvolume m3")),
      ),
    ]),
    Row(children: [
      Container(
        height: 14,
        width: 80,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(child: Text("وزن البلوكات")),
      ),
      Container(
        height: 14,
        width: 50,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(
            child: Text(
                " ${a.map((e) => e.lenth * e.width * e.hight / 1000000).isEmpty ? 0 : a.map((e) => e.density * e.lenth * e.width * e.hight / 1000000).reduce((value, element) => value + element).toStringAsFixed(1)} kg")),
      ),
    ]),
    Row(children: [
      Container(
        height: 14,
        width: 80,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(child: Text("حجم النواتج")),
      ),
      Container(
        height: 14,
        width: 50,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(child: Text("$totlresultsvolume m3")),
      ),
    ]),
    Row(children: [
      Container(
        height: 14,
        width: 80,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(child: Text("وزن النواتج")),
      ),
      Container(
        height: 14,
        width: 50,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(
            child: Text(
                "${a.map((e) => e.lenth * e.width * e.hight / 1000000).isEmpty ? 0 : a.map((e) => e.fractions).expand((element) => element.map((e) => e.item.density * e.item.L * e.item.W * e.item.H / 1000000)).reduce((a, b) => a + b).toStringAsFixed(2)} kg ")),
      ),
    ]),
    Row(children: [
      Container(
        height: 14,
        width: 80,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(child: Text("اجمالى دون تام")),
      ),
      Container(
        height: 14,
        width: 50,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(
            child: Text(
                "${a.map((e) => e.lenth * e.width * e.hight / 1000000).isEmpty ? 0 : a.map((e) => e.notfinals).expand((element) => element.map((e) => e.wight)).reduce((a, b) => a + b).toStringAsFixed(1)} kg")),
      ),
    ]),
    Row(children: [
      Container(
        height: 14,
        width: 80,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(child: Text("نسبة الدرجه الاولى")),
      ),
      Container(
        height: 14,
        width: 50,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(
            child: Text(
                "${(100 * totlresultsvolume / totalblockvolume).toStringAsFixed(1)} %")),
      ),
    ]),
    Row(children: [
      Container(
        height: 14,
        width: 80,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(child: Text("نسبة  دون التام")),
      ),
      Container(
        height: 14,
        width: 50,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(
            child: Text(
                "${(100 - (100 * totlresultsvolume / totalblockvolume).toStringAsFixed(1).to_double()).toStringAsFixed(1)} %")),
      ),
    ]),
    Column(
        children: notfinals
            .filter_notfinals___()
            .map((e) => Container(
                    child: Row(children: [
                  Container(
                      height: 14,
                      width: 80,
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Center(
                          child: Text("${vm.get(e.type)}",
                              style: const TextStyle(fontSize: 10)))),
                  Container(
                      height: 14,
                      width: 50,
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Center(
                          child: Text(
                              "${notfinals.isEmpty ? 0 : vm.total_amount_for_notfinals(e, notfinals).toStringAsFixed(1)} kg",
                              style: const TextStyle(fontSize: 10)))),
                ])))
            .toList()),
    table2(fractions)
  ]);
}

table2(List<FractionModel> fractions) {
  scissor_viewmodel vm = scissor_viewmodel();

  return SizedBox(
      width: 210,
      child: Column(children: [
        Center(child: Text("النواتج")),
        Table(
          columnWidths: {
            0: const FlexColumnWidth(1),
            1: const FlexColumnWidth(3),
          },
          children: [
            TableRow(
                decoration: const BoxDecoration(color: PdfColors.grey100),
                children: [
                  Container(child: Center(child: Text("البيان"))),
                  Container(
                      color: PdfColors.grey100,
                      padding: const EdgeInsets.all(1),
                      child: Center(child: Text("عدد"))),
                ].reversed.toList())
          ],
          border: TableBorder.all(width: 1, color: PdfColors.black),
        ),
        Table(
          columnWidths: {
            0: const FlexColumnWidth(1),
            1: const FlexColumnWidth(3),
          },
          children: fractions
              .filter_Fractios___()
              .map(
                (e) => TableRow(
                    children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                            Text(" ${e.item.L}*${e.item.W}*${e.item.H}"),
                            Text(
                                " ${e.item.color} ${e.item.type} ك${e.item.density.removeTrailingZeros}   "),
                          ]))),
                  Container(
                      padding: const EdgeInsets.all(0),
                      child: Center(
                          child: Text(
                              "${vm.total_amount_for_single_siz__fractions(e, fractions)}"))),
                ].reversed.toList()),
              )
              .toList(),
          border: TableBorder.all(width: 1, color: PdfColors.black),
        )
      ]));
}
