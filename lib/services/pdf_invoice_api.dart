// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:flutter/services.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/setings/Setings.dart';
import 'package:jason_company/ui/final_product_stock/Stock_of_finalProduct_ViewModel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfInvoiceApi {
  static Future<Document> generate(c,
      {required PdfHscissorsdata hscissors,
      required ResultsData resltsdata}) async {
    var data = await rootBundle.load("assets/fonts/HacenTunisia.ttf");
    final iconImage =
        (await rootBundle.load('assets/icon.png')).buffer.asUint8List();
    var arabicFont = Font.ttf(data);
    final pdf = Document();
    const double inch = 72.0;
    const double cm = inch / 2.54;
    pdf.addPage(
      MultiPage(
        textDirection: TextDirection.rtl,
        theme: ThemeData(
            tableCell: TextStyle(font: arabicFont, fontSize: 16),
            defaultTextStyle: TextStyle(font: arabicFont, fontSize: 12)),
        pageFormat: const PdfPageFormat(21.0 * cm, 29.7 * cm, marginAll: 3),
        orientation: PageOrientation.natural,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        build: (context) {
          return [
            Row(children: [
              Image(
                MemoryImage(iconImage),
                height: 100,
                width: 300,
              ),
            ]),
            SizedBox(height: 1 * PdfPageFormat.mm),
            Divider(),
            SizedBox(height: 1 * PdfPageFormat.mm),
            headerOfTitleOfItems(),
            Items()
          ];
        },
      ),
    );
    return pdf;
  }
}
// class PdfInvoiceApi {
//   static Future<Document> generate(c,
//       {required PdfHscissorsdata hscissors,
//       required ResultsData resltsdata}) async {
//     var data = await rootBundle.load("assets/fonts/HacenTunisia.ttf");
//     var arabicFont = Font.ttf(data);
//     final pdf = Document();
//     const double inch = 72.0;
//     const double cm = inch / 2.54;
//     pdf.addPage(
//       MultiPage(
//         textDirection: TextDirection.rtl,
//         theme: ThemeData(
//             tableCell: TextStyle(font: arabicFont, fontSize: 16),
//             defaultTextStyle: TextStyle(font: arabicFont, fontSize: 12)),
//         pageFormat: const PdfPageFormat(21.0 * cm, 29.7 * cm, marginAll: 3),
//         orientation: PageOrientation.natural,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         build: (context) {
//           return [
//             header2(" مقص راسى 1 "),
//             header(),
//             dataforh(hscissors.h1, resltsdata.h1),
//             header2(" مقص راسى 2 "),
//             header(),
//             dataforh(hscissors.h2, resltsdata.h2),
//             header2(" مقص راسى 3 "),
//             header(),
//             dataforh(hscissors.h3, resltsdata.h3),
//             header22(),
//             header222(),
//             Wrap(
//               direction: Axis.vertical,
//               children: header2222(),
//             ),
//             SizedBox(width: 10),
//             Column(children: [
//               // block(c),
//               SizedBox(height: 8),
//               // finalProduct(c),
//             ])
//           ];
//         },
//       ),
//     );
//     return pdf;
//   }
// }

header2(x) {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration:
            BoxDecoration(color: PdfColors.amber100, border: Border.all()),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          SizedBox(
              child: Center(
            child: Text("المنصرف من المخزن"),
          )),
          SizedBox(
              child: Center(
            child: Text(x),
          )),
          SizedBox(
              child: Center(
            child: Text(" النواتج "),
          )),
        ]),
      ));
}

headerOfTitleOfItems() {
  TextStyle style = TextStyle(fontSize: 22);
  return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          color: PdfColors.grey300,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          SizedBox(
              child: Center(
            child: Text("الكميه", style: style),
          )),
          SizedBox(
              child: Center(
            child: Text("الوزن", style: style),
          )),
          SizedBox(
              child: Center(
            child: Text(" الكثافه ", style: style),
          )),
          SizedBox(
              child: Center(
            child: Text(" اللون ", style: style),
          )),
          SizedBox(
              child: Center(
            child: Text("        المقاس        ", style: style),
          )),
        ]),
      ));
}

