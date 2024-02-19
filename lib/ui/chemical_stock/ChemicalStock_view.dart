// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/ui/chemical_stock/componants.dart';
import 'package:jason_company/ui/recources/enums.dart';

class Chemical_view extends StatelessWidget {
  const Chemical_view({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                context.gonext(context, CreateChemicalCategory());
              },
              child: const Text(
                "تكويد اصناف",
                style: TextStyle(color: Color.fromARGB(255, 156, 0, 0)),
              )).permition(context, UserPermition.show_Chemical_category),
          TextButton(
              onPressed: () {
                context.gonext(context, Suplying());
              },
              child: const Text(
                "توريد",
                style: TextStyle(color: Color.fromARGB(255, 156, 0, 0)),
              )),
          TextButton(
              onPressed: () {},
              child: const Text(
                "صرف",
                style: TextStyle(color: Color.fromARGB(255, 156, 0, 0)),
              ))
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
