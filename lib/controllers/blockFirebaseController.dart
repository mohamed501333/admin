// ignore_for_file: non_constant_identifier_names, empty_catches, file_names

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

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

          blocks.addAll(all.where((element) =>
              element.actions
                  .if_action_exist(BlockAction.archive_block.getactionTitle) ==
              false));
          archived_blocks.addAll(all.where((element) =>
              element.actions
                  .if_action_exist(BlockAction.archive_block.getactionTitle) ==
              true));
        }

        notifyListeners();
      });
    } catch (e) {}
  }

  List<BlockModel> all = [];
  List<BlockModel> blocks = [];
  List<BlockModel> archived_blocks = [];
  List<BlockModel> search = [];

  c() {
    // for (var el in blocks.where((element) => element.serial == "D30h281223")) {
    //   BlockModel e = BlockModel(
    //       id: el.id,
    //       color: el.color,
    //       density: el.density,
    //       type: el.type,
    //       serial: el.serial,
    //       number: el.number,
    //       Rcissor: el.Rcissor,
    //       Hscissor: el.Hscissor,
    //       width: el.width,
    //       lenth: el.lenth,
    //       hight: el.hight,
    //       wight: el.wight,
    //       cumingFrom: el.cumingFrom,
    //       OutTo: el.OutTo,
    //       notes: el.notes,
    //       fractions: el.fractions,
    //       actions: el.actions,
    //       notfinals: el.notfinals);

    //   FirebaseDatabase.instance.ref("blocks/${el.id}").set(e.toJson());
    // }
  }

  void runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display blocks
      search = blocks;
    } else {
      search = blocks
          .where((user) =>
              user.number.toString().toLowerCase() ==
              // .contains(enteredKeyword.toLowerCase()))
              enteredKeyword.toLowerCase())
          .toList();

      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    // notifyListeners();
  }

  Refresh_the_UI() {
    notifyListeners();
  }

  addblock(BlockModel block) async {
    try {
      await FirebaseDatabase.instance
          .ref("blocks/${block.id}")
          .set(block.toJson());
    } catch (e) {}
  }

  deleteblock(BlockModel block) {
    block.actions.add(BlockAction.archive_block.add);
    try {
      FirebaseDatabase.instance.ref("blocks/${block.id}").set(block.toJson());
      notifyListeners();
    } catch (e) {}
  }

  consumeblock(BlockModel block, String outto) {
    block.actions.add(BlockAction.consume_block.add);
    block.OutTo = outto;
    try {
      FirebaseDatabase.instance.ref("blocks/${block.id}").set(block.toJson());
      notifyListeners();
    } catch (e) {}
  }

  unconsumeblock(BlockModel block) {
    int index = block.actions.indexWhere((element) =>
        element.action == BlockAction.consume_block.getactionTitle);
    block.actions.removeAt(index);
    try {
      FirebaseDatabase.instance.ref("blocks/${block.id}").set(block.toJson());
      notifyListeners();
    } catch (e) {}
  }

  finishblock(BlockModel block) {
    block.actions.add(BlockAction.cut_block_on_H.add);

    try {
      FirebaseDatabase.instance.ref("blocks/${block.id}").set(block.toJson());
      notifyListeners();
    } catch (e) {}
  }

  unfinishblock(BlockModel block) {
    int index = block.actions.indexWhere((element) =>
        element.action == BlockAction.cut_block_on_H.getactionTitle);
    block.actions.removeAt(index);
    try {
      FirebaseDatabase.instance.ref("blocks/${block.id}").set(block.toJson());
      notifyListeners();
    } catch (e) {}
  }

  Add_fraction(
      {required BlockModel block,
      required List<FractionModel> fractions,
      required int Hscissor,
      required NotFinalmodel notfinal}) {
    block.actions.add(BlockAction.cut_block_on_H.add);
    block.Hscissor = Hscissor;
    block.fractions.addAll(fractions);
    block.notfinals.add(notfinal);

    try {
      FirebaseDatabase.instance.ref("blocks/${block.id}").set(block.toJson());
      notifyListeners();
    } catch (e) {}
  }

  Delete_fraction({
    required BlockModel block,
  }) {
    int index = block.actions.indexWhere((element) =>
        element.action == BlockAction.cut_block_on_H.getactionTitle);
    block.actions.removeAt(index);

    block.Hscissor = 0;
    block.fractions.clear();
    block.notfinals.clear();

    try {
      FirebaseDatabase.instance.ref("blocks/${block.id}").set(block.toJson());
      notifyListeners();
    } catch (e) {}
  }

  add_on_R_scissor(
      {required BuildContext context,
      required FractionModel fractiond,
      required int scissor,
      required double w}) {
    BlockModel block = blocks
        .where((element) =>
            element.serial == fractiond.serial &&
            element.number == fractiond.blockmodelmum)
        .toList()
        .first;
    block.fractions
        .where((element) => element.id == fractiond.id)
        .first
        .Rscissor = scissor;
    block.fractions
        .where((element) => element.id == fractiond.id)
        .first
        .notfinals
        .add(NotFinalmodel(
            id: DateTime.now().millisecondsSinceEpoch,
            date: DateTime.now(),
            wight: w.toDouble(),
            type: context.read<ObjectBoxController>().gdet222(),
            Rscissor: scissor,
            Hscissor: 0,
            actions: [NotFinalAction.create_Not_final_cumingFrom_R.add]));
    block.fractions
        .where((element) => element.id == fractiond.id)
        .first
        .actions
        .add(FractionActon.cut_fraction_OnRscissor.add);

    try {
      FirebaseDatabase.instance.ref("blocks/${block.id}").set(block.toJson());
      notifyListeners();
    } catch (e) {}
  }

  var initialDateRange =
      DateTimeRange(start: DateTime(2024, 1, 1), end: DateTime.now());

  filterdatesbbbbb() {
    List<BlockModel> filterdBlocks = [];
    for (var date
        in getDaysInBeteween(initialDateRange.start, initialDateRange.end)) {
      for (var block in blocks) {
        DateTime blockHaveDate =
            block.actions.get_BlockDateOf(BlockAction.create_block);
        if (blockHaveDate.day == date.day) {
          filterdBlocks.add(block);
        }
      }
    }
    blocks.clear();
    blocks.addAll(filterdBlocks);
  }
}
