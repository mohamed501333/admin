import 'package:flutter/material.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/blocksStock/outofStock_viewmoder.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Chips extends StatelessWidget {
  Chips({super.key, required this.list, required this.vm});
  final List<ChipBlockModel> list;
  BlocksStockViewModel vm;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          spacing: 9,
          children: list
              .map((e) => InkWell(
                    onLongPress: () {
                      context.read<ObjectBoxController>().deletechip(e.id);
                    },
                    onTap: () {
                      vm.fillFields(e);
                    },
                    child: Chip(
                        labelStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        label: Text(e.title.toString())),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
