// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/ui/reports/block%20reports%20details.com/block_details_view.dart';
import 'package:jason_company/ui/reports/reportsForBlock/Bolck_reports_view.dart';
import 'package:jason_company/ui/reports/reportsforH/h_reports_view.dart';
import 'package:jason_company/ui/reports/reprtsForFinlProuduct/finalProductReports_view.dart';
import 'package:jason_company/ui/reports/reprtsForFinlProuduct/scissorsFInalProducts.dart';

// ignore: must_be_immutable
class ReportsView extends StatelessWidget {
  ReportsView({super.key});

  List<Reportmodel> r = [
    Reportmodel(title: " يومية انتاج تام  ", route: FinalProductReportsview()),
    Reportmodel(
        title: " يومية انتاج تام لكل مقص   ", route: ScissorsFInalProducts()),
    Reportmodel(title: " يومية انتاج المقصات الراسى  ", route: HReprotsView()),
    Reportmodel(
        title: "اجماليات البلوكات      ", route: const BlockReportsView()),
    Reportmodel(title: "يومية صرف بلوكات     ", route: DailyBlockReportsView()),
    Reportmodel(
        title: "  تفاصيل مخزن البلوكات     ", route: Block_detaild_view()),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
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
            .toList());
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
