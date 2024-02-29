// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/ChemicalsController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';
import 'package:jason_company/ui/recources/enums.dart';

class ChemicalStockViewModel extends BaseViewModel {
  TextEditingController unit = TextEditingController();
  TextEditingController quantityForUnit = TextEditingController();
  TextEditingController family = TextEditingController();
  TextEditingController item = TextEditingController();
  TextEditingController supplyer = TextEditingController();
  TextEditingController customer = TextEditingController();
  TextEditingController supplyingNum = TextEditingController();
  TextEditingController OutingNum = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController notess = TextEditingController();

  addNewChemical(BuildContext context) {
    Chemicals_controller mytype = context.read<Chemicals_controller>();

    double quantityForUnit = mytype.ChemicalCategorys.where(
                (element) => element.unit == "${mytype.selectedValueForUnit}")
            .isEmpty
        ? 0
        : mytype.ChemicalCategorys.where(
                (element) => element.unit == "${mytype.selectedValueForUnit}")
            .first
            .quantityForUnit;

    if (mytype.selectedValueForFamily != null &&
        mytype.selectedValueForItem != null &&
        mytype.selectedValueForSupplyer != null &&
        mytype.selectedValueForUnit != null &&
        quantity.text.isNotEmpty) {
      ChemicalsModel r = ChemicalsModel(
          id: DateTime.now().microsecondsSinceEpoch,
          family: mytype.selectedValueForFamily.toString(),
          name: mytype.selectedValueForItem.toString(),
          unit: mytype.selectedValueForUnit.toString(),
          quantityForSingleUnit: quantityForUnit,
          quantity: quantity.text.to_double(),
          Totalquantity: quantityForUnit * quantity.text.to_double(),
          supplyOrderNum: supplyingNum.text.to_int(),
          StockRequisitionNum: 0,
          description: "",
          notes: notes.text,
          cumingFrom: mytype.selectedValueForSupplyer.toString(),
          outTo: "",
          actions: [ChemicalAction.creat_new_ChemicalAction_item.add]);

      mytype.addOrDeleteNewChemicals(r);
      quantity.clear();
    }
  }

  OutNewChemical(BuildContext context) {
    Chemicals_controller mytype = context.read<Chemicals_controller>();

    double quantityForUnit = mytype.ChemicalCategorys.where(
                (element) => element.unit == "${mytype.selectedValueForUnit}")
            .isEmpty
        ? 0
        : mytype.ChemicalCategorys.where(
                (element) => element.unit == "${mytype.selectedValueForUnit}")
            .first
            .quantityForUnit;

    ChemicalsModel r = ChemicalsModel(
        id: DateTime.now().microsecondsSinceEpoch,
        family: mytype.selectedValueForFamily.toString(),
        name: mytype.selectedValueForItem.toString(),
        unit: mytype.selectedValueForUnit.toString(),
        quantityForSingleUnit: quantityForUnit,
        quantity: quantity.text.to_double(),
        Totalquantity: -quantityForUnit * quantity.text.to_double(),
        supplyOrderNum: 0,
        StockRequisitionNum: OutingNum.text.to_int(),
        description: "",
        notes: notes.text,
        cumingFrom: "",
        outTo: mytype.selectedValueForcustomer.toString(),
        actions: [ChemicalAction.creat_Out_ChemicalAction_item.add]);

    if (mytype.selectedValueForFamily != null &&
        mytype.selectedValueForItem != null &&
        mytype.selectedValueForcustomer != null &&
        mytype.selectedValueForUnit != null &&
        quantity.text.isNotEmpty) {
      mytype.addOrDeleteNewChemicals(r);
      quantity.clear();
    }
  }

  DeleteChemical(BuildContext context, ChemicalsModel e) {
    Chemicals_controller mytype = context.read<Chemicals_controller>();
    e.actions.add(ChemicalAction.archive_ChemicalAction_item.add);

    mytype.addOrDeleteNewChemicals(e);
  }

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

  double getTotal(List<ChemicalsModel> Chemicals, ChemicalsModel e) {
    Iterable<ChemicalsModel> a = Chemicals.where(
            (element) => element.family == e.family && element.name == e.name)
        .toList();
    return a.isEmpty
        ? 0.0
        : a.map((e) => e.Totalquantity).reduce((v, b) => v + b);
  }

  List<Report_1_Data> getDataForReport(
      BuildContext context,
      List<String> selctedNames,
      List<String> selctedFamilys,
      List<ChemicalsModel> Chemicals) {
    return Chemicals.filterFamilyOrName(selctedNames, selctedFamilys)
        .FilterChemicals()
        .map((e) => Report_1_Data(
              family: e.family,
              name: e.name,
              totalQuantity: getTotal(Chemicals, e),
            ))
        .toList();
  }
}

class Report_1_Data {
  String family;
  String name;
  double totalQuantity;
  Report_1_Data({
    required this.family,
    required this.name,
    required this.totalQuantity,
  });
}
