import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/publicVariables.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class Hivecontroller extends ChangeNotifier {
  Map<String, WieghtTecketMOdel> allrecords = {};

  static late WebSocketChannel channel;

  WieghtTecketMOdel? temprecord;
  String v = '';
  bool canedit1 = true;
  bool canedit2 = true;
  TextEditingController carnumcontroller = TextEditingController();
  TextEditingController drivernamecontroller = TextEditingController();
  TextEditingController customercontroller = TextEditingController();
  TextEditingController itemcontroller = TextEditingController();
  TextEditingController notescontroller = TextEditingController();
  bool channelConectioninitionlized = false;
  bool getupdatesinitionlized = false;
  bool sendPendigTicketsinitionlized = false;
  bool isServerOnline = false;

  clearfields() {
    v = '';
    carnumcontroller.clear();
    drivernamecontroller.clear();
    customercontroller.clear();
    itemcontroller.clear();
    notescontroller.clear();
    notifyListeners();
  }

  // initHive() async {
  //   var path = Directory.current.path;
  //   Hive.init(path);
  //   //open box and assign all its values to map of values
  //   await Hive.openBox('records').then((e) {
  //     for (var v in e.values) {
  //       final val = WieghtTecketMOdel.fromJson(v);
  //       allrecords.addAll({val.wightTecket_ID.toString(): val});
  //     }
  //     Refrech_UI();
  //   });
  //   //open box
  //   await Hive.openBox('pendingRecords');
  //   // listen to box changes and update values and assigen it to pending
  //   Hive.box('records').watch().listen((e) {
  //     print(' records listen');
  //     var i = WieghtTecketMOdel.fromJson(e.value);
  //     if (allrecords.values
  //         .where((test) => test.lastupdated == i.lastupdated)
  //         .isEmpty) {
  //       print(' records listen2');

  //       allrecords.addAll({e.key: i});
  //       Hive.box('pendingRecords').put(e.key, i.toJson());
  //       Refrech_UI();
  //     }
  //   });
  //   Hive.box('pendingRecords').clear();
  //   Hive.box('records').clear();
  // }

  // getUpdates() async {
  //   if (ip != '' &&
  //       getupdatesinitionlized == false &&
  //       isServerOnline == false) {
  //     getupdatesinitionlized = true;
  //     // get for the first time
  //     final maxLastupdated = allrecords.values.map((e) => e.lastupdated).max;
  //     Uri uri = Uri.http('$ip:8080', '/biscol')
  //         .replace(queryParameters: {'lastupdated': '$maxLastupdated'});
  //     var response = await http.get(uri);
  //     if (response.statusCode == 200) {
  //       var a = json.decode(response.body) as List;
  //       for (var element in a) {
  //         var item = WieghtTecketMOdel.fromJson(element);
  //         Hive.box('records')
  //             .put(item.wightTecket_ID.toString(), item.toJson());
  //       }
  //     }
  //   }
  // }

  // sendPendigTickets() async {
  //   if (ip != '' &&
  //       sendPendigTicketsinitionlized == false &&
  //       isServerOnline == false) {
  //     sendPendigTicketsinitionlized == true;
  //     Hive.box('pendingRecords').watch().listen((e) {
  //       if (e.value != null) {
  //         channel.sink.add(e.value);

  //         Hive.box('pendingRecords').delete(e.key);
  //       }
  //     });
  //   }
  // }

  channelConection() async {
    // get for the first time
    Uri uri = Uri.http('$ip:8080', '/biscol');
    print("1");

    var response = await http.get(uri);
    if (response.statusCode == 200) {
      print("2");

      allrecords.clear();
      var a = json.decode(response.body) as List;
      print("3");

      for (var element in a) {
        print("4");

        var block = WieghtTecketMOdel.fromMap(element);

        allrecords.addAll({block.wightTecket_ID.toString(): block});
      }
      notifyListeners();
    }
    if (ip != '' &&
        channelConectioninitionlized == false &&
        isServerOnline == false) {
      channelConectioninitionlized = true;
      Uri uri2 = Uri.parse('ws://$ip:8080/biscol/ws')
          .replace(queryParameters: {'username': 'biscolpc'});
      channel = WebSocketChannel.connect(uri2);
      channel.stream.forEach((u) {
        WieghtTecketMOdel item = WieghtTecketMOdel.fromJson(u);
        allrecords.addAll({item.wightTecket_ID.toString(): item});
        notifyListeners();
      });
    }
  }

  Uint8List? cam1;
  Uint8List? cam2;

  FillRecord(WieghtTecketMOdel r) {
    temprecord = r;
    carnumcontroller.text = r.carNum.toString();
    drivernamecontroller.text = r.driverName;
    customercontroller.text = r.customerName;
    itemcontroller.text = r.prodcutName;
    notescontroller.text = r.notes;

    notifyListeners();
  }

  updateRecord(WieghtTecketMOdel record, int serial) {
    record.lastupdated = DateTime.now().microsecondsSinceEpoch;
    record.stockRequsition_serial = serial;
    channel.sink.add(record.toJson());
  }

  // removeRecord(WieghtTecketMOdel record) {
  //   record.synced = false;
  //   record.lastupdated = DateTime.now().microsecondsSinceEpoch;

  //   Hive.box('records').put(record.wightTecket_ID.toString(), record.toJson());

  //   notifyListeners();
  // }

  Refrech_UI() {
    notifyListeners();
  }

  List<String> selectedCarNum = [];
  List<String> selectedDrivers = [];
  List<String> selectedcustomerName = [];
  List<String> selectedProdcutName = [];
  String selectedReport = '';
  DateTime? pickedDateFrom;
  DateTime? pickedDateTO;
  String archived = 'غير محزوف';

  List<DateTime> AllDatesOfOfData() {
    return allrecords.values
        .expand((e) => e.actions)
        .map((d) => d.when)
        .toList();
  }

  WieghtTecketMOdel? ini;
}
