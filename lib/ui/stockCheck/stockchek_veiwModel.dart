// ignore_for_file: public_member_api_docs, sort_constructors_first, camel_case_types, non_constant_identifier_names
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/models/moderls.dart';

class Stockcheck_veiwModel {
  int get_total(List<FinalProductModel> finalproducts, FinalProductModel e) {
    return finalproducts
        .where((element) =>
            element.density == e.density &&
            element.color == e.color &&
            element.type == e.type &&
            element.width == e.width &&
            element.hight == e.hight &&
            element.lenth == e.lenth)
        .map((e) => e.amount)
        .reduce((a, b) => a + b);
  }

  List<FinalProdcutBalanceModel> finalprodctBalance(
      List<FinalProductModel> finalproducts) {
    return finalproducts
        .filteronfinalproduct()
        .where((e) => get_total(finalproducts, e) > 0)
        .map((g) => FinalProdcutBalanceModel(
            color: g.color,
            type: g.type,
            density: g.density,
            L: g.lenth,
            W: g.width,
            H: g.hight,
            quantity: get_total(finalproducts, g)))
        .toList();
  }
}

class FinalProdcutBalanceModel {
  String color;
  String type;
  double density;
  double L;
  double W;
  double H;
  int quantity;
  FinalProdcutBalanceModel({
    required this.color,
    required this.type,
    required this.density,
    required this.L,
    required this.W,
    required this.H,
    required this.quantity,
  });
}
