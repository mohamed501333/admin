// ignore_for_file: must_be_immutable
import 'package:collection/collection.dart';
import 'package:date_ranger/date_ranger.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/services/pdfprevei.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/reports/reportsForBlock/%D8%AA%D9%81%D8%A7%D8%B5%D9%8A%D9%84%20%D9%85%D9%82%D8%A7%D8%B3%D8%A7%D8%AA/pdf2.dart';
import 'package:jason_company/ui/reports/reportsForBlock/Bolck_reports_viewModel.dart';
import 'package:provider/provider.dart';

class BlocksSizesDetials extends StatelessWidget {
  BlocksSizesDetials({super.key});
  BlockReportsViewModel vm = BlockReportsViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, myType, child) {
        List<BlockModel> blocks = myType.filterBlocksBalanceBetweenTowDates2();

        return Scaffold(
          appBar: AppBar(actions: [
            IconButton(
                onPressed: () {
                  context.gonext(context, const Datepker2());
                },
                icon: const Icon(Icons.date_range)),
            IconButton(
                onPressed: () {
                  permission().then((value) async {
                    PdfBlockReport3.generate(context, blocks)
                        .then((value) => context.gonext(
                            context,
                            PDfpreview(
                              v: value.save(),
                            )));
                  });
                },
                icon: const Icon(Icons.picture_as_pdf)),
          ], title: const Text("تفاصيل مقاسات مخزن البلوكات")),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: blocks
                      .filter_filter_type_and_density_color()
                      .sortedBy<num>((element) => element.density)
                      .map((e) => Column(
                            children: [
                              //الجزء الاصفر
                              Container(
                                  width: MediaQuery.of(context).size.width * .7,
                                  decoration:
                                      const BoxDecoration(color: Colors.amber),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          vm.sizes(e, blocks).length.toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "ك${e.density.removeTrailingZeros}  ${e.type}  ${e.color}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ))),

                              SizedBox(
                                width: MediaQuery.of(context).size.width * .7,
                                child: Table(
                                  border: TableBorder.all(width: 2),
                                  children: vm
                                      .sizes(e, blocks)
                                      .filter_filter_type_density_color_size()
                                      .sortedBy<num>((element) =>
                                          element.width *
                                          element.hight *
                                          element.lenth)
                                      .map((r) => TableRow(children: [
                                            Center(
                                              child: Text(
                                                "${vm.total_amount_for_single_siz__(r, blocks)} ",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Center(
                                                child: Text(
                                                  "${r.lenth}*${r.width}",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        // border: Border.all(color: Colors.white24, width: 3)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "      grand total :  ${blocks.length} ",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ).permition(context,
            UserPermition.show_Reports_details_of_sizes_of_block_stock);
      },
    );
  }
}

class Datepker2 extends StatelessWidget {
  const Datepker2({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, myType, child) {
        return Scaffold(
            appBar: AppBar(),
            body: SizedBox(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: DateRanger(
                    initialRange: myType.initialDateRange2,
                    onRangeChanged: (range) {
                      myType.initialDateRange = range;

                      myType.filterBlocksBalanceBetweenTowDates2();
                      myType.Refresh_the_UI();
                    },
                  ),
                ),
              ),
            ));
      },
    );
  }
}
