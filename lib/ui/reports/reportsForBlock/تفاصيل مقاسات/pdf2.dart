import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:jason_company/app/extentions.dart';

import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/reports/reportsForBlock/Bolck_reports_viewModel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfBlockReport3 {
  static Future<Document> generate(c, List<BlockModel> blocks) async {
    var data = await rootBundle.load("assets/fonts/HacenTunisia.ttf");

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
        maxPages: 60,
        margin: const EdgeInsets.symmetric(vertical: 15),
        build: (context) {
          return [
            SizedBox(height: 5),
            Center(
                child: Container(
              child: Text("تفاصيل مقاسات البلوكات ${DateTime.now().formatt2()}",
                  style: const TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                  )),
            )),
            SizedBox(height: 5),
            content(blocks),
            grandtotal(blocks),
          ];
        },
      ),
    );
    return pdf;
  }
}

content(List<BlockModel> blocks) {
  BlockReportsViewModel vm = BlockReportsViewModel();

  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: blocks
        .filter_filter_type_and_density_color()
        .sortedBy<num>((element) => element.density)
        .map((e) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 250,
                    decoration: const BoxDecoration(color: PdfColors.amber),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ك${e.density.removeTrailingZeros}  ${e.type}  ${e.color}",
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            vm.sizes(e, blocks).length.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ))),
                SizedBox(
                  width: 250,
                  child: Table(
                    border: TableBorder.all(width: 2),
                    children: vm
                        .sizes(e, blocks)
                        .filter_filter_type_density_color_size()
                        .sortedBy<num>((element) =>
                            element.width * element.hight * element.lenth)
                        .map((r) => TableRow(children: [
                              Center(
                                child: Text(
                                  "${vm.total_amount_for_single_siz__(r, blocks)} ",
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Center(
                                  child: Text(
                                    "${r.lenth}*${r.width}*${r.hight}",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ]))
                        .toList(),
                  ),
                ),
              ],
            ))
        .toList(),
  ));
}

Center grandtotal(List<BlockModel> blocks) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: PdfColors.black,
            border: Border.all(color: PdfColors.white, width: 3)),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "      grand total :  ${blocks.length} ",
            style: const TextStyle(color: PdfColors.white, fontSize: 18),
          ),
        ),
      ),
    ),
  );
}
