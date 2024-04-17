// ignore_for_file: non_constant_identifier_names, empty_catches, file_names
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/controllers/bFractionsController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/sH/H1_veiwModel.dart';

class BlockFirebasecontroller extends ChangeNotifier {
  get_blocks_data() async {
    await FirebaseDatabase.instance
        .ref("blocks")
        .onValue
        .first
        .then((value) async {
      await getInitialData(value.snapshot);
    });

    FirebaseDatabase.instance.ref("blocks").onChildChanged.listen((vv) {
      print("onChildChanged");
      refrech(vv);
    });
    // FirebaseDatabase.instance.ref("blocks").onChildAdded.listen((vv) async {
    //   print("onChildAdded");
    //   await refrech(vv);
    // });
  }

  getInitialData(DataSnapshot v) async {
    all.clear();
    archived_blocks.clear();
    blocks.clear();
    for (var item in v.children) {
      all.add(BlockModel.fromJson(item.value.toString()));
    }

    blocks.addAll(all.where((element) =>
        element.actions
            .if_action_exist(BlockAction.archive_block.getactionTitle) ==
        false));
    archived_blocks.addAll(all.where((element) =>
        element.actions
            .if_action_exist(BlockAction.archive_block.getactionTitle) ==
        true));
    notifyListeners();
    print("get initial data of blocks");
  }

  refrech(DatabaseEvent vv) async {
    BlockModel newvalue = BlockModel.fromJson(vv.snapshot.value as String);

//--------------------------------------------------
    all.removeWhere((element) => element.Block_Id == newvalue.Block_Id);
    all.add(newvalue);
//--------------------------------------------------
    // blocks.clear();
    // blocks.addAll(all.where((element) =>
    //     element.actions
    //         .if_action_exist(BlockAction.archive_block.getactionTitle) ==
    //     false));
    // archived_blocks.clear();
    // archived_blocks.addAll(all.where((element) =>
    //     element.actions
    //         .if_action_exist(BlockAction.archive_block.getactionTitle) ==
    //     true));
    blocks.removeWhere((element) => element.Block_Id == newvalue.Block_Id);
    archived_blocks
        .removeWhere((element) => element.Block_Id == newvalue.Block_Id);

    if (newvalue.actions.block_action_Stutus(BlockAction.archive_block) ==
        false) {
      blocks.add(newvalue);
    } else {
      archived_blocks.add(newvalue);
    }

    notifyListeners();
    print("refrech datata of blocks");
  }

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
    if (all.isNotEmpty) {
      for (var element in all) {
        element.Hscissor=0;
    // element.item.volume =
    //     element.item.H * element.item.L * element.item.W / 1000000;
    // element.item.wight = element.item.H *
    //     element.item.L *
    //     element.item.W *
    //     element.item.density /
    //     1000000;
    //     element.notFinals.clear();
    //     element.fractions.clear();
      }
      for (var element in all.where((element) => element.actions.get_Date_of_action(BlockAction.consume_block.getactionTitle).formatToInt()<DateTime.now().formatToInt())) {
        element.Hscissor=15;
    // element.item.volume =
    //     element.item.H * element.item.L * element.item.W / 1000000;
    // element.item.wight = element.item.H *
    //     element.item.L *
    //     element.item.W *
    //     element.item.density /
    //     1000000;
    //     element.notFinals.clear();
    //     element.fractions.clear();
      }
      var s = {};
      s.addEntries(
          all.map((el) => MapEntry("${el.Block_Id}", el.toJson().toString())));

      FirebaseDatabase.instance.ref("blocks").set(s);
    }
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

  String searchinconsumed = "";
  String searchin_H = "";
  String searchin_blockstock = "";
  int amountofView = 5;
  int amountofViewForMinVeiwIn_H = 5;
  bool veiwCuttedAndimpatyNotfinals = false;

  addblock(BlockModel block) async {
    try {
      await FirebaseDatabase.instance
          .ref("blocks/${block.Block_Id}")
          .set(block.toJson())
          .whenComplete(() => get_blocks_data());
    } catch (e) {}
  }

  addblocklist(List<BlockModel> blocks) async {
    try {
      if (all.isNotEmpty) {
        all.addAll(blocks);
        var s = {};
        s.addEntries(all
            .map((el) => MapEntry("${el.Block_Id}", el.toJson().toString())));

        FirebaseDatabase.instance
            .ref("blocks")
            .set(s)
            .whenComplete(() => get_blocks_data());
      }
    } catch (e) {}
  }

  deleteblock(BlockModel block) {
    block.actions.add(BlockAction.archive_block.add);
    FirebaseDatabase.instance
        .ref("blocks/${block.Block_Id}")
        .set(block.toJson());
  }

  undeleteblock(BlockModel block) {
    int index = block.actions.indexWhere((element) =>
        element.action == BlockAction.archive_block.getactionTitle);
    block.actions.removeAt(index);
    FirebaseDatabase.instance
        .ref("blocks/${block.Block_Id}")
        .set(block.toJson());
  }

  consumeblock(BlockModel block, String outto) {
    block.actions.add(BlockAction.consume_block.add);
    block.OutTo = outto;
    try {
      FirebaseDatabase.instance
          .ref("blocks/${block.Block_Id}")
          .set(block.toJson());
    } catch (e) {}
  }

  unconsumeblock(BlockModel block) {
    int index = block.actions.indexWhere((element) =>
        element.action == BlockAction.consume_block.getactionTitle);
    block.actions.removeAt(index);
    block.actions.add(BlockAction.unconsume_block.add);

    FirebaseDatabase.instance
        .ref("blocks/${block.Block_Id}")
        .set(block.toJson());
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

    FirebaseDatabase.instance
        .ref("blocks/${block.Block_Id}")
        .set(block.toJson());
  }

  UnCutBlock_FromH({
    required BuildContext context,
    required BlockModel block,
  }) {
    Fractions_Controller fractioncontroller = Fractions_Controller();
    H1VeiwModel vm = H1VeiwModel();
    int index = block.actions.indexWhere((element) =>
        element.action == BlockAction.cut_block_on_H.getactionTitle);
    block.actions.removeAt(index);
    block.actions.add(BlockAction.UN_cut_block_on_H.add);

    block.Hscissor = 0;
    // clear the fractions
    vm.getFractinsOFABlock(context, block).forEach((element) {
      fractioncontroller.deletefractions(element);
    });
    block.notFinals.clear();

    FirebaseDatabase.instance
        .ref("blocks/${block.Block_Id}")
        .set(block.toJson());
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
}
