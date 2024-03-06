import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/ui/purching/componants0.dart';

class PurchVeiw extends StatelessWidget {
  const PurchVeiw({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                context.gonext(context, NewPurch());
              },
              child: Container(
                width: 66,
                decoration: const BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.all(Radius.circular(11))),
                child: const Center(
                    child: Text(
                  "جديد",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.amber,
                      fontWeight: FontWeight.bold),
                )),
              ))
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
