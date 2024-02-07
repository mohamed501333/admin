// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/ui/reports/reportsForBlock/%D8%A7%D9%84%D8%AA%D9%81%D8%A7%D8%B5%D9%8A%D9%84/block_details_view.dart';
import 'package:jason_company/ui/reports/cuttingOrderReports/cutting_orderDetails_view.dart';
import 'package:jason_company/ui/reports/reportsForBlock/%D8%B5%D8%A8%D8%A7%D8%AA%20%D8%A7%D9%84%D8%A8%D9%84%D9%88%D9%83%D8%A7%D8%AA/blockReport2.dart';
import 'package:jason_company/ui/reports/reportsForBlock/Bolck_reports_view.dart';
import 'package:jason_company/ui/reports/reprtsForFinlProuduct/details_of_finalProdcut.dart';
import 'package:jason_company/ui/reports/reprtsForFinlProuduct/finalProductReports_view.dart';
import 'package:jason_company/ui/reports/reprtsForFinlProuduct/scissorsFInalProducts.dart';

import 'تقارير المقصات/scissor_reports_view.dart';

// ignore: must_be_immutable
class ReportsView extends StatelessWidget {
  ReportsView({super.key});

  List<Reportmodel> r = [
    Reportmodel(title: " يومية انتاج تام  ", route: FinalProductReportsview()),
    Reportmodel(
        title: " يومية انتاج تام لكل مقص   ", route: ScissorsFInalProducts()),
    Reportmodel(
        title: "اجماليات البلوكات      ", route: const BlockReportsView()),
    Reportmodel(title: "يومية صرف بلوكات     ", route: DailyBlockReportsView()),
    Reportmodel(
        title: "  تفاصيل مخزن البلوكات     ", route: Block_detaild_view()),
    Reportmodel(
        title: "      تفاصيل مخزن المنتج التام     ",
        route: details_of_finalProdcut()),
    Reportmodel(
        title: "      تفاصيل  اوامر الشغل     ",
        route: CuttingOrderDetailsReports()),
    Reportmodel(
        title: " تقرير  صبات البلوكات     ", route: const BlockReport3()),
    Reportmodel(title: " تقرير   المقصات     ", route: const H_Reports_view()),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: r
              .map(
                (e) => GestureDetector(
                  onTap: () => context.gonext(context, e.route),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          e.title,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.arrow_back),
                      ],
                    ),
                  ),
                ),
              )
              .toList()),
    );
  }
}

class Reportmodel {
  String title;
  Widget route;
  Reportmodel({
    required this.title,
    required this.route,
  });
}
