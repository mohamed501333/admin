// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, camel_case_types, empty_catches

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';

class Category_controller extends ChangeNotifier {
  get_blockCategory_data() {
    try {
      FirebaseDatabase.instance
          .ref("blockcategory")
          .orderByKey()
          .onValue
          .listen((event) {
        blockCategory.clear();
        if (event.snapshot.value != null) {
          Map<Object?, Object?> map =
              event.snapshot.value as Map<Object?, Object?>;
          for (var item in map.values.toList()) {
            blockCategory.add(BlockCategory.fromJson(item.toString()));
          }
        }
        print("get data of category");
        notifyListeners();
      });
    } catch (e) {}
  }

  List<BlockCategory> blockCategory = [];
  int x = 0;

  addNewBlockCategory(BlockCategory blockcategory) async {
    try {
      await FirebaseDatabase.instance
          .ref("blockcategory/${blockcategory.id}")
          .set(blockcategory.toJson())
          .then((value) {});
    } catch (e) {}
  }

  deleteBlockCategory(BlockCategory blockcategory) {
    blockcategory.actions.add(BlockCategoryAction.archive_block_category.add);
    try {
      FirebaseDatabase.instance
          .ref("blockcategory/${blockcategory.id}")
          .set(blockcategory.toJson());
      notifyListeners();
    } catch (e) {}
  }

  BlockCategory? initialFordropdowen;

  Refresh_Ui() {
    notifyListeners();
  }

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
}
