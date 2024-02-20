// ignore_for_file: camel_case_types

import 'package:jason_company/models/moderls.dart';

class Rscissor_viewmodel {
  double volOfConsumed(List<BlockModel> blocks, BlockModel e) {
    var b = blocks
        .where((element) =>
            element.density == e.density &&
            element.type == e.type &&
            element.color == e.color)
        .map((e) => e.lenth * e.hight * e.width / 1000000);
    return b.isEmpty ? 0 : b.reduce((a, b) => a + b);
  }

  double volOfResults(List<FinalProductModel> f, BlockModel e) {
    var i = f
        .where((element) =>
            element.density == e.density &&
            element.type == e.type &&
            element.color == e.color)
        .map((e) => e.amount * e.lenth * e.hight * e.width / 1000000);
    return i.isEmpty ? 0 : i.reduce((a, b) => a + b);
  }

  double TotalvolOfConsumed(List<BlockModel> blocks) {
    var b = blocks.map((e) => e.lenth * e.hight * e.width / 1000000);
    return b.isEmpty ? 0 : b.reduce((a, b) => a + b);
  }

  double TotalvolOfResults(List<FinalProductModel> f) {
    var i = f.map((e) => e.amount * e.lenth * e.hight * e.width / 1000000);
    return i.isEmpty ? 0 : i.reduce((a, b) => a + b);
  }
}
