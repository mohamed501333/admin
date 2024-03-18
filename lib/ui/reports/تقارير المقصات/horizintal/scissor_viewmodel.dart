// ignore_for_file: non_constant_identifier_names, file_names, camel_case_types

import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';

class scissor_viewmodel extends BaseViewModel {
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
              e.item.color == f.item.color &&
              e.item.density == f.item.density &&
              e.fraction_ID == f.fraction_ID &&
              e.item.H == f.item.H &&
              e.item.W == f.item.W &&
              e.item.L == f.item.L &&
              e.item.type == f.item.type,
        )
        .toList()
        .length;
  }
  double total_volume_for_T_D_C_Blocks(
      Itme e, List<BlockModel> blocks) {
    return blocks
        .where(
          (f) =>
              e.color == f.color &&
              e.density == f.density &&
              e.type == f.type,
        )
        .map((e) => e.lenth*e.hight*e.width/1000000).reduce((a, b) => a+b)
        ;
  }
  double total_volume_for_T_D_C_fractions(
      Itme e, List<FractionModel> fract) {
    return fract
        .where(
          (f) =>
              e.color == f.item.color &&
              e.density == f.item.density &&
              e.type == f.item.type,
        )
        .map((e) => e.item.L*e.item.H*e.item.W/1000000).reduce((a, b) => a+b)
        ;
  }


  double total_amount_for_notfinals(NotFinal e, List<NotFinal> fractions) {
    return fractions
        .where(
          (f) => e.type == f.type,
        )
        .toList()
        .map((e) => e.wight)
        .reduce((a, b) => a + b);
  }
}
