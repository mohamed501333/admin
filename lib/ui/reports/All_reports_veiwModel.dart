// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:jason_company/ui/reports/reprtsForFinlProuduct/reports_viewmoder.dart';

import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/models/moderls.dart';

class AllReportsViewModel {
  //  كل المقصوص من هذا المقاس  على هذا المقص لكل دور
  List<NumAndDescrioption> getIncomingOnScissor(
      BuildContext context, int rcissor, List<FractionModel> fractions) {
    return fractions
        .toList()
        .filter_Fractios___()
        .map((e) => NumAndDescrioption(
              voluem: e.lenth * e.wedth * e.hight,
              total: total_amount_for_single_siz__fractions(e, fractions),
              descrioption:
                  "${e.lenth}*${e.wedth}*${e.hight} ${e.color} ${e.type} D${e.density.removeTrailingZeros}",
            ))
        .toList();
  }

  int total_amount_for_single_siz__fractions(
      FractionModel e, List<FractionModel> fractions) {
    return fractions
        .where(
          (f) =>
              e.color == f.color &&
              e.density == f.density &&
              e.hight == f.hight &&
              e.wedth == f.wedth &&
              e.lenth == f.lenth &&
              e.type == f.type,
        )
        .toList()
        .length;
  }

  List<NumAndDescriptionOfFinal> totalAndDescriptionOfFinal(
      BuildContext context,
      List<FinalProductModel> finalProducts,
      int stage,
      int scissor) {
    ReportsViewModel vm2 = ReportsViewModel();
    List<FinalProductModel> finalProduc = finalProducts
        .where((element) =>
            element.stageOfR == stage && element.scissor == scissor + 3)
        .toList();

    return finalProduc
        .filteronfinalproduct()
        .map((e) => NumAndDescriptionOfFinal(
            total: vm2.totalofSingleSize(e, finalProduc),
            description:
                "${e.lenth.removeTrailingZeros}*${e.width.removeTrailingZeros}*${e.hight.removeTrailingZeros} ${e.color} ${e.type} D${e.density.removeTrailingZeros}",
            volume: e.hight * e.lenth * e.width / 1000000))
        .toList();
  }

  List<NumAndDescriptionOfFinal> totalAndDescriptionOfFinalWithNoStage(
      BuildContext context,
      List<FinalProductModel> finalProducts,
      int scissor) {
    ReportsViewModel vm2 = ReportsViewModel();
    List<FinalProductModel> finalProduc = finalProducts
        .where((element) => element.scissor == scissor + 3)
        .toList();

    return finalProduc
        .filteronfinalproduct()
        .map((e) => NumAndDescriptionOfFinal(
            total: vm2.totalofSingleSize(e, finalProduc),
            description:
                "${e.lenth.removeTrailingZeros}*${e.width.removeTrailingZeros}*${e.hight.removeTrailingZeros} ${e.color} ${e.type} D${e.density.removeTrailingZeros}",
            volume: e.hight * e.lenth * e.lenth / 1000000))
        .toList();
  }
}

class NumAndDescriptionOfFinal {
  final int total;
  final String description;
  final double volume;

  NumAndDescriptionOfFinal(
      {required this.total, required this.description, required this.volume});
}

class All {
  int stage;
  List<NumAndDescrioption> itemsInEeachStage;
  All({
    required this.stage,
    required this.itemsInEeachStage,
  });
}

class NumAndDescrioption {
  final int total;
  int voluem;

  final String descrioption;

  NumAndDescrioption(
      {required this.total, required this.voluem, required this.descrioption});
}
