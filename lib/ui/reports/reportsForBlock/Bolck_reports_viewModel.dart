// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';
import 'package:jason_company/ui/recources/enums.dart';

class BlockReportsViewModel extends BaseViewModel {
  double total_spend(
      BuildContext context, List<BlockModel> blocks, BlockModel block) {
    var x = blocks
        // .filter_date_consumed(context)
        .where((e) => e.density == block.density && e.type == block.type)
        .toList()
        .map((e) => e.hight * e.lenth * e.width / 1000000)
        .toList();

    if (x.isNotEmpty) {
      return x.reduce((a, b) => a + b);
    } else {
      return 0.0;
    }
  }

  double Last_period_balance(
      BuildContext context, List<BlockModel> blocks, BlockModel block) {
    var x = blocks
        .where((element) =>
            element.actions
                .if_action_exist(BlockAction.consume_block.getactionTitle) ==
            false)
        .where((e) => e.density == block.density && e.type == block.type)
        .toList()
        .map((e) => e.hight * e.lenth * e.width / 1000000);

    if (x.isNotEmpty) {
      return x.reduce((a, b) => a + b);
    } else {
      return 0.0;
    }
  }

  int total_amount_for_single_siz__(BlockModel e, List<BlockModel> blocks) {
    return blocks
        .where(
          (f) =>
              e.color == f.color &&
              e.density == f.density &&
              // e.hight == f.hight &&
              e.width == f.width &&
              e.lenth == f.lenth &&
              e.type == f.type,
        )
        .toList()
        .length;
  }

  List<BlockModel> sizes(BlockModel e, List<BlockModel> blocks) {
    return blocks
        .where(
          (f) =>
              e.color == f.color && e.density == f.density && e.type == f.type,
        )
        .toList();
  }
}
