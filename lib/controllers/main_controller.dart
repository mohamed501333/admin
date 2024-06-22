import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/ui/recources/publicVariables.dart';
import 'package:network_discovery/network_discovery.dart';

class MainController extends ChangeNotifier {
  bool isServerOnline = false;
  streamServerStutues() {
    Timer.periodic(const Duration(seconds: 1), (t) async {
           NetworkDiscovery.discover('192.168.1', 8080).listen((onData) {
        if (onData.ip.to_int() != ip) {
          ip = onData.ip.to_int();
        }
      });
final serverisofline2 =
          NetworkDiscovery.discover('192.168.1', 8080);

      final serverisofline =
          await NetworkDiscovery.discover('192.168.1', 8080).isEmpty;

          
        serverisofline2.first.then((e){print(e.ip);});


      if (!serverisofline != isServerOnline) {
        isServerOnline = !serverisofline;
        notifyListeners();
      }
    });
  }

  int currentIndex = 2;

  changecurrenIndexogbuttonNav(val) {
    currentIndex = val;
    notifyListeners();
  }
}
