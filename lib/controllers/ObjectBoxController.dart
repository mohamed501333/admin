// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/main.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:provider/provider.dart';

class ObjectBoxController extends ChangeNotifier {
  // addBlock(BlockModel block) {
  //   database.addBlock(block);
  //   notifyListeners();
  // }

  addchips(ChipBlockModel chip) {
    database.addchips(chip);
    notifyListeners();
  }

  // addfinalProduct(FinalProductModel f) {
  //   database.addFinalProuduct(f);
  //   notifyListeners();
  // }

  addfinalProductchips(ChipfinalProducut chip) {
    database.addfinalProuductchips(chip);
    notifyListeners();
  }

  // addFraction(BuildContext context, List<FractionModel> fract) {
  //   print("add fraction");
  //   fract.map((e) => context.read<FractionFirebaseController>().addfraction(e));
  //   notifyListeners();
  // }

  addFractionchip(ChipFraction fract) {
    database.addFractionchip(fract);
    notifyListeners();
  }

  List<ChipBlockModel> chips = database.getchips();
  // List<BlockModel> blocks = database.getblocks();
  List<ChipfinalProducut> chipsfinalprouduct = database.getfinalProuductchips();
  // List<FinalProductModel> finalproducts = database.getFinalProuduct();
  // List<FractionModel> fractions = database.getFraction();
  List<ChipFraction> fractionchips = database.getFractionchip();

  deletechip(id) {
    database.deletechip(id);
    notifyListeners();
  }

  // deleteblock(id) {
  //   database.deleteblock(id);
  //   notifyListeners();
  // }

  deletechipfinalproduct(id) {
    database.deletefinalProuductchips(id);
    notifyListeners();
  }

  // deletefinalProudut(id) {
  //   database.deleteFinalProuduct(id);
  //   notifyListeners();
  // }

  // deleteFraction(id) {
  //   database.deleteFraction(id);
  //   notifyListeners();
  // }
  //
  int lenthInFilter = 0;
  Rfrech_ui() {
    notifyListeners();
  }

  deleteFractionchip(id) {
    database.deleteFractionchip(id);
    notifyListeners();
  }

  // finishBlick(int id, int scissor) {
  //   database.finishBloc(id, scissor);
  //   notifyListeners();
  // }

  // consumeBlock(int id) {
  //   database.consumeBlock(id);
  //   notifyListeners();
  // }

  // unconsumeBlock(int id) {
  //   database.unconsumeBlock(id);
  //   notifyListeners();
  // }

  get() {
    notifyListeners();
  }

  String? serial;

  String? initialcolor;
  List<String> filtercolor(List<BlockModel> blocks) {
    return blocks.map((e) => e.color).toSet().toList();
  }

  getBlocks(BuildContext context) {
    List<BlockModel> x = context.read<BlockFirebasecontroller>().blocks;

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

  List<BlockModel> blocks = [];

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
