// ignore_for_file: non_constant_identifier_names, empty_catches, file_names, camel_case_types

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';

class Fractions_Controller extends ChangeNotifier {
  get_Fractions_data() async {
    try {
      await FirebaseDatabase.instance
          .ref("fractions")
          .onValue
          .first
          .then((value) async {
        await getInitialData(value.snapshot);
      });

      FirebaseDatabase.instance
          .ref("fractions")
          .onChildChanged
          .listen((vv) async {
        await refrech(vv);
      });
    } catch (e) {}
  }

  getInitialData(DataSnapshot v) async {
    all.clear();
    archived_fractions.clear();
    fractions.clear();
    for (var item in v.children) {
      all.add(FractionModel.fromJson(item.value.toString()));
    }

    fractions.addAll(all.where((element) =>
        element.actions
            .if_action_exist(FractionActon.archive_fraction.getTitle) ==
        false));
    archived_fractions.addAll(all.where((element) =>
        element.actions
            .if_action_exist(FractionActon.archive_fraction.getTitle) ==
        true));
    notifyListeners();
    print("get initial data of fractions");
  }

  refrech(DatabaseEvent vv) async {
    FractionModel newvalue =
        FractionModel.fromJson(vv.snapshot.value as String);

//--------------------------------------------------
    all.removeWhere((element) => element.fraction_ID == newvalue.fraction_ID);
    all.add(newvalue);
//--------------------------------------------------

    fractions
        .removeWhere((element) => element.fraction_ID == newvalue.fraction_ID);

    if (newvalue.actions.block_action_Stutus(BlockAction.archive_block) ==
        false) {
      fractions.add(newvalue);
    } else {
      archived_fractions.add(newvalue);
    }

    notifyListeners();
    print("refrech datata of block blocks in listen");
  }

  List<FractionModel> all = [];
  List<FractionModel> fractions = [];
  List<FractionModel> archived_fractions = [];

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

  Refresh_the_UI() {
    notifyListeners();
  }

  addfractions(FractionModel fraction) async {
    try {
      await FirebaseDatabase.instance
          .ref("fractions/${fraction.fraction_ID}")
          .set(fraction.toJson())
          .whenComplete(() => get_Fractions_data());
    } catch (e) {}
  }

  addfractionslist(List<FractionModel> fractions) async {
    try {
      if (all.isNotEmpty) {
        all.addAll(fractions);
        var s = {};
        s.addEntries(all.map(
            (el) => MapEntry("${el.fraction_ID}", el.toJson().toString())));

        FirebaseDatabase.instance
            .ref("fractions")
            .set(s)
            .whenComplete(() => get_Fractions_data());
      }
    } catch (e) {}
  }

  deletefractions(FractionModel fraction) {
    fraction.actions.add(FractionActon.archive_fraction.add);
    try {
      FirebaseDatabase.instance
          .ref("fractions/${fraction.fraction_ID}")
          .set(fraction.toJson());
    } catch (e) {}
  }

  undeleteFraction(FractionModel fraction) {
    int index = fraction.actions.indexWhere(
        (element) => element.action == FractionActon.archive_fraction.getTitle);
    fraction.actions.removeAt(index);

    try {
      FirebaseDatabase.instance
          .ref("fractions/${fraction.fraction_ID}")
          .set(fraction.toJson());
      notifyListeners();
    } catch (e) {}
  }

//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
  cut_Fraction_on_R_scissor(
      {required FractionModel fractiond,
      required int lastStage,
      required int Rscissor}) {
    fractiond.Rscissor = Rscissor;
    fractiond.actions.add(FractionActon.cut_fraction_OnRscissor.add);
    fractiond.stagenum = lastStage;
    fractiond.underOperation = false;

    try {
      FirebaseDatabase.instance
          .ref("fractions/${fractiond.fraction_ID}")
          .set(fractiond.toJson());
      notifyListeners();
    } catch (e) {}
  }

  remove_cuttedFraction_from_R_scissor({
    required FractionModel fraction,
  }) {
    fraction.Rscissor = 0;
    fraction.actions
        .removeWhere((element) => element.action == "cut_fraction_OnRscissor");
    fraction.actions.add(FractionActon.Uncut_fraction_OnRscissor.add);
    fraction.stagenum = 0;
    fraction.underOperation = true;

    try {
      FirebaseDatabase.instance
          .ref("fractions/${fraction.fraction_ID}")
          .set(fraction.toJson());
      notifyListeners();
    } catch (e) {}
  }

  cut_Fraction_on_A_scissor(
      {required FractionModel fractiond,
      required int lastStage,
      required int Ascissor}) {
    fractiond.Ascissor = Ascissor;
    fractiond.actions.add(FractionActon.cut_fraction_OnAscissor.add);
    fractiond.stagenum = lastStage;

    try {
      FirebaseDatabase.instance
          .ref("blocks/${fractiond.fraction_ID}")
          .set(fractiond.toJson());
      notifyListeners();
    } catch (e) {}
  }

//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz

  void add_Not_final_ToFraction_cutted_On_R(
      {required FractionModel fractiond,
      required String type,
      required int Rscissord,
      required double wight}) {
    fractiond.notfinals.add(NotFinal(
        notFinal_ID: DateTime.now().microsecondsSinceEpoch,
        sapa_ID: fractiond.sapa_ID,
        block_ID: fractiond.block_ID,
        fraction_ID: fractiond.fraction_ID,
        StockRequisetionOrder_ID: 0,
        stage: fractiond.stagenum,
        wight: wight,
        type: type,
        scissor: 3 + fractiond.Rscissor,
        actions: [NotFinalAction.create_Not_final_cumingFrom_R.add]));
    fractiond.underOperation = false;
    try {
      FirebaseDatabase.instance
          .ref("blocks/${fractiond.fraction_ID}")
          .set(fractiond.toJson());
    } catch (e) {}
  }

  void add_Not_final_ToFraction_cutted_on_A(
      {required FractionModel fractiond,
      required String type,
      required int Ascissord,
      required double wight}) {
    fractiond.notfinals.add(NotFinal(
        notFinal_ID: DateTime.now().microsecondsSinceEpoch,
        sapa_ID: fractiond.sapa_ID,
        block_ID: fractiond.block_ID,
        fraction_ID: fractiond.fraction_ID,
        StockRequisetionOrder_ID: 0,
        stage: fractiond.stagenum,
        wight: wight,
        type: type,
        scissor: 7,
        actions: [NotFinalAction.create_Not_final_cumingFrom_A.add]));
    fractiond.underOperation = false;
    try {
      FirebaseDatabase.instance
          .ref("blocks/${fractiond.fraction_ID}")
          .set(fractiond.toJson());
    } catch (e) {}
  }
}