Items() {
  TextStyle style = TextStyle(fontSize: 19);
  return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          SizedBox(
              child: Center(
            child: Text("الكميه", style: style),
          )),
          SizedBox(
              child: Center(
            child: Text("الوزن", style: style),
          )),
          SizedBox(
              child: Center(
            child: Text(" الكثافه ", style: style),
          )),
          SizedBox(
              child: Center(
            child: Text(" اللون ", style: style),
          )),
          SizedBox(
              child: Center(
            child: Text(" المقاس ", style: style),
          )),
        ]),
      ));
}

Directionality header() {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Row(children: [
      SizedBox(
        width: PdfPageFormat.a4.width * .69,
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(.9),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(.9),
            3: FlexColumnWidth(.9),
            4: FlexColumnWidth(.9),
            5: FlexColumnWidth(.9),
            6: FlexColumnWidth(1),
          },
          border: TableBorder.all(width: 1, color: PdfColors.black),
          children: [
            TableRow(
                decoration: const BoxDecoration(
                  color: PdfColors.grey300,
                ),
                children: [
                  Container(
                      padding: const EdgeInsets.all(2),
                      child: Center(
                        child: Text('عدد',
                            style: const TextStyle(color: PdfColors.red)),
                      )),
                  Container(
                      padding: const EdgeInsets.all(2),
                      child: Center(
                        child: Text('مقاس'),
                      )),
                  Container(
                      padding: const EdgeInsets.all(2),
                      child: Center(
                        child: Text('لون'),
                      )),
                  Container(
                      padding: const EdgeInsets.all(2),
                      child: Center(
                        child: Text('كثافه'),
                      )),
                  Container(
                      padding: const EdgeInsets.all(4),
                      child: Center(
                          child: Center(
                        child: Text('نوع'),
                      ))),
                  Container(
                      padding: const EdgeInsets.all(2),
                      child: Center(
                        child: Text('كود'),
                      )),
                ])
          ],
        ),
      ),
      SizedBox(
        width: PdfPageFormat.a4.width * .3,
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
          },
          border: TableBorder.all(width: 1, color: PdfColors.black),
          children: [
            TableRow(
                decoration: const BoxDecoration(
                  color: PdfColors.grey300,
                ),
                children: [
                  Container(
                      padding: const EdgeInsets.all(2),
                      child: Center(
                        child: Text(" ناتج ",
                            style: const TextStyle(color: PdfColors.red)),
                      )),
                  Container(
                      padding: const EdgeInsets.all(2),
                      child: Center(
                        child: Text('تصنيع'),
                      )),
                ])
          ],
        ),
      ),
    ]),
  );
}

