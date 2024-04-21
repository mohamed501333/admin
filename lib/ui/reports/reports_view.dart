// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/reports/%D8%A7%D9%84%D9%85%D8%B5%D8%B1%D9%88%D9%81%20%D9%85%D9%82%D8%A7%D8%A8%D9%84%20%D8%A7%D9%84%D8%A7%D9%86%D8%AA%D8%A7%D8%AC/Report10_view.dart';
import 'package:jason_company/ui/reports/%D8%AA%D9%82%D8%A7%D8%B1%D9%8A%D8%B1%20%D8%A7%D9%84%D9%85%D9%82%D8%B5%D8%A7%D8%AA/horizintal/scissor_reports_view.dart';
import 'package:jason_company/ui/reports/%D8%AA%D9%82%D8%A7%D8%B1%D9%8A%D8%B1%20%D8%A7%D9%84%D9%85%D9%82%D8%B5%D8%A7%D8%AA/round/report2.dart';
import 'package:jason_company/ui/reports/%D8%AA%D9%82%D8%A7%D8%B1%D9%8A%D8%B1%20%D8%A7%D9%84%D9%85%D9%82%D8%B5%D8%A7%D8%AA/round/scissor_reports_view.dart';
import 'package:jason_company/ui/reports/%D8%AA%D9%82%D8%A7%D8%B1%D9%8A%D8%B1%20%D9%85%D9%86%D8%AA%D8%AC%20%D8%AA%D8%A7%D9%85/finalprodcutsReportsView.dart';
import 'package:jason_company/ui/reports/reportsForBlock/%D8%A7%D9%84%D8%AA%D9%81%D8%A7%D8%B5%D9%8A%D9%84/block%20reports%20details.com/block_details_view.dart';
import 'package:jason_company/ui/reports/cuttingOrderReports/cutting_orderDetails_view.dart';
import 'package:jason_company/ui/reports/reportsForBlock/%D8%AA%D9%81%D8%A7%D8%B5%D9%8A%D9%84%20%D9%85%D9%82%D8%A7%D8%B3%D8%A7%D8%AA/sizes_details.dart';
import 'package:jason_company/ui/reports/reportsForBlock/%D8%AA%D9%82%D8%B1%D9%8A%D8%B1%20%D8%A7%D8%B6%D8%A7%D9%81%D8%A7%D8%AA%20%D8%A7%D9%84%D8%A8%D9%84%D9%88%D9%83%D8%A7%D8%AA/blockReport2.dart';
import 'package:jason_company/ui/reports/reportsForBlock/Bolck_reports_view.dart';
import 'package:jason_company/ui/reports/reprtsForFinlProuduct/details_of_finalProdcut.dart';
import 'package:jason_company/ui/reports/reprtsForFinlProuduct/finalProductReports_view.dart';
import 'package:jason_company/ui/reports/reprtsForFinlProuduct/scissorsFInalProducts.dart';

// ignore: must_be_immutable
class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Reportmodel> r = [
      Reportmodel(
        title: " تقارير التام  ",
        route: const FinalprodcutsReportsView(),
        permition:
            permitionss(context, UserPermition.show_Reports_finalprodcut),
      ),
      Reportmodel(
        title: " يومية انتاج تام  ",
        route: FinalProductReportsview(),
        permition:
            permitionss(context, UserPermition.show_Reports_finalprodcut),
      ),
      Reportmodel(
        title: " يومية انتاج تام لكل مقص   ",
        route: ScissorsFInalProducts(),
        permition: permitionss(
            context, UserPermition.show_Reports_final_prodcutscisors),
      ),
      Reportmodel(
        title: "اجماليات البلوكات      ",
        route: const BlockReportsView(),
        permition:
            permitionss(context, UserPermition.show_Reports_totals_of_blocks),
      ),
      Reportmodel(
        title: "يومية صرف بلوكات     ",
        route: DailyBlockReportsView(),
        permition:
            permitionss(context, UserPermition.show_Reports_consume_boock),
      ),
      Reportmodel(
        title: "  تفاصيل مخزن البلوكات     ",
        route: Block_detaild_view(),
        permition: permitionss(
            context, UserPermition.show_Reports_details_of_block_stock),
      ),
      Reportmodel(
        title: "  تفاصيل مقاسات البلوكات     ",
        route: BlocksSizesDetials(),
        permition: permitionss(context,
            UserPermition.show_Reports_details_of_sizes_of_block_stock),
      ),
      Reportmodel(
        title: "      تفاصيل مخزن المنتج التام     ",
        route: details_of_finalProdcut(),
        permition: permitionss(
            context, UserPermition.show_Reports_details_of_finalProdcut_stock),
      ),
      Reportmodel(
        title: "      تفاصيل  اوامر الشغل     ",
        route: CuttingOrderDetailsReports(),
        permition: permitionss(
            context, UserPermition.show_Reports_details_of_finalProdcut_stock),
      ),
      Reportmodel(
        title: " تقرير  صبات البلوكات     ",
        route: const BlockReport3(),
        permition:
            permitionss(context, UserPermition.show_Reports_every_serial),
      ),
      Reportmodel(
        title: "  تقرير   المقصات  الراسى     ",
        route: const H_Reports_view(),
        permition: permitionss(context, UserPermition.show_Reports_H),
      ),
      Reportmodel(
        title: "  تقرير   المقصات  الدائرى     ",
        route: const R_Reports_view(),
        permition: permitionss(context, UserPermition.show_Reports_R),
      ),
      Reportmodel(
        title: "2  تقرير   المقصات  الدائرى     ",
        route: Report2ForR(),
        permition: permitionss(context, UserPermition.show_Reports_R),
      ),
      Reportmodel(
        title: "تقرير مقارنة الانتاج بالمصروف      ",
        route: Report10View(),
        permition: permitionss(context,
            UserPermition.show_Reports_Comparison_Of_consumedAndResults),
      ),
    ];
    return SingleChildScrollView(
      child: Column(
          children: r
              .map(
                (e) => e.permition == true
                    ? GestureDetector(
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
                      )
                    : const SizedBox(),
              )
              .toList()),
    );
  }
}

// ignore: must_be_immutable
class Reportmodel extends Widget {
  String title;
  Widget route;
  bool permition;
  Reportmodel({
    required this.title,
    required this.route,
    required this.permition,
  });

  @override
  Element createElement() {
    // TODO: implement createElement
    throw UnimplementedError();
  }
}
