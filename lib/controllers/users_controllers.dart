// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:jason_company/data/sharedprefs.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../ui/recources/strings_manager.dart';

class Users_controller extends ChangeNotifier {
  static late WebSocketChannel channel;
  List<Users> users = [];
  UserModel? currentuser;
  connect(String email, String password) {
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

  Refrsh_ui() {
    notifyListeners();
  }

  changeValOf_internet(bool val) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('internet', val);
    notifyListeners();
  }

  
}
