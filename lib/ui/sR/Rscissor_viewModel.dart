// ignore_for_file: camel_case_types, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';
import 'package:jason_company/ui/recources/enums.dart';

class Rscissor_veiwModel extends BaseViewModel {
  List<FractionModel> getFractions_Cutted_On_Rscissor(
      BlockFirebasecontroller myType, int Rscissor) {
    return myType.blocks
        .expand((e) => e.fractions.where((element) =>
            element.Rscissor == Rscissor &&
            element.actions
                    .get_Date_of_action(
                        FractionActon.cut_fraction_OnRscissor.getTitle)
                    .formatt() ==
                DateTime.now().formatt()))
        .toList();
  }

  List<FractionModel> fractions_Not_Cut_On_RScissor(
      BuildContext context, List<BlockModel> blocks) {
    return blocks
        .map((e) => e.fractions)
        .expand((element) => element)
        .where((element) => element.isfinal == false)
        .toList();
  }
}
