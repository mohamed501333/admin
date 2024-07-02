// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, camel_case_types, empty_catches

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/data/sharedprefs.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/recources/publicVariables.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class Chemicals_controller extends ChangeNotifier {
  static late WebSocketChannel channel;
  List<ChemicalsModel> Chemicals = [];

  getData() {
    if (internet == true) {
      chemicals_From_firebase();
    } else {
      chmecals_From_Server();
    }
  }

  chemicals_From_firebase() {}

  chmecals_From_Server() async {
    // get for the first time
    Uri uri = Uri.http('$ip:8080', '/chemicals');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      Chemicals.clear();
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var chemical = ChemicalsModel.fromMap(element);
        if (chemical.actions.if_action_exist(
                ChemicalAction.archive_ChemicalAction_item.getTitle) ==
            false) {
          Chemicals.add(chemical);
        }
      }
      notifyListeners();
    }
    //
    Uri uri2 = Uri.parse('ws://$ip:8080/chemicals/ws').replace(
        queryParameters: {
          'username': Sharedprfs.getemail(),
          'password': Sharedprfs.getpassword()
        });
    channel = WebSocketChannel.connect(uri2);
    channel.stream.forEach((u) {
      ChemicalsModel chemical = ChemicalsModel.fromJson(u);
      var index = Chemicals.map((e) => e.chemical_ID)
          .toList()
          .indexOf(chemical.chemical_ID);
      if (index == -1) {
        if (chemical.actions.if_action_exist(
                ChemicalAction.archive_ChemicalAction_item.getTitle) ==
            false) {
          Chemicals.add(chemical);
        }
      } else {
        Chemicals.removeAt(index);
        if (chemical.actions.if_action_exist(
                ChemicalAction.archive_ChemicalAction_item.getTitle) ==
            false) {
          Chemicals.add(chemical);
        }
      }
      print("get chemcasl $chemical");
      notifyListeners();
    });
  }

  addChemical(ChemicalsModel Chemical) async {
    if (internet == true) {
      FirebaseFirestore.instance
          .collection('chemicals')
          .doc(Chemical.chemical_ID.toString())
          .set(Chemical.toMap());
    } else {
      channel.sink.add(Chemical.toJson());
    }
  }

  deleteChemical(ChemicalsModel Chemical) {
    Chemical.actions.add(ChemicalAction.archive_ChemicalAction_item.add);
    if (internet == true) {
      FirebaseFirestore.instance
          .collection('chemicals')
          .doc(Chemical.chemical_ID.toString())
          .set(Chemical.toMap());
    } else {
      channel.sink.add(Chemical.toJson());
    }
  }

  Refresh_Ui() {
    notifyListeners();
  }

  DateTime firstDateOfData() {
    List<DateTime> v = Chemicals.where((e) => e.actions.if_action_exist(
            ChemicalAction.creat_new_ChemicalAction_item.getTitle))
        .map((e) => e.actions.get_Date_of_action(
            ChemicalAction.creat_new_ChemicalAction_item.getTitle))
        .toList();
    return v.isEmpty ? DateTime(2101) : v.min;
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

  static late WebSocketChannel channel2;
  List<ChemicalCategory> ChemicalCategorys = [];

  getData2() {
    if (internet == true) {
      ChemicalCategorys_From_firebase();
    } else {
      ChemicalCategorys_From_Server();
    }
  }

  ChemicalCategorys_From_firebase() {}

  ChemicalCategorys_From_Server() async {
    print("ChemicalCategorys");

    // get for the first time
    Uri uri = Uri.http('$ip:8080', '/chemicalcategorys');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      ChemicalCategorys.clear();
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var channelcategory = ChemicalCategory.fromMap(element);
        if (channelcategory.actions.if_action_exist(
                Chemical_Category.archive_Chemical_category.getTitle) ==
            false) {
          ChemicalCategorys.add(channelcategory);
        }
      }
      print(ChemicalCategorys);
      notifyListeners();
    }
    //
    Uri uri2 = Uri.parse('ws://$ip:8080/chemicalcategorys/ws').replace(
        queryParameters: {
          'username': Sharedprfs.getemail(),
          'password': Sharedprfs.getpassword()
        });
    channel2 = WebSocketChannel.connect(uri2);
    channel2.stream.forEach((u) {
      ChemicalCategory chemicalcategory = ChemicalCategory.fromJson(u);
      var index = ChemicalCategorys.map((e) => e.chemicalcategory_ID)
          .toList()
          .indexOf(chemicalcategory.chemicalcategory_ID);
      if (chemicalcategory.actions.if_action_exist(
              Chemical_Category.archive_Chemical_category.getTitle) ==
          false) {
        if (index == -1) {
          ChemicalCategorys.add(chemicalcategory);
        } else {
          ChemicalCategorys.removeAt(index);
          ChemicalCategorys.add(chemicalcategory);
        }
      }
      notifyListeners();
    });
  }

  addNewChemicalCategory(ChemicalCategory item) async {
    item.actions.add(Chemical_Category.creat_new_Chemical_category.add);
    if (internet == true) {
      FirebaseFirestore.instance
          .collection('ChemicalCategory')
          .doc(item.chemicalcategory_ID.toString())
          .set(item.toMap());
    } else {
      channel2.sink.add(item.toJson());
    }
  }

  deleteChemicalCategorys(ChemicalCategory ChemicalCategorys) {
    ChemicalCategorys.actions
        .add(Chemical_Category.archive_Chemical_category.add);
    if (internet == true) {
      FirebaseFirestore.instance
          .collection('ChemicalCategory')
          .doc(ChemicalCategorys.chemicalcategory_ID.toString())
          .set(ChemicalCategorys.toMap());
    } else {
      channel2.sink.add(ChemicalCategorys.toJson());
    }
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

  DateTime? pickedDateFrom;
  DateTime? pickedDateTo;
  List<DateTime> AllDatesOfOfData() {
    List<DateTime> v = [];
    v.addAll(Chemicals.where((e) => e.actions.if_action_exist(
            ChemicalAction.creat_Out_ChemicalAction_item.getTitle))
        .map((e) => e.actions.get_Date_of_action(
            ChemicalAction.creat_Out_ChemicalAction_item.getTitle))
        .toList());
    v.addAll(Chemicals.where((e) => e.actions.if_action_exist(
            ChemicalAction.creat_new_ChemicalAction_item.getTitle))
        .map((e) => e.actions.get_Date_of_action(
            ChemicalAction.creat_new_ChemicalAction_item.getTitle))
        .toList());
    return v.isEmpty ? [DateTime.now()] : v;
  }
}
