// ignore_for_file: non_constant_identifier_names, empty_catches, file_names

import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';

class BlockFirebasecontroller extends ChangeNotifier {
  get_blocks_data() {
    try {
      FirebaseDatabase.instance
          .ref("blocks")
          .orderByKey()
          .onValue
          .listen((event) {
        all.clear();
        archived_blocks.clear();
        blocks.clear();
        if (event.snapshot.value != null) {
          Map<Object?, Object?> map =
              event.snapshot.value as Map<Object?, Object?>;
          for (var item in map.values.toList()) {
            all.add(BlockModel.fromJson(item.toString()));
          }
          subfractions.addAll(all
              .where((element) => element.Block_Id == 1)
              .expand(
                  (element) => element.fractions.expand((e) => e.SubFractions))
              .toList());
          blocks.addAll(all.where((element) =>
              element.actions
                  .if_action_exist(BlockAction.archive_block.getactionTitle) ==
              false));
          archived_blocks.addAll(all.where((element) =>
              element.actions
                  .if_action_exist(BlockAction.archive_block.getactionTitle) ==
              true));
        }
        print("get data of blocks");

        notifyListeners();
      });
    } catch (e) {}
  }

  List<SubFraction> subfractions = [];
  List<BlockModel> all = [];
  List<BlockModel> blocks = [];
  List<BlockModel> archived_blocks = [];
  List<BlockModel> search = [];

  // c() {
  // print(99999);
  // for (var el in blocks.where((element) => element.fractions.isNotEmpty)) {
  //        el.fractions.clear();
  //   FirebaseDatabase.instance.ref("blocks/${el.Block_Id}").set(el.toJson());
  // }
  // }

  c() {
    // if (all.isNotEmpty) {
    //   for (var element in all) {
    //     element.item.volume =
    //         element.item.H * element.item.L * element.item.W / 1000000;
    //     element.item.wight = element.item.H *
    //         element.item.L *
    //         element.item.W *
    //         element.item.density /
    //         1000000;
    //   }
    //   var s = {};
    //   s.addEntries(
    //       all.map((el) => MapEntry("${el.Block_Id}", el.toJson().toString())));

    //   FirebaseDatabase.instance.ref("blocks").set(s);
    // }
  }

  void runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      search = blocks;
    } else {
      search = blocks
          .where((user) => user.number.toString().contains(enteredKeyword)
              // .toString().toLowerCase() ==
              // .contains(enteredKeyword.toLowerCase()))
              // enteredKeyword.toLowerCase()
              )
          .toList()
          .sortedBy<num>((element) => element.number)
          .toList();

      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh_the_UI();
  }

  Refresh_the_UI() {
    notifyListeners();
  }

  int amountofView = 5;
  int amountofViewForMinVeiwIn_H = 5;
  bool veiwCuttedAndimpatyNotfinals = false;
  addsubfractions(List<SubFraction> supfraction) async {
    BlockModel block = all.firstWhere((element) => element.Block_Id == 1);
    block.fractions
        .firstWhere((element) => element.fraction_ID == 1)
        .SubFractions
        .addAll(supfraction);
    try {
      await FirebaseDatabase.instance.ref("blocks/1").set(block.toJson());
    } catch (e) {}
  }

  addblock(BlockModel block) async {
    try {
      await FirebaseDatabase.instance
          .ref("blocks/${block.Block_Id}")
          .set(block.toJson());
    } catch (e) {}
  }

  addblocklist(List<BlockModel> blocks) async {
    try {
      for (var e in blocks) {
        FirebaseDatabase.instance.ref("blocks/${e.Block_Id}").set(e.toJson());
      }
    } catch (e) {}
  }

  deleteblock(BlockModel block) {
    block.actions.add(BlockAction.archive_block.add);
    try {
      FirebaseDatabase.instance
          .ref("blocks/${block.Block_Id}")
          .set(block.toJson());
      notifyListeners();
    } catch (e) {}
  }

  undeleteblock(BlockModel block) {
    int index = block.actions.indexWhere((element) =>
        element.action == BlockAction.archive_block.getactionTitle);
    block.actions.removeAt(index);

    try {
      FirebaseDatabase.instance
          .ref("blocks/${block.Block_Id}")
          .set(block.toJson());
      notifyListeners();
    } catch (e) {}
  }

  consumeblock(BlockModel block, String outto) {
    block.actions.add(BlockAction.consume_block.add);
    block.OutTo = outto;
    try {
      FirebaseDatabase.instance
          .ref("blocks/${block.Block_Id}")
          .set(block.toJson());
      notifyListeners();
    } catch (e) {}
  }

  unconsumeblock(BlockModel block) {
    int index = block.actions.indexWhere((element) =>
        element.action == BlockAction.consume_block.getactionTitle);
    block.actions.removeAt(index);
    block.actions.add(BlockAction.unconsume_block.add);

    try {
      FirebaseDatabase.instance
          .ref("blocks/${block.Block_Id}")
          .set(block.toJson());
      notifyListeners();
    } catch (e) {}
  }

  finishblock(BlockModel block) {
    block.actions.add(BlockAction.cut_block_on_H.add);

    try {
      FirebaseDatabase.instance
          .ref("blocks/${block.Block_Id}")
          .set(block.toJson());
      notifyListeners();
    } catch (e) {}
  }

  unfinishblock(BlockModel block) {
    int index = block.actions.indexWhere((element) =>
        element.action == BlockAction.cut_block_on_H.getactionTitle);
    block.actions.removeAt(index);
    try {
      FirebaseDatabase.instance
          .ref("blocks/${block.Block_Id}")
          .set(block.toJson());
      notifyListeners();
    } catch (e) {}
  }

  Cut_block({
    required BlockModel block,
  }) {
    try {
      FirebaseDatabase.instance
          .ref("blocks/${block.Block_Id}")
          .set(block.toJson());
    } catch (e) {}
  }

  Add_not_finalTo_block(
      {required BlockModel block, required NotFinal notFinal}) {
    block.notFinals.add(notFinal);

    try {
      FirebaseDatabase.instance
          .ref("blocks/${block.Block_Id}")
          .set(block.toJson());
      notifyListeners();
    } catch (e) {}
  }

  UnCutBlock_FromH({
    required BlockModel block,
  }) {
    int index = block.actions.indexWhere((element) =>
        element.action == BlockAction.cut_block_on_H.getactionTitle);
    block.actions.removeAt(index);
    block.actions.add(BlockAction.UN_cut_block_on_H.add);

    block.Hscissor = 0;
    block.fractions.clear();
    block.notFinals.clear();

    try {
      FirebaseDatabase.instance
          .ref("blocks/${block.Block_Id}")
          .set(block.toJson());
      notifyListeners();
    } catch (e) {}
  }

