// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, camel_case_types, empty_catches

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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
            Chemicals.add(ChemicalsModel.fromJson(item.toString()));
          }
        }
        print("get data of Chemicals");
        notifyListeners();
      });
    } catch (e) {}
  }

  List<ChemicalsModel> Chemicals = [];

  addNewChemicals(ChemicalsModel Chemical) async {
    Chemical.actions.add(ChemicalAction.creat_new_ChemicalAction_item.add);

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
}
