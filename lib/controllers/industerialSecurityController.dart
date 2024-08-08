// ignore_for_file: non_constant_identifier_names, empty_catches, file_names, unused_element
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:jason_company/data/sharedprefs.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:http/http.dart' as http;
import 'package:jason_company/ui/recources/publicVariables.dart';

class IndusterialSecuritycontroller extends ChangeNotifier {
  List<IndusterialSecurityModel> all = [];

  getdata() async {
    print('g');
    // get for the first time
    Uri uri = Uri.http('$ip:8080', '/industerialsecurity');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var a = json.decode(response.body) as List;
      print(a);
      for (var element in a) {
        var i = IndusterialSecurityModel.fromMap(element);
        all.add(i);
      }
      notifyListeners();
    }
  }

  Future<bool> postRecord(IndusterialSecurityModel record) async {
    Uri uri = Uri.http('$ip:8080', '/industerialsecurity');
    var response = await http.post(uri, body: record.toJson());
    return response.statusCode == 200 ? true : false;
  }

  Refresh_the_UI() {
    notifyListeners();
  }

  Future<Uint8List> getImageFromCamera(int ip, int cam) async {
    final url = Uri.parse(
        'http://admin:Admin%40123@192.168.1.$ip/ISAPI/Streaming/channels/$cam/picture'); //Repclace Your Endpoint
    final headers = {
      'Accept': '*/*',
      'Cache-Control': 'no-cache',
      'Accept-Encoding': 'gzip, deflate, br',
      'Content-Type': 'image/jpeg',
      'Authorization': 'Basic YWRtaW46QWRtaW5AMTIz'
    };

    final response = await http.get(
      url,
      headers: headers,
    );
    await Future.delayed(const Duration(milliseconds: 300));
    return response.bodyBytes;
  }
}
