// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, empty_catches

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:jason_company/models/moderls.dart';

class FractionFirebaseController extends ChangeNotifier {
  get_Fractions_data() {
    try {
      FirebaseDatabase.instance
          .ref("fractions")
          .orderByKey()
          .onValue
          .listen((event) {
        if (kDebugMode) {
          print("get fractions product");
        }
        fractions.clear();
        if (event.snapshot.value != null) {
          Map<Object?, Object?> map =
              event.snapshot.value as Map<Object?, Object?>;
          if (kDebugMode) {
            print(map);
          }
          for (var item in map.values.toList()) {
            fractions.add(FractionModel.fromJson(item.toString()));
          }
        }
        notifyListeners();
      });
    } catch (e) {}
  }

  List<FractionModel> fractions = [];

  addfraction(List<FractionModel> fractions) async {
    try {
      for (var element in fractions) {
        FirebaseDatabase.instance
            .ref("fractions/${element.id}")
            .set(element.toJson())
            .then((value) {});
      }
    } catch (e) {}
  }

  deleteFractions(List<int> ids) {
    ids.forEach((id) {
      try {
        FirebaseDatabase.instance.ref("fractions/$id").remove();
        fractions.clear();
        notifyListeners();
      } catch (e) {}
    });
  }
}
