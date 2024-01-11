import 'package:date_ranger/date_ranger.dart';
import 'package:flutter/material.dart';

class TestPack extends StatefulWidget {
  @override
  _TestPackState createState() => _TestPackState();
}

class _TestPackState extends State<TestPack> {
  var initialDateRange =
      DateTimeRange(start: DateTime(2024, 1, 1), end: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: DateRanger(
            initialRange: initialDateRange,
            onRangeChanged: (range) {
              setState(() {
                initialDateRange = range;
              });
            },
          ),
        )
      ],
    ));
  }
}
