// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:jason_company/controllers/setting_controller.dart';
import 'package:provider/provider.dart';

class Date extends StatelessWidget {
  const Date({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingController>(
      builder: (context, myType, child) {
        return Row(
          children: [
            IconButton(
                onPressed: () {
                  myType.increaseDay();
                },
                icon: const Icon(Icons.remove_circle_rounded)),
            Text(
              myType.currentDate().toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 97, 71, 71),
                fontSize: 14,
              ),
            ),
            IconButton(
                onPressed: () {
                  myType.decreaseDay();
                },
                icon: const Icon(Icons.add_circle_rounded)),
          ],
        );
      },
    );
  }
}

class pagination extends StatelessWidget {
  const pagination({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingController>(
      builder: (context, myType, child) {
        return Row(
          children: [
            IconButton(
                onPressed: () {
                  myType.decreas_s(context);
                },
                icon: const Icon(Icons.remove_circle_rounded)),
            Text(
              myType.s.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 97, 71, 71),
                fontSize: 14,
              ),
            ),
            IconButton(
                onPressed: () {
                  myType.inrcreas_s(context);
                },
                icon: const Icon(Icons.add_circle_rounded)),
          ],
        );
      },
    );
  }
}
