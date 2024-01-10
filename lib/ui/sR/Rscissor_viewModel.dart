// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';

class Rscissor_veiwModel extends BaseViewModel {
  List<FractionModel> fractions_Not_Cut_On_RScissor(
      BuildContext context, List<BlockModel> blocks) {
    return blocks
        .map((e) => e.fractions)
        .expand((element) => element)
        .where((element) => element.Rscissor == 0 && element.Ascissor == 0)
        .toList();
  }
}
