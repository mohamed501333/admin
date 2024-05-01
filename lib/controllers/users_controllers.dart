// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, camel_case_types, empty_catches

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/userpermitions.dart';

class Users_controller extends ChangeNotifier {
  get_users_data() {
    try {
      FirebaseDatabase.instance
          .ref("myusers")
          .orderByKey()
          .onValue
          .listen((event) {
        users.clear();
        initalData.clear();
        if (event.snapshot.value != null) {
          Map<Object?, Object?> map =
              event.snapshot.value as Map<Object?, Object?>;
          for (var item in map.values.toList()) {
            initalData.add(Users.fromJson(item.toString()));
          }
          users.addAll(initalData);
        }

        notifyListeners();
        print("get users data");
      });
    } catch (e) {}
  }

  List<Users> users = [];
  List<Users> initalData = [];

  Add_User_permition(UserPermition permition,  Users user) {
  
      user.permitions.add(permition.add);
      try {
        FirebaseDatabase.instance.ref("myusers/${user.id}").set(user.toJson());
      } catch (e) {}
    
  }

  Add_new_user(String email) {
    Users user = Users(
        id: DateTime.now().millisecondsSinceEpoch,
        uidemail: email,
        uid: "",
        name: "",
        permitions: []);
    try {
      FirebaseDatabase.instance.ref("myusers/${user.id}").set(user.toJson());
    } catch (e) {}
  }

  remove_User_permition(String e) {
    Users user = users
        .where((element) => element.uidemail == initialforradioqq)
        .toList()
        .first;

    int index = user.permitions.indexWhere((element) => element.tittle == e);
    user.permitions.removeAt(index);

    try {
      FirebaseDatabase.instance.ref("myusers/${user.id}").set(user.toJson());
    } catch (e) {}
  }
//user uid chosen
  String? initialforradioqq;

  Refrsh_ui() {
    notifyListeners();
  }
}
