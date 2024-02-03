// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

class H1VeiwModel extends BaseViewModel {
  TextEditingController numbercontroller = TextEditingController();
  TextEditingController hightcontroller = TextEditingController();
  TextEditingController constantserial = TextEditingController();
  int amountofView = 5;
  BlockModel get_block_of_num_in_controller(
      List<BlockModel> b, BuildContext context) {
    BlockModel m = b
        .where((e) =>
            e.number == int.parse(numbercontroller.text) &&
            e.serial == context.read<ObjectBoxController>().serialforH)
        .toList()[0];
    return m;
  }

  validate_if_ExistforH(List<BlockModel> b, BuildContext context) {
    // standerd validation
    return (String? value) {
      if (value!.isEmpty) {
        return "فارغ";
      }
      // validate on number of block
      var condition = !b.map((e) => e.number).contains(int.parse(value));
      if (condition) {
        return "غير موجود";
      }
      // validate on serial
      var condition3 = !b
          .map((e) => e.serial)
          .contains(context.read<ObjectBoxController>().serialforH);

      if (condition3) {
        return "غير موجود";
      }

      // validate on number and serial
      List<bool> condition5 = b
          .where((e) =>
              e.number == int.parse(value) &&
              e.serial == context.read<ObjectBoxController>().serialforH)
          .map((e) => e.actions
              .if_action_exist(BlockAction.cut_block_on_H.getactionTitle))
          .toList();

      if (condition5.isEmpty) {
        return "غير موجود";
      }
      // validate if cutted
      bool condition2 = b
          .where((e) =>
              e.number == int.parse(value) &&
              e.serial == context.read<ObjectBoxController>().serialforH)
          .map((e) => e.actions
              .if_action_exist(BlockAction.cut_block_on_H.getactionTitle))
          .toList()[0];

      if (condition2) {
        return "تم التصنيع ";
      }

      return null;
    };
  }

  List<FractionModel> permanentFractons = [];

  addpermanentFractons(
      BuildContext context, List<BlockModel> b, int scissor, ChipFraction e) {
    permanentFractons.add(FractionModel(
      notes: "",
      worker: "",
      stage: 0,
      actions: [FractionActon.creat_fraction.add],
      notfinals: [],
      isfinished: false,
      Rscissor: 0,
      Ascissor: 0,
      id: DateTime.now().microsecondsSinceEpoch,
      blockmodelmum: get_block_of_num_in_controller(b, context).number,
      wedth: e.width.removeTrailingZeros.to_int(),
      lenth: e.lenth.removeTrailingZeros.to_int(),
      hight: e.hight.removeTrailingZeros.to_int(),
      density: get_block_of_num_in_controller(b, context).density,
      type: get_block_of_num_in_controller(b, context).type,
      serial: get_block_of_num_in_controller(b, context).serial,
      Hscissor: scissor,
      color: get_block_of_num_in_controller(b, context).color,
    ));
  }

//
  add_fraction(BuildContext context, List<BlockModel> b, int scissor) {
    if (permanentFractons.isNotEmpty) {
      context.read<BlockFirebasecontroller>().Add_fraction(
            notfinal: NotFinalmodel(
                id: DateTime.now().millisecond,
                date: DateTime.now(),
                wight: wightcontroller.text.to_double(),
                type: context.read<ObjectBoxController>().gdet(),
                Rscissor: 0,
                Hscissor: scissor,
                actions: [NotFinalAction.create_Not_final_cumingFrom_H.add]),
            Hscissor: scissor,
            block: get_block_of_num_in_controller(b, context),
            fractions: permanentFractons,
          );

      clearfields();
      numbercontroller.clear();
      permanentFractons.clear();
      wightcontroller.clear();
    }
  }

  @override
  clearfields() {
    lenthcontroller.clear();
    hightcontroller.clear();
    widthcontroller.clear();
  }

  List<String> filterserials(List<BlockModel> blocks) {
    return blocks.filterserials().map((e) => e.serial).toList();
  }

//delete fraction and unfinish block
  void delete(List<FractionModel> fractions, FractionModel fraction,
      BuildContext context) {}
}
