// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters

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
    } catch (e) {
      print(e);
      print("erorr on get fractions");
    }
  }

  List<FractionModel> fractions = [];

  addfraction(List<FractionModel> fractions) async {
    print("try erorr on add fractions");
    try {
      fractions.forEach((element) {
        FirebaseDatabase.instance
            .ref("fractions/${element.id}")
            .set(element.toJson())
            .then((value) {
          print("adeddddd to fradtion");
        });
      });
    } catch (e) {
      print(e);
      print("erorr on add fractions");
    }
  }

  deleteFractions(List<int> ids) {
    ids.forEach((id) {
      try {
        FirebaseDatabase.instance.ref("fractions/$id").remove();
        fractions.clear();
        notifyListeners();
        print("erorr on get fractions");
      } catch (e) {
        print(e);
      }
    });
  }
}
