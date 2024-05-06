// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

class OutOfStockViewModel extends BaseViewModel {
  consumeBlock(BuildContext context) {
    List<BlockModel> blocks = context.read<BlockFirebasecontroller>().blocks;
    String blockNum = blocknumbercontroller.text;
    String? blockSerial = context.read<ObjectBoxController>().serial;
    List<BlockModel> bloc = blocks
        .where((e) => e.number == blockNum.to_int() && e.serial == blockSerial)
        .toList();
    if (bloc.isNotEmpty) {
      bloc[0].OutTo = outTo.text.isEmpty ? "صالة الانتاج" : outTo.text;
      bloc[0].actions.add(BlockAction.consume_block.add);

      context.read<BlockFirebasecontroller>().updateBlock(bloc[0]);
      blocknumbercontroller.clear();
    }
  }

  unconsumeBlock(BuildContext context, BlockModel element) {
    int index = element.actions.indexWhere((element) =>
        element.action == BlockAction.consume_block.getactionTitle);
    element.actions.removeAt(index);
    element.actions.add(BlockAction.unconsume_block.add);
    context.read<BlockFirebasecontroller>().updateBlock(element);
  }
}