//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
  add_on_R_scissor(
      {required FractionModel fractiond,
      required int lastStage,
      required int Rscissor}) {
    BlockModel block =
        blocks.firstWhere((element) => element.Block_Id == fractiond.block_ID);
    var f = block.fractions
        .firstWhere((element) => element.fraction_ID == fractiond.fraction_ID);

    f.Rscissor = Rscissor;
    f.actions.add(FractionActon.cut_fraction_OnRscissor.add);
    f.stagenum = lastStage;
    f.underOperation = false;

    try {
      FirebaseDatabase.instance
          .ref("blocks/${block.Block_Id}")
          .set(block.toJson());
      notifyListeners();
    } catch (e) {}
  }

  remove_from_R_scissor({
    required FractionModel fraction,
  }) {
    BlockModel block =
        blocks.firstWhere((element) => element.Block_Id == fraction.block_ID);
    var f = block.fractions
        .firstWhere((element) => element.fraction_ID == fraction.fraction_ID);

    f.Rscissor = 0;
    f.actions.add(FractionActon.archive_fraction.add);
    f.stagenum = 0;
    f.underOperation = true;

    try {
      FirebaseDatabase.instance
          .ref("blocks/${block.Block_Id}")
          .set(block.toJson());
      notifyListeners();
    } catch (e) {}
  }

//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
  add_on_A_scissor(
      {required BuildContext context,
      required FractionModel fractiond,
      required int lastStage,
      required int Ascissor}) {
    BlockModel block =
        blocks.firstWhere((element) => element.Block_Id == fractiond.block_ID);
    var f = block.fractions
        .firstWhere((element) => element.fraction_ID == fractiond.fraction_ID);

    f.Ascissor = Ascissor;
    f.actions.add(FractionActon.cut_fraction_OnAscissor.add);
    f.stagenum = lastStage;

    try {
      FirebaseDatabase.instance
          .ref("blocks/${block.Block_Id}")
          .set(block.toJson());
      notifyListeners();
    } catch (e) {}
  }