Directionality dataforh(List<PdfHScissors> hscissors, List<Results> results) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Row(children: [
      SizedBox(
        width: PdfPageFormat.a4.width * .69,
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(.9),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(.9),
            3: FlexColumnWidth(.9),
            4: FlexColumnWidth(.9),
            5: FlexColumnWidth(.9),
            6: FlexColumnWidth(1),
          },
          border: TableBorder.all(width: 1, color: PdfColors.black),
          children: hscissors
              .map((e) => TableRow(
                      decoration: const BoxDecoration(
                        color: PdfColors.grey100,
                      ),
                      children: [
                        Container(
                            padding: const EdgeInsets.all(2),
                            child: Center(
                              child: Text('${e.amount}',
                                  style: const TextStyle(color: PdfColors.red)),
                            )),
                        Container(
                            padding: const EdgeInsets.all(2),
                            child: Center(
                              child: Text("${e.hight}*${e.width}*${e.lenth}"),
                            )),
                        Container(
                            padding: const EdgeInsets.all(2),
                            child: Center(
                              child: Text(e.color),
                            )),
                        Container(
                            padding: const EdgeInsets.all(2),
                            child: Center(
                              child: Text('${e.density}'),
                            )),
                        Container(
                            padding: const EdgeInsets.all(4),
                            child: Center(child: Text(e.type))),
                        Container(
                            padding: const EdgeInsets.all(2),
                            child: Center(
                              child: Text('${e.serial}'),
                            )),
                      ]))
              .toList(),
        ),
      ),
      SizedBox(
        width: PdfPageFormat.a4.width * .3,
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
          },
          border: TableBorder.all(width: 1, color: PdfColors.black),
          children: results
              .map((e) => TableRow(
                      decoration: const BoxDecoration(
                        color: PdfColors.grey100,
                      ),
                      children: [
                        Container(
                            padding: const EdgeInsets.all(2),
                            child: Center(
                              child: Text('${e.amount}',
                                  style: const TextStyle(color: PdfColors.red)),
                            )),
                        Center(
                          child: Container(
                              padding: const EdgeInsets.all(2),
                              child: Text("${e.hight}*${e.width}*${e.lenth}")),
                        ),
                      ]))
              .toList(),
        ),
      ),
    ]),
  );
}

FinalProductStock() {
  return Column(children: [
    header22(),
    header222(),
    // header2222(),
  ]);
}

header22() {
  return Container(
      width: PdfPageFormat.a4.width * .30,
      margin: const EdgeInsets.only(top: 10),
      decoration:
          BoxDecoration(color: PdfColors.amber100, border: Border.all()),
      child: Center(
        child: Text("رصيد منتج تام"),
      ));
}

Directionality header222() {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Row(children: [
      SizedBox(
        width: PdfPageFormat.a4.width * .30,
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(1.1),
            2: FlexColumnWidth(1.1),
            3: FlexColumnWidth(1.1),
          },
          border: TableBorder.all(width: 1, color: PdfColors.black),
          children: [
            TableRow(
                decoration: const BoxDecoration(
                  color: PdfColors.grey300,
                ),
                children: [
                  Container(
                      padding: const EdgeInsets.all(2),
                      child: Center(
                        child: Text('مقاس'),
                      )),
                  Container(
                      padding: const EdgeInsets.all(2),
                      child: Center(
                        child: Text('كميه'),
                      )),
                  Container(
                      padding: const EdgeInsets.all(2),
                      child: Center(
                        child: Text('كثافه'),
                      )),
                  Container(
                      padding: const EdgeInsets.all(4),
                      child: Center(
                          child: Center(
                        child: Text('نوع'),
                      ))),
                ])
          ],
        ),
      ),
    ]),
  );
}

// رصيد منتج تام
header2222() {
  stockOfFinalProductsViewModel vm = stockOfFinalProductsViewModel();
  List<FinalProductModel> s = [];
  return vm
      .source(s)
      .map((e) => e.items.map((e) => e.total).reduce((a, b) => a = b) == 0
          ? SizedBox()
          : Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              children: [
                  Center(
                    child: Container(
                      width: 80,
                      child: Center(child: Text(e.name)),
                      decoration: const BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                    ),
                  ),
                  SizedBox(
                      width: PdfPageFormat.a4.width * .30,
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(1.1),
                          2: FlexColumnWidth(1.1),
                          3: FlexColumnWidth(1.1),
                        },
                        border:
                            TableBorder.all(width: 1, color: PdfColors.black),
                        children: e.items
                            .map((e) => TableRow(
                                    decoration: const BoxDecoration(
                                      color: PdfColors.grey100,
                                    ),
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.all(.2),
                                          child: Center(
                                            child: Text(""),
                                          )),
                                      Container(
                                          padding: const EdgeInsets.all(.2),
                                          child: Center(
                                            child: Text('',
                                                style: const TextStyle(
                                                    color: PdfColors.red)),
                                          )),
                                      Container(
                                          padding: const EdgeInsets.all(.2),
                                          child: Center(
                                            child: Text('${e.density}'),
                                          )),
                                      Container(
                                          padding: const EdgeInsets.all(.2),
                                          child: Center(child: Text(e.type))),
                                    ]))
                            .toList(),
                      )),
                ]))
      .toList();
}

