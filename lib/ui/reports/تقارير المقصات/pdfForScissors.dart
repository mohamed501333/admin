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
        orientation: PageOrientation.natural,
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
                   Center(
                        child: Text("يومية المقص الراسى(1)",
                            style: const TextStyle(fontSize: 14))),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
             
                    table0(blocks, 3, chosenDate),
         
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
          // element.Hscissor == s &&
          element.actions
                  .get_Date_of_action(BlockAction.cut_block_on_H.getactionTitle)
                  .formatt() ==
              chosenDate)
      .toList();

  List<FractionModel> fractions =a.expand((element) => element.fractions).toList();

  List<NotFinal> notfinals = a.expand((element) => element.stages).expand((e) => e.notfinals).toList();
  scissor_viewmodel vm = scissor_viewmodel();
  double  totalblockvolume =a.map((e) => e.lenth * e.width * e.hight / 1000000).isEmpty? 0: a.map((e) => e.lenth * e.width * e.hight / 1000000).reduce((value, element) => value + element).toStringAsFixed(1).to_double();
  double  totlresultsvolume =a.expand((e) => e.fractions).isEmpty? 0: a.map((e) => e.fractions).expand((element) =>element.map((e) => e.item.L * e.item.W * e.item.H / 1000000)).reduce((a, b) => a + b).toStringAsFixed(1).to_double();
  double  diffrenceofvol=totalblockvolume-totlresultsvolume;
  double  bolckswt=a.map((e) => e.lenth * e.width * e.hight / 1000000).isEmpty ? 0 : a.map((e) => e.density * e.lenth * e.width * e.hight / 1000000).reduce((value, element) => value + element);
  double  resultewt=a.expand((e) => e.fractions).isEmpty ? 0 : a.map((e) => e.fractions).expand((element) => element.map((e) => e.item.density * e.item.L * e.item.W * e.item.H / 1000000)).reduce((a, b) => a + b);
  double  diffrenceofwt=bolckswt-resultewt;

  return Row(children: [
    Column(
    children: [
//الوزن

    Container(
          decoration: BoxDecoration(border: Border.all()),

  child:Row(children: [
    Column(children: [
      Container(
        height: 14,
        width: 90,
        child: Center(child: Text("وزن البلوكات")),
      ),
      Container(
        height: 14,
        width: 50,
        child: Center(
            child: Text(
                " ${bolckswt.toStringAsFixed(1)} kg")),
      ),
    ]),
    
    Column(children: [
      Container(
        height: 14,
        width: 90,
        child: Center(child: Text("وزن النواتج")),
      ),
      Container(
        height: 14,
        width: 50,
        child: Center(
            child: Text(
                "${resultewt.toStringAsFixed(1)} kg ")),
      ),
    ]),
   
      Column(children: [
      Container(
        height: 14,
        width: 90,
        child: Center(child: Text("الفرق")),
      ),
      Container(
        height: 14,
        width: 50,
        child: Center(child: Text("${diffrenceofwt.toStringAsFixed(2)}kg")),
      ),
    ]),
    
    
    ]),
 ),

SizedBox(height: 5),
//الحجم
    Container(
    decoration: BoxDecoration(border: Border.all()),
      child:Row(children: [
        
          Column(children: [
      Container(
        height: 14,
        width: 90,
        child: Center(child: Text("حجم البلوكات")),
      ),
      Container(
        height: 14,
        width: 50,
        child: Center(child: Text(" $totalblockvolume m3")),
      ),
    ]),
    
          Column(children: [
      Container(
        height: 14,
        width: 90,
        child: Center(child: Text("حجم النواتج")),
      ),
      Container(
        height: 14,
        width: 50,
        child: Center(child: Text("$totlresultsvolume m3")),
      ),
    ]),
        
          Column(children: [
      Container(
        height: 14,
        width: 90,
        child: Center(child: Text("الفرق")),
      ),
      Container(
        height: 14,
        width: 50,
        child:Center(child: Text("${diffrenceofvol.toStringAsFixed(1)}m3")),

      ),
    ]),
    
    ]),
 ),
 
  SizedBox(height: 5),
   
   Row(children: [
    Column(children: [
      //نسبة الدرحه الاولى
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
 
   //نسبة  دون التام
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

    ]),
    SizedBox(width: 8),
    Column(children: [
      //دون التام
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
  //اجمالى دون التام
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
                "${a.expand((e) => e.stages).isEmpty ? 0 : a.expand((e) => e.stages).map((e) => e.notfinals).expand((element) => element.map((e) => e.wight)).reduce((a, b) => a + b).toStringAsFixed(1)} kg")),
      ),
    ]),

    ]),
   ]),

    Row(children: [
      Container(
   
        child: Center(child: Text("عدد البلوكات=")),
      ),
      Container(
   
        child: Center(child: Text(" ${a.length}")),
      ),
    ]),
   
    table2(fractions)
  
  ])
  
                     ,table3( fractions)

  
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
                            Text(" ${e.item.L.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.H.removeTrailingZeros}"),
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


table3(List<FractionModel> fractions) {
  scissor_viewmodel vm = scissor_viewmodel();

  return SizedBox(
      width: 210,
      child: Column(children: [
        Center(child: Text("حجم")),
        Table(
          columnWidths: {
            0: const FlexColumnWidth(1),
            3: const FlexColumnWidth(3),
          },
          children: [
            TableRow(
                decoration: const BoxDecoration(color: PdfColors.grey100),
                children: [
                  Container(child: Center(child: Text("البيان"))),
                  Container(
                      color: PdfColors.grey100,
                      padding: const EdgeInsets.all(1),
                      child: Center(child: Text("البلوكات"))),
                  Container(
                      color: PdfColors.grey100,
                      padding: const EdgeInsets.all(1),
                      child: Center(child: Text("النواتج"))),
                  Container(
                      color: PdfColors.grey100,
                      padding: const EdgeInsets.all(1),
                      child: Center(child: Text("الفرق"))),
                ].reversed.toList())
          ],
          border: TableBorder.all(width: 1, color: PdfColors.black),
        ),
        Table(
          columnWidths: {
            0: const FlexColumnWidth(1),
            3: const FlexColumnWidth(3),
          },
          children: fractions
              .filter_Fractios_T_D_C()
              .map(
                (e) => TableRow(
                    children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                            Text(
                                " ${e.item.color} ${e.item.type} ك${e.item.density.removeTrailingZeros}   "),
                          ]))),
                  Container(
                      padding: const EdgeInsets.all(0),
                      child: Center(
                          child: Text(
                              "${vm.total_amount_for_single_siz__fractions(e, fractions)}"))),
                  Container(
                      padding: const EdgeInsets.all(0),
                      child: Center(
                          child: Text(
                              "${vm.total_amount_for_single_siz__fractions(e, fractions)}"))),
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