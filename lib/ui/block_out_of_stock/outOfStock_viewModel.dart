// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';
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
      context
          .read<BlockFirebasecontroller>()
          .consumeblock(bloc[0], outTo.text.isEmpty ? "المصنع" : outTo.text);
      blocknumbercontroller.clear();
    }
  }

  unconsumeBlock(BuildContext context, BlockModel element) {
    context.read<BlockFirebasecontroller>().unconsumeblock(element);
  }
}