//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
  var initialDateRange =
      DateTimeRange(start: DateTime(2024, 1, 1), end: DateTime.now());
  filterBlocksCreatedBetweenTowDates() {
    List<BlockModel> filterdBlocks = [];
    for (var date
        in getDaysInBeteween(initialDateRange.start, initialDateRange.end)) {
      for (var block in blocks) {
        DateTime blockHaveDate = block.actions
            .get_Date_of_action(BlockAction.create_block.getactionTitle);
        if (blockHaveDate.day == date.day) {
          filterdBlocks.add(block);
        }
      }
    }
    blocks.clear();
    blocks.addAll(filterdBlocks);
  }

  int initialDateRange2 = DateTime.now().formatToInt();

  List<BlockModel> filterBlocksBalanceBetweenTowDates2() {
    List<BlockModel> f = blocks
        .where((element) =>
            element.actions
                .get_Date_of_action(BlockAction.create_block.getactionTitle)
                .formatToInt() <=
            initialDateRange2)
        .toList();
    f.removeWhere((element) =>
        element.actions
                .if_action_exist(BlockAction.consume_block.getactionTitle) ==
            true &&
        element.actions
                .get_Date_of_action(BlockAction.consume_block.getactionTitle)
                .formatToInt() <=
            initialDateRange2);
    return f;
  }

  edit_cell_size(dynamic oldvalue, int id, String cell, List<String> newvalue) {
    BlockModel user = blocks.where((element) => element.Block_Id == id).first;

    user.actions.add(ActionModel(
        action:
            "edit $cell of block  ${user.serial}/${user.number}/  from  $oldvalue  to  $newvalue",
        who: FirebaseAuth.instance.currentUser!.email ?? "",
        when: DateTime.now()));
    user.item.L = newvalue[0].to_double();
    user.item.W = newvalue[1].to_double();
    user.item.H = newvalue[2].to_double();

    try {
      FirebaseDatabase.instance
          .ref("blocks/${user.Block_Id}")
          .set(user.toJson());
    } catch (e) {}
  }

  edit_cell(int id, String cell, String newvalue) {
    BlockModel user = blocks.where((element) => element.Block_Id == id).first;

    user.actions.add(ActionModel(
        action: "edit $cell",
        who: FirebaseAuth.instance.currentUser!.email ?? "",
        when: DateTime.now()));
    cell == "color" ? user.item.color = newvalue : DoNothingAction();
    cell == "type" ? user.item.type = newvalue : DoNothingAction();
    cell == "density"
        ? user.item.density = newvalue.to_double()
        : DoNothingAction();
    cell == "serial" ? user.serial = newvalue : DoNothingAction();
    cell == "num" ? user.number = newvalue.to_int() : DoNothingAction();
    cell == "description" ? user.discreption = newvalue : DoNothingAction();
    cell == "wight"
        ? user.item.wight = newvalue.to_double()
        : DoNothingAction();
    try {
      FirebaseDatabase.instance
          .ref("blocks/${user.Block_Id}")
          .set(user.toJson());
    } catch (e) {}
  }

//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz

  void add_Not_final_ToFractionR(
      {required FractionModel fractiond,
      required String type,
      required int Rscissord,
      required double wight}) {
    var b =
        blocks.firstWhere((element) => element.Block_Id == fractiond.block_ID);
    var f = b.fractions
        .firstWhere((element) => element.fraction_ID == fractiond.fraction_ID);
    f.notfinals.add(NotFinal(
        notFinal_ID: DateTime.now().microsecondsSinceEpoch,
        sapa_ID: f.sapa_ID,
        block_ID: f.block_ID,
        fraction_ID: f.fraction_ID,
        StockRequisetionOrder_ID: 0,
        stage: f.stagenum,
        wight: wight,
        type: type,
        scissor: 3 + f.Rscissor,
        actions: [NotFinalAction.create_Not_final_cumingFrom_R.add]));
    f.underOperation = false;
    try {
      FirebaseDatabase.instance.ref("blocks/${b.Block_Id}").set(b.toJson());
    } catch (e) {}
  }

  void add_Not_final_ToFractionA(
      {required FractionModel fractiond,
      required String type,
      required int Ascissord,
      required double wight}) {
    var b =
        blocks.firstWhere((element) => element.Block_Id == fractiond.block_ID);
    var f = b.fractions
        .firstWhere((element) => element.fraction_ID == fractiond.fraction_ID);
    f.notfinals.add(NotFinal(
        notFinal_ID: DateTime.now().microsecondsSinceEpoch,
        sapa_ID: f.sapa_ID,
        block_ID: f.block_ID,
        fraction_ID: f.fraction_ID,
        StockRequisetionOrder_ID: 0,
        stage: f.stagenum,
        wight: wight,
        type: type,
        scissor: 7,
        actions: [NotFinalAction.create_Not_final_cumingFrom_A.add]));
    f.underOperation = false;
    try {
      FirebaseDatabase.instance.ref("blocks/${b.Block_Id}").set(b.toJson());
    } catch (e) {}
  }
}
