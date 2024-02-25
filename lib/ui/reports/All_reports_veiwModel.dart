// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/models/moderls.dart';

class AllReportsViewModel {
  //  كل المقصوص من هذا المقاس  على هذا المقص لكل دور
  List<All> getIncomingOnScissor(BuildContext context, int rcissor) {
    List<FractionModel> fractions = context
        .read<BlockFirebasecontroller>()
        .blocks
        .expand((element) => element.fractions)
        .where((element) => element.Rscissor == rcissor)
        .toList();

    return fractions
        .map((f) => f.stage)
        .toSet()
        .toList()
        .map((e) => All(
            stage: e,
            itemsInEeachStage: fractions
                .where((element) => element.stage == e)
                .toList()
                .filter_Fractios___()
                .map((e) => NumAndDescrioption(
                      voluem: e.lenth * e.wedth * e.hight,
                      total:
                          total_amount_for_single_siz__fractions(e, fractions),
                      descrioption:
                          "${e.lenth}*${e.wedth}*${e.hight} ${e.color} ${e.type} D${e.density.removeTrailingZeros}",
                    ))
                .toList()))
        .toList();
  }

  //  كل المقصوص من هذا المقاس  على هذا المقص لكل دور
  List<NumAndDescrioption> getIncomingOnScissorAll(
      BuildContext context, int rcissor) {
    List<FractionModel> fractions = context
        .read<BlockFirebasecontroller>()
        .blocks
        .expand((element) => element.fractions)
        .where((element) => element.Rscissor == rcissor)
        .toList();

    return fractions
        .where((element) => element.Rscissor == rcissor)
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
              e.serial == f.serial &&
              e.hight == f.hight &&
              e.wedth == f.wedth &&
              e.lenth == f.lenth &&
              e.type == f.type,
        )
        .toList()
        .length;
  }
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
