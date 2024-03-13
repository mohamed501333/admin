import 'package:flutter/services.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/reports/%D8%AA%D9%82%D8%A7%D8%B1%D9%8A%D8%B1%20%D8%A7%D9%84%D9%85%D9%82%D8%B5%D8%A7%D8%AA/horizintal/scissor_viewmodel.dart';
import 'package:jason_company/ui/reports/reprtsForFinlProuduct/reports_viewmoder.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfBlockReport123456 {
  static Future<Document> generate(c, List<BlockModel> blocks,
      List<FinalProductModel> finalproducts, chosenDate) async {
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
                    child: Text("يومية المقصات  الدائرى $chosenDate",
                        style: const TextStyle(fontSize: 14)))),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [
                    Center(
                        child: Text("يومية المقص الدائرى(1)",
                            style: const TextStyle(fontSize: 14))),
                    table0(blocks, finalproducts, 4, chosenDate),
                  ]),
                  Column(children: [
                    Center(
                        child: Text("يومية المقص الدائرى(2)",
                            style: const TextStyle(fontSize: 14))),
                    table0(blocks, finalproducts, 5, chosenDate),
                  ]),
                  Column(children: [
                    Center(
                        child: Text("يومية المقص الدائرى(3)",
                            style: const TextStyle(fontSize: 14))),
                    table0(blocks, finalproducts, 6, chosenDate),
                  ]),
                ]),
          ];
        },
      ),
    );
    return pdf;
  }
}

table0(List<BlockModel> b, List<FinalProductModel> finalproducts, int s,
    String chosenDate) {
  //fractions
  List<FractionModel> fractions = b
      .expand((element) => element.fractions)
      .where((element) =>
          element.actions
                  .get_Date_of_action(
                      FractionActon.cut_fraction_OnRscissor.getTitle)
                  .formatt() ==
              chosenDate)
      .toList();
//notfinals

  // List<NotFinalmodel> notfinals =
  //     fractions.expand((element) => element.notfinals).toList();

//حجم الفرد
  scissor_viewmodel vm = scissor_viewmodel();
  var totafractionvolume =
      fractions.map((e) => e.item.L * e.item.W * e.item.H / 1000000).isEmpty
          ? 0
          : fractions
              .map((e) => e.item.L * e.item.W * e.item.H / 1000000)
              .reduce((value, element) => value + element)
              .toStringAsFixed(1)
              .to_double();

  //حجم النواتج

  var totalResultsVolume = finalproducts
          .where((element) =>
              element.actions
                      .get_Date_of_action(finalProdcutAction
                          .incert_finalProduct_from_cutingUnit.getactionTitle)
                      .formatt() ==
                  chosenDate &&
              element.scissor == s)
          .isEmpty
      ? 0
      : finalproducts
          .where((element) =>
              element.actions
                      .get_Date_of_action(finalProdcutAction
                          .incert_finalProduct_from_cutingUnit.getactionTitle)
                      .formatt() ==
                  chosenDate &&
              element.scissor == s)
          .map((e) => e.amount * e.hight * e.lenth * e.width / 1000000)
          .reduce((a, b) => a + b)
          .toStringAsFixed(1)
          .to_double();

  return Column(children: [
    Row(children: [
      Container(
        height: 14,
        width: 80,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(child: Text("عدد الفرد")),
      ),
      Container(
        height: 14,
        width: 50,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(child: Text(" ${fractions.length}")),
      ),
    ]),
    Row(children: [
      Container(
        height: 14,
        width: 80,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(child: Text("حجم الفرد")),
      ),
      Container(
        height: 14,
        width: 50,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(child: Text(" $totafractionvolume m3")),
      ),
    ]),
    Row(children: [
      Container(
        height: 14,
        width: 80,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(child: Text("وزن الفرد")),
      ),
      Container(
        height: 14,
        width: 50,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(
            child: Text(
                " ${fractions.map((e) => e.item.L * e.item.W * e.item.H / 1000000).isEmpty ? 0 : fractions.map((e) => e.item.density * e.item.L * e.item.W * e.item.H / 1000000).reduce((value, element) => value + element).toStringAsFixed(1)} kg")),
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
        child:
            Center(child: Text("${totalResultsVolume.toStringAsFixed(1)} m3")),
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
            child: Text(""
                
                // ${fractions.map((e) => e.item.L * e.item.W * e.item.H / 1000000).isEmpty ? 0 : fractions.map((e) => e.notfinals).expand((element) => element.map((e) => e.wight)).reduce((a, b) => a + b).toStringAsFixed(1)} kg
                )),
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
                "${(100 * totalResultsVolume / totafractionvolume).toStringAsFixed(1)} %")),
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
                "${(100 - (100 * totalResultsVolume / totafractionvolume).toStringAsFixed(1).to_double()).toStringAsFixed(1)} %")),
      ),
    ]),
    // Column(
    //     children: notfinals
    //         .filter_notfinals___()
    //         .map((e) => Container(
    //                 child: Row(children: [
    //               Container(
    //                   height: 14,
    //                   width: 80,
    //                   decoration: BoxDecoration(border: Border.all(width: 1)),
    //                   child: Center(
    //                       child: Text("${vm.get(e.type)}",
    //                           style: const TextStyle(fontSize: 10)))),
    //               Container(
    //                   height: 14,
    //                   width: 50,
    //                   decoration: BoxDecoration(border: Border.all(width: 1)),
    //                   child: Center(
    //                       child: Text(
    //                           "${notfinals.isEmpty ? 0 : vm.total_amount_for_notfinals(e, notfinals).toStringAsFixed(1)} kg",
    //                           style: const TextStyle(fontSize: 10)))),
    //             ])))
    //         .toList()),
   
   
    table2(finalproducts, s)
  ]);
}

table2(List<FinalProductModel> finalproducts, int s) {
  ReportsViewModel vm2 = ReportsViewModel();

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
          children: finalproducts
                  .where((element) => element.scissor == s)
                  .isEmpty
              ? []
              : finalproducts
                  .where((element) => element.scissor == s)
                  .toList()
                  .filteronfinalproduct()
                  .map(
                    (e) => TableRow(
                        children: [
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Center(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                Text(
                                    " ${e.lenth.removeTrailingZeros}*${e.width.removeTrailingZeros}*${e.hight.removeTrailingZeros}"),
                                Text(
                                    " ${e.color} ${e.type} ك${e.density.removeTrailingZeros}   "),
                              ]))),
                      Container(
                          padding: const EdgeInsets.all(0),
                          child: Center(
                              child: Text(
                                  "${vm2.totalofSingleSizeOfsingleScissor(e, finalproducts)}"))),
                    ].reversed.toList()),
                  )
                  .toList(),
          border: TableBorder.all(width: 1, color: PdfColors.black),
        )
      ]));
}
