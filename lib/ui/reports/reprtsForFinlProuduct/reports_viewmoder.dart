// ignore_for_file: non_constant_identifier_names

import 'package:jason_company/models/moderls.dart';

class ReportsViewModel {
  //اجمالى وارد تام الصنع
  double total_finalprodut(
      List<FinalProductModel> blocks, FinalProductModel block) {
    return blocks
        .where((e) => e.density == block.density && e.type == block.type)
        .map((e) => (e.hight * e.lenth * e.width / 1000000) * e.amount)
        .reduce((a, b) => a + b);
  }

  int totalofSingleSize(
      FinalProductModel e, List<FinalProductModel> finalproducts) {
    return finalproducts
        .where(
          (f) =>
              e.color == f.color &&
              e.customer == f.customer &&
              e.density == f.density &&
              e.hight == f.hight &&
              e.width == f.width &&
              e.lenth == f.lenth &&
              e.type == f.type,
        )
        .map((e) => e.amount)
        .reduce((value, element) => value + element);
  }

  int totalofSingleSizeOfsingleScissor(
      FinalProductModel e, List<FinalProductModel> finalproducts) {
    return finalproducts
        .where(
          (f) =>
              e.color == f.color &&
              e.customer == f.customer &&
              e.density == f.density &&
              e.hight == f.hight &&
              e.width == f.width &&
              e.lenth == f.lenth &&
              e.scissor == f.scissor &&
              e.type == f.type,
        )
        .map((e) => e.amount)
        .reduce((value, element) => value + element);
  }
}
