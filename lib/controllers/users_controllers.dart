// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/data/sharedprefs.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/recources/publicVariables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

import '../ui/recources/strings_manager.dart';

class Users_controller extends ChangeNotifier {
  static late WebSocketChannel channel;
  List<UserModel> users = [];
  UserModel? currentuser;

    getData(String email, String password) {
    if (internet == true) {
      users_From_firebase(email,password);
    } else {
      usersFrom_server(email,password);
    }
  }

  usersFrom_server(String email, String password){
    Uri uri = Uri.parse('ws://192.168.1.34:8080/users/ws')
        .replace(queryParameters: {'username': email, 'password': password});
    channel = WebSocketChannel.connect(uri);
    channel.sink.add('');
    channel.stream.forEach((u) {
      UserModel user = UserModel.fromJson(u);
      currentuser = user;
      SringsManager.myemail = user.name;
      if (currentuser!=null) {
            Sharedprfs.setemail(currentuser!.email);
      Sharedprfs.setpassword(currentuser!.password); 
      }
      notifyListeners();
      print(user);
    });
  
  }
users_From_firebase(String email, String password){

}
  Uri uri = Uri.http('192.168.1.$ip:8080', '/users');
getAllUsers() async {
   // get for the first time
  
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      users.clear();
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var user = UserModel.fromMap(element);
        if (user.actions
                .if_action_exist(UserAction.archive_user.getTitle) ==
            false) {
          users.add(user);
        }
      }
      notifyListeners();
    }
}

updateUser(UserModel user){
if (internet == true) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.user_Id.toString())
          .set(user.toMap());
    } else {
      http.put(uri,body: user.toJson());
    }
}





  Refrsh_ui() {
    notifyListeners();
  }

  changeValOf_internet(bool val) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('internet', val);
    notifyListeners();
  }

  
}
