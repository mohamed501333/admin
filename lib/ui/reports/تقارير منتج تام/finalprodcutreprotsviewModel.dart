import 'package:flutter/material.dart';
import '../../../controllers/final_product_controller.dart';
import '../../base/base_view_mode.dart';
import '../../stockCheck/stockchek_veiwModel.dart';
import 'package:provider/provider.dart';

class FinalProdcutsViewModel extends BaseViewModel {
  List<FinalProdcutBalanceModel> finalprodctBalance(
      finalproducts, BuildContext context) {
    var l = context.read<final_prodcut_controller>();
    return finalproducts
        .filteronfinalproduct()
        .filterItemsPasedOnDensites(context, l.selctedDensities)
        .filterItemsPasedOntypes(context, l.selctedtybes)
        .filterItemsPasedOncolors(context, l.selctedcolors)
        .where((e) => finalproducts.countOf(e) > 0)
        .map((g) => FinalProdcutBalanceModel(
            color: g.item.color,
            type: g.item.type,
            density: g.item.density,
            L: g.item.L,
            W: g.item.W,
            H: g.item.H,
            quantity: finalproducts.countOf(g)))
        .toList();
  }
}
