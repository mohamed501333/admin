import 'dart:async';

import 'package:flutter/material.dart';
import 'package:network_discovery/network_discovery.dart';

class MainController extends ChangeNotifier {
  bool isServerOnline = false;
  streamServerStutues() {
    Timer.periodic(const Duration(seconds: 1), (t) async {
      final serverisofline =
          await NetworkDiscovery.discover('192.168.1', 8080).isEmpty;
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
