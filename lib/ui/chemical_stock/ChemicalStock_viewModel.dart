import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/ChemicalsController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';
import 'package:provider/provider.dart';

class ChemicalStockViewModel extends BaseViewModel {
  TextEditingController unit = TextEditingController();
  TextEditingController quantityForUnit = TextEditingController();
  TextEditingController family = TextEditingController();
  TextEditingController item = TextEditingController();
  TextEditingController supplyer = TextEditingController();
  TextEditingController customer = TextEditingController();
  TextEditingController supplyingNum = TextEditingController();

  addUnit(BuildContext context) {
    ChemicalCategory record = ChemicalCategory(
        id: DateTime.now().millisecondsSinceEpoch,
        family: "",
        item: '',
        OutTo: "",
        cummingFrom: "",
        unit: unit.text,
        quantityForUnit: quantityForUnit.text.to_double(),
        actions: []);
    context.read<Chemicals_controller>().addNewChemicalCategory(record);
    unit.clear();
    quantityForUnit.clear();
  }

  delete(BuildContext context, ChemicalCategory e) {
    context.read<Chemicals_controller>().deleteChemicalCategorys(e);
  }

  addFamily(BuildContext context) {
    ChemicalCategory record = ChemicalCategory(
        id: DateTime.now().millisecondsSinceEpoch,
        family: family.text,
        item: '',
        unit: "",
        OutTo: "",
        cummingFrom: "",
        quantityForUnit: 0,
        actions: []);
    context.read<Chemicals_controller>().addNewChemicalCategory(record);
    family.clear();
  }

  addItem(BuildContext context) {
    ChemicalCategory record = ChemicalCategory(
        id: DateTime.now().millisecondsSinceEpoch,
        family: "",
        item: item.text,
        unit: "",
        OutTo: "",
        cummingFrom: "",
        quantityForUnit: 0,
        actions: []);
    context.read<Chemicals_controller>().addNewChemicalCategory(record);
    supplyer.clear();
  }

  addSupplyer(BuildContext context) {
    ChemicalCategory record = ChemicalCategory(
        id: DateTime.now().millisecondsSinceEpoch,
        family: "",
        item: "",
        unit: "",
        OutTo: "",
        cummingFrom: supplyer.text,
        quantityForUnit: 0,
        actions: []);
    context.read<Chemicals_controller>().addNewChemicalCategory(record);
    item.clear();
  }

  addcustomer(BuildContext context) {
    ChemicalCategory record = ChemicalCategory(
        id: DateTime.now().millisecondsSinceEpoch,
        family: "",
        item: "",
        unit: "",
        OutTo: customer.text,
        cummingFrom: "",
        quantityForUnit: 0,
        actions: []);
    context.read<Chemicals_controller>().addNewChemicalCategory(record);
    carnumber.clear();
  }
}
