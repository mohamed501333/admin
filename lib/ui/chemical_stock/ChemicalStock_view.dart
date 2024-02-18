// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class Chemical_view extends StatelessWidget {
  const Chemical_view({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                "توريد",
                style: TextStyle(color: Colors.amber),
              )),
          TextButton(onPressed: () {}, child: const Text("توريد"))
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
