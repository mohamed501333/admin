// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/main.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

class ObjectBoxController extends ChangeNotifier {
  addchips(ChipBlockModel chip) {
    database.addchips(chip);
    notifyListeners();
  }

  addFractionchip(ChipFraction fract) {
    database.addFractionchip(fract);
    notifyListeners();
  }

  List<ChipBlockModel> chips = database.getchips();

  List<ChipFraction> fractionchips = database.getFractionchip();

  deletechip(id) {
    database.deletechip(id);
    notifyListeners();
  }

  int lenthInFilter = 0;
  Rfrech_ui() {
    notifyListeners();
  }

  deleteFractionchip(id) {
    database.deleteFractionchip(id);
    notifyListeners();
  }

  get() {
    notifyListeners();
  }

  String? serial;
  //for reports
  String? serial2;
  String? initialcolor;

  String? serialforH;
  String? initialcolorforH;

  List<String> filtercolor(List<BlockModel> blocks) {
    return blocks.map((e) => e.color).toSet().toList();
  }

  List<String> filtercolorforH(List<BlockModel> blocks) {
    return blocks
        .where((element) =>
            element.actions.if_action_exist(
                    BlockAction.consume_block.getactionTitle) ==
                true &&
            element.Hscissor == 0)
        .map((e) => e.color)
        .toSet()
        .toList();
  }

  getBlocks(BuildContext context) {
    List<BlockModel> x = context
        .read<BlockFirebasecontroller>()
        .blocks
        .where((element) =>
            element.actions
                .if_action_exist(BlockAction.consume_block.getactionTitle) ==
            false)
        .toList();

    initialcolor != null
        ? x = context
            .read<BlockFirebasecontroller>()
            .blocks
            .where((element) => element.color == initialcolor)
            .toList()
        : DoNothingAction;
    serial != null
        ? x = context
            .read<BlockFirebasecontroller>()
            .blocks
            .where((element) => element.serial == serial)
            .toList()
        : DoNothingAction;

    blocks = x;
  }

  getBlocksConsumedAndNotCutted(BuildContext context) {
    List<BlockModel> x = context
        .read<BlockFirebasecontroller>()
        .blocks
        .where((element) =>
            element.actions.if_action_exist(
                    BlockAction.consume_block.getactionTitle) ==
                true &&
            element.Hscissor == 0)
        .toList();

    initialcolorforH != null
        ? x = context
            .read<BlockFirebasecontroller>()
            .blocks
            .where((element) =>
                element.actions.if_action_exist(
                        BlockAction.consume_block.getactionTitle) ==
                    true &&
                element.Hscissor == 0)
            .toList()
            .where((element) => element.color == initialcolorforH)
            .toList()
        : DoNothingAction;
    serialforH != null
        ? x = context
            .read<BlockFirebasecontroller>()
            .blocks
            .where((element) =>
                element.actions.if_action_exist(
                        BlockAction.consume_block.getactionTitle) ==
                    true &&
                element.Hscissor == 0)
            .toList()
            .where((element) => element.serial == serialforH)
            .toList()
        : DoNothingAction;

    blocksforH = x;
  }

  List<BlockModel> blocks = [];
  List<BlockModel> blocksforH = [];

  List<String> notfials = [
    "جوانب",
    "ارضيات",
    "هالك",
    "درجه ثانيه",
    "درجه ثانيه ممتازه"
  ];
  String initial = "جوانب";
  String initial2 = "ارضيات";
  gdet() {
    switch (initial) {
      case "جوانب":
        return "aspects";
      case "ارضيات":
        return "floors";
      case "هالك":
        return "Halek";
      case "درجه ثانيه":
        return "secondDegree";
      case "درجه ثانيه ممتازه":
        return "ExcellentsecondDegree";
    }
  }

  gdet222() {
    switch (initial2) {
      case "جوانب":
        return "aspects";
      case "ارضيات":
        return "floors";
      case "هالك":
        return "Halek";
      case "درجه ثانيه":
        return "secondDegree";
      case "درجه ثانيه ممتازه":
        return "ExcellentsecondDegree";
    }
  }
}