//اجمالى يوميهى البلوكات
// block(context) {
//   BlockReportsViewModel vm = BlockReportsViewModel();
//   List<BlockModel> blocks = database.getblocks().filter_date(context);

//   return Container(
//       margin: const EdgeInsets.only(top: 10),
//       width: PdfPageFormat.a4.width * .40,
//       child: Directionality(
//           textDirection: TextDirection.rtl,
//           child: Column(children: [
//             Container(
//                 decoration: BoxDecoration(
//                     color: PdfColors.amber100, border: Border.all()),
//                 child: Center(
//                   child: Text("اجمالى المنصرف من المخزن "),
//                 )),
//             Table(
//               columnWidths: const {
//                 0: FlexColumnWidth(3),
//                 1: FlexColumnWidth(1),
//                 2: FlexColumnWidth(1),
//               },
//               children: blocks.filter_filter_type_and_density().map((e) {
//                 return TableRow(
//                     decoration: const BoxDecoration(
//                       color: 2 % 2 == 0 ? PdfColors.teal50 : PdfColors.amber600,
//                     ),
//                     children: [
//                       Container(
//                           padding: const EdgeInsets.all(1),
//                           child: Center(
//                               child: Text(vm
//                                   .total_spend(blocks, e)
//                                   .toStringAsFixed(4)))),
//                       Container(
//                           padding: const EdgeInsets.all(0),
//                           child: Center(child: Text(e.density.toString()))),
//                       Container(
//                           padding: const EdgeInsets.all(1),
//                           child: Center(child: Text(e.type))),
//                     ]);
//               }).toList(),
//               border: TableBorder.all(width: 1, color: PdfColors.black),
//             ),
//           ])));
// }

//اجمالى وارد تام الصنع
// finalProduct(context) {
//   ReportsViewModel vm = ReportsViewModel();
//   List<FinalProductModel> finalproducts = database
//       .getFinalProuduct()
//       .filter_date(context)
//       .where((element) => element.improted == true)
//       .toList();

//   return SizedBox(
//       width: PdfPageFormat.a4.width * .40,
//       child: Directionality(
//           textDirection: TextDirection.rtl,
//           child: Column(children: [
//             Container(
//                 decoration: BoxDecoration(
//                     color: PdfColors.amber100, border: Border.all()),
//                 child: Center(
//                   child: Text("اجمالى وارد تام الصنع  "),
//                 )),
//             Table(
//               columnWidths: const {
//                 0: FlexColumnWidth(3),
//                 1: FlexColumnWidth(1),
//                 2: FlexColumnWidth(1),
//               },
//               children: finalproducts.filter_type_density().map((e) {
//                 return TableRow(
//                     decoration: const BoxDecoration(
//                       color: PdfColors.teal50,
//                     ),
//                     children: [
//                       Container(
//                           padding: const EdgeInsets.all(4),
//                           child: Center(
//                               child: Text(vm
//                                   .total_finalprodut(finalproducts, e)
//                                   .toStringAsFixed(4)
//                                   .toString()))),
//                       Container(
//                           padding: const EdgeInsets.all(4),
//                           child: Center(child: Text(e.density.toString()))),
//                       Container(
//                           padding: const EdgeInsets.all(4),
//                           child: Center(
//                               child: Text(
//                             e.type,
//                           ))),
//                     ]);
//               }).toList(),
//               border: TableBorder.all(width: 1, color: PdfColors.black),
//             ),
//           ])));
// }
