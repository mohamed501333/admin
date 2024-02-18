import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/CategorysController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';
import 'package:provider/provider.dart';

class ChemicalStockViewModel extends BaseViewModel {
  TextEditingController unit = TextEditingController();
  TextEditingController quantityForUnit = TextEditingController();
  TextEditingController family = TextEditingController();
  TextEditingController item = TextEditingController();

  addUnit(BuildContext context) {
    ChemicalCategory record = ChemicalCategory(
        id: DateTime.now().millisecondsSinceEpoch,
        family: "",
        item: '',
        unit: unit.text,
        quantityForUnit: quantityForUnit.text.to_double(),
        actions: []);
    context.read<Category_controller>().addNewChemicalCategory(record);
  }

  delete(BuildContext context, ChemicalCategory e) {
    context.read<Category_controller>().deleteChemicalCategorys(e);
  }

  addFamily(BuildContext context) {
    ChemicalCategory record = ChemicalCategory(
        id: DateTime.now().millisecondsSinceEpoch,
        family: family.text,
        item: '',
        unit: "",
        quantityForUnit: 0,
        actions: []);
    context.read<Category_controller>().addNewChemicalCategory(record);
  }

  addItem(BuildContext context) {
    ChemicalCategory record = ChemicalCategory(
        id: DateTime.now().millisecondsSinceEpoch,
        family: "",
        item: item.text,
        unit: "",
        quantityForUnit: 0,
        actions: []);
    context.read<Category_controller>().addNewChemicalCategory(record);
  }
}
