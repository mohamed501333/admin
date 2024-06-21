import 'package:flutter/material.dart';
import 'package:jason_company/controllers/main_controller.dart';
import 'package:jason_company/ui/recources/publicVariables.dart';
import 'package:provider/provider.dart';

Widget errmsg() {
  //error message widget.
  return Consumer<MainController>(
    builder: (context, myType, child) {
      return myType.isServerOnline
          ? const SizedBox()
          : internet == true
              ? const SizedBox()
              : Container(
                  padding: const EdgeInsets.all(10.00),
                  margin: const EdgeInsets.only(bottom: 10.00),
                  color: Colors.red,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 6.00),
                          child: const Icon(Icons.info, color: Colors.white),
                        ), // icon for error message

                        const Center(
                            child: Text('لا يوجد اتصال ب السيرفر ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                        //show error message text
                      ]),
                );
    },
  );
}
