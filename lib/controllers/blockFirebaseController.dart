// ignore_for_file: non_constant_identifier_names, empty_catches, file_names, unused_element
import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/data/sharedprefs.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:http/http.dart' as http;
import 'package:jason_company/ui/recources/publicVariables.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BlockFirebasecontroller extends ChangeNotifier {
  List<BlockModel> all = [];

  List<BlockModel> blocks = [];
  List<BlockModel> archived_blocks = [];
  static late WebSocketChannel channel;
  getData() {
    if (internet == true) {
      Blocks_From_firebase();
    } else {
      Blocks_From_Server();
    }
  }

  Blocks_From_firebase() {
    if (Platform.isAndroid) {
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
        print("get data of blocks");
   
        notifyListeners();
      });
    }
  }

  Blocks_From_Server() async {
    // get for the first time
    Uri uri = Uri.http('192.168.1.$ip:8080', '/blocks').replace(
        queryParameters: {
          'avilable':true
        });
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      blocks.clear();
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var block = BlockModel.fromMap(element);
        if (block.actions
                .if_action_exist(BlockAction.archive_block.getactionTitle) ==
            false) {
          blocks.add(block);
        }
      }
      notifyListeners();
    }
    //
    Uri uri2 = Uri.parse('ws://192.168.1.$ip:8080/blocks/ws').replace(
        queryParameters: {
          'username': Sharedprfs.email,
          'password': Sharedprfs.password
        });
    channel = WebSocketChannel.connect(uri2);
    channel.stream.forEach((u) {
      BlockModel user = BlockModel.fromJson(u);
      var index = blocks.map((e) => e.Block_Id).toList().indexOf(user.Block_Id);
      if (user.actions
              .if_action_exist(BlockAction.archive_block.getactionTitle) ==
          false) {
        if (index == -1) {
          blocks.add(user);
        } else {
          blocks.removeAt(index);
          blocks.add(user);
        }
      }
      notifyListeners();
    });
  }

  addblock(BlockModel block) async {
    if (internet == true) {
      await FirebaseDatabase.instance
          .ref("blocks/${block.Block_Id}")
          .set(block.toJson());

      await FirebaseDatabase.instance
          .ref("temps/${block.Block_Id}")
          .set(jsonEncode("{'blocks':${block.Block_Id}}"));
    } else {
      channel.sink.add(block.toJson());
    }
  }

  addblocklist(List<BlockModel> blocks) async {
    if (internet == true) {
      for (var b in blocks) {
        await FirebaseDatabase.instance
            .ref("blocks/${b.Block_Id}")
            .set(b.toJson());
      }
    } else {
      for (var b in blocks) {
        channel.sink.add(b.toJson());
      }
    }
  }

  updateBlock(BlockModel block) async {
    if (internet == true) {
      await FirebaseDatabase.instance
          .ref("blocks/${block.Block_Id}")
          .set(block.toJson());
    } else {
      channel.sink.add(block.toJson());
    }
  }

  c() {
    if (all.isNotEmpty) {
      // for (var element in all) {
      //   element.Hscissor = 0;
      // }
      // for (var element in all) {
      //   element.Hscissor=15;
      // }
      // for (var element in all.where((element) =>
      //     element.actions
      //             .if_action_exist(BlockAction.consume_block.getactionTitle) ==
      //         false
      //     //     &&
      //     // element.actions
      //     //         .get_Date_of_action(BlockAction.consume_block.getactionTitle)
      //     //         .formatToInt() ==
      //     //     DateTime.now().formatToInt()
      //         )
      //         ) {
      //   element.Hscissor = 0;
      // }

      //   var s = {};
      //   s.addEntries(
      //       all.map((el) => MapEntry("${el.Block_Id}", el.toJson().toString())));
      //   FirebaseDatabase.instance.ref("blocks").set(s);
      //   FirebaseDatabase.instance.ref("blocks").onValue.first.then((value) {
      //     getInitialData(value.snapshot);
      //   });
    }
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
        who: Sharedprfs.email ?? "",
        when: DateTime.now()));
    user.item.L = newvalue[0].to_double();
    user.item.W = newvalue[1].to_double();
    user.item.H = newvalue[2].to_double();
    updateBlock(user);
  }

  edit_cell(int id, String cell, String newvalue) {
    BlockModel user = blocks.where((element) => element.Block_Id == id).first;

    user.actions.add(ActionModel(
        action: "edit $cell",
        who: Sharedprfs.email ?? "",
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
    updateBlock(user);
  }

//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
}
