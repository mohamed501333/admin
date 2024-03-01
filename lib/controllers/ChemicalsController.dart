// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, camel_case_types, empty_catches

import 'package:collection/collection.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';

class Chemicals_controller extends ChangeNotifier {
  get_Chemicals_data() {
    try {
      FirebaseDatabase.instance
          .ref("Chemicals")
          .orderByKey()
          .onValue
          .listen((event) {
        Chemicals.clear();
        if (event.snapshot.value != null) {
          Map<Object?, Object?> map =
              event.snapshot.value as Map<Object?, Object?>;
          for (var item in map.values.toList()) {
            if (ChemicalsModel.fromJson(item.toString())
                    .actions
                    .if_action_exist(
                        ChemicalAction.archive_ChemicalAction_item.getTitle) ==
                false) {
              Chemicals.add(ChemicalsModel.fromJson(item.toString()));
            }
          }
        }
        print("get data of Chemicals");
        notifyListeners();
      });
    } catch (e) {}
  }

  List<ChemicalsModel> Chemicals = [];

  addOrDeleteNewChemicals(ChemicalsModel Chemical) async {
    try {
      await FirebaseDatabase.instance
          .ref("Chemicals/${Chemical.id}")
          .set(Chemical.toJson())
          .then((value) {});
    } catch (e) {}
  }

  deleteChemical(BlockCategory Chemical) {
    Chemical.actions.add(ChemicalAction.archive_ChemicalAction_item.add);
    try {
      FirebaseDatabase.instance
          .ref("Chemicals/${Chemical.id}")
          .set(Chemical.toJson());
      notifyListeners();
    } catch (e) {}
  }

  Refresh_Ui() {
    notifyListeners();
  }

  firstDateOfData() {
    return Chemicals.where((e) => e.actions.if_action_exist(
            ChemicalAction.creat_new_ChemicalAction_item.getTitle))
        .map((e) => e.actions.get_Date_of_action(
            ChemicalAction.creat_new_ChemicalAction_item.getTitle))
        .min;
  }

  String? selectedValueForSupplyer;
  String? selectedValueForcustomer;
  String? selectedValueForFamily;
  String? selectedValueForUnit;
  String? selectedValueForItem;

  //lllllllllllllllllllllllllllllllllllllllllllllllllllllll
//lllllllllllllllllllllllllllllllllllllllllllllllllllllll
//lllllllllllllllllllllllllllllllllllllllllllllllllllllll
//lllllllllllllllllllllllllllllllllllllllllllllllllllllll

  get_ChemicalCategory_data() {
    try {
      FirebaseDatabase.instance
          .ref("ChemicalCategory")
          .orderByKey()
          .onValue
          .listen((event) {
        ChemicalCategorys.clear();
        if (event.snapshot.value != null) {
          Map<Object?, Object?> map =
              event.snapshot.value as Map<Object?, Object?>;
          for (var item in map.values.toList()) {
            ChemicalCategorys.add(ChemicalCategory.fromJson(item.toString()));
          }
          ChemicalCategorys.retainWhere((element) =>
              element.actions.if_action_exist(
                  Chemical_Category.archive_Chemical_category.getTitle) ==
              false);
        }
        print("get data of ChemicalCategory");
        notifyListeners();
      });
    } catch (e) {}
  }

  List<ChemicalCategory> ChemicalCategorys = [];

  addNewChemicalCategory(ChemicalCategory ChemicalCategorys) async {
    ChemicalCategorys.actions
        .add(Chemical_Category.creat_new_Chemical_category.add);
    try {
      await FirebaseDatabase.instance
          .ref("ChemicalCategory/${ChemicalCategorys.id}")
          .set(ChemicalCategorys.toJson())
          .then((value) {});
    } catch (e) {}
  }

  deleteChemicalCategorys(ChemicalCategory ChemicalCategorys) {
    ChemicalCategorys.actions
        .add(Chemical_Category.archive_Chemical_category.add);
    try {
      FirebaseDatabase.instance
          .ref("ChemicalCategory/${ChemicalCategorys.id}")
          .set(ChemicalCategorys.toJson());
      notifyListeners();
    } catch (e) {}
  }

  List<String> selctedFamilys = [];
  List<String> filterdedNames = [];
  List<String> selctedNames = [];
  makeNull() {
    selectedValueForSupplyer = null;
    selectedValueForFamily = null;
    selectedValueForUnit = null;
    selectedValueForItem = null;
    selctedFamilys.clear();
    selctedNames.clear();
  }
}
