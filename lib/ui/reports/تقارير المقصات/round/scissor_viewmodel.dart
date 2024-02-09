// ignore_for_file: non_constant_identifier_names, file_names, camel_case_types

import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';

class Rscissor_viewmodel extends BaseViewModel {
  get(String v) {
    switch (v) {
      case "aspects":
        return "جوانب";
      case "floors":
        return "ارضيات";
      case "Halek":
        return "هالك";
      case "secondDegree":
        return "درجه ثانيه";
      case "ExcellentsecondDegree":
        return "درجه ثانيه ممتازه";
    }
  }

  int total_amount_for_single_siz__(
      BlockModel e, List<BlockModel> blocks, int scissor) {
    return blocks
        .where(
          (f) =>
              f.hashCode == scissor &&
              e.color == f.color &&
              e.density == f.density &&
              e.serial == f.serial &&
              e.hight == f.hight &&
              e.width == f.width &&
              e.lenth == f.lenth &&
              e.type == f.type,
        )
        .toList()
        .length;
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

  double total_amount_for_notfinals(
      NotFinalmodel e, List<NotFinalmodel> fractions) {
    return fractions
        .where(
          (f) => e.type == f.type,
        )
        .toList()
        .map((e) => e.wight)
        .reduce((a, b) => a + b);
  }
}
