// ignore_for_file: non_constant_identifier_names

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/controllers/setting_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/stockCheck/stockchek_veiwModel.dart';
import 'package:provider/provider.dart';

extension Permition on Widget {
  Widget permition(BuildContext context, UserPermition permition) {
    return permitionss(context, permition) ? this : const SizedBox();
  }
}

extension Brovider on BuildContext {
  gonext(BuildContext context, Widget route) {
    checkAuth(context);
    Navigator.of(this).push(MaterialPageRoute(builder: (context) => route));
  }

  gonextAnsRemove(BuildContext context, Widget route) {
    checkAuth(context);
    Navigator.of(this).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => route), (d) => false);
  }
}

extension Dnl on DateTime {
  String formatt() {
    String formateeddate = DateFormat("yyyy/MM/dd").format(this);
    return formateeddate;
  }

  int formatToInt() {
    String formateeddate = DateFormat("yyyyMMdd").format(this);
    return formateeddate.to_int();
  }

  String formatt2() {
    String formateeddate = DateFormat('yyyy-MM-dd -hh:mm a').format(this);
    return formateeddate;
  }
}

extension MeineVer on double {
  String get toMoney => '$removeTrailingZeros₺';
  String get removeTrailingZeros {
    // return if complies to int
    if (this % 1 == 0) return toInt().toString();
    // remove trailing zeroes
    String str = '$this'.replaceAll(RegExp(r'0*$'), '');
    // reduce fraction max length to 2
    if (str.contains('.')) {
      final fr = str.split('.');
      if (2 < fr[1].length) {
        str = '${fr[0]}.${fr[1][0]}${fr[1][1]}';
      }
    }
    return str;
  }
}

extension Sdd on List<int> {
  int gggggggggggggg() {
    List<int> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i] == nonRepetitive[j]) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive.length;
  }
}

extension Toint on String {
  int to_int() {
    return int.tryParse(this) ?? 0;
  }

  double to_double() {
    return double.parse(this);
  }
}

extension Fd on List<ChemicalsModel> {
  List<ChemicalsModel> FilterDateBetween_balance(DateTime end) {
    return where((element) =>
        element.actions
                .get_Date_of_action(
                    ChemicalAction.creat_new_ChemicalAction_item.getTitle)
                .formatToInt() <=
            end.formatToInt() &&
        element.actions
                .get_Date_of_action(
                    ChemicalAction.creat_Out_ChemicalAction_item.getTitle)
                .formatToInt() <=
            end.formatToInt()).toList();
  }

  List<ChemicalsModel> dfffffffff(DateTimeRange initialDateRange) {
    return where((element) =>
        element.actions
                .get_Date_of_action(
                    ChemicalAction.creat_new_ChemicalAction_item.getTitle)
                .formatToInt() >=
            initialDateRange.start.formatToInt() &&
        element.actions
                .get_Date_of_action(
                    ChemicalAction.creat_Out_ChemicalAction_item.getTitle)
                .formatToInt() >=
            initialDateRange.start.formatToInt() &&
        element.actions
                .get_Date_of_action(
                    ChemicalAction.creat_new_ChemicalAction_item.getTitle)
                .formatToInt() <=
            initialDateRange.end.formatToInt() &&
        element.actions
                .get_Date_of_action(
                    ChemicalAction.creat_Out_ChemicalAction_item.getTitle)
                .formatToInt() <=
            initialDateRange.end.formatToInt()).toList();
  }

  List<ChemicalsModel> filterItemsPasedOnFamilys(
      BuildContext context, List<String> familys) {
    List<ChemicalsModel> l = [];
    for (var f in familys) {
      for (var i in this) {
        if (i.family == f) {
          l.add(i);
        }
      }
    }

    return l;
  }

  List<ChemicalsModel> filterFamilyOrName(
      List<String> selctedNames, List<String> selctedFamilys) {
    List<ChemicalsModel> f = this;
    List<ChemicalsModel> s = [];

    if (selctedFamilys.isEmpty) {
      s.addAll(f);
    }

    if (selctedNames.isNotEmpty) {
      for (var g in selctedNames) {
        s.addAll(f.where((element) => element.name == g).toList());
      }
    }

    if (selctedFamilys.isNotEmpty) {
      for (var g in selctedFamilys) {
        s.addAll(f.where((element) => element.family == g).toList());
        print(g);
      }
    }
    return s;
  }

  List<ChemicalsModel> FilterChemicals() {
    List<ChemicalsModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].family == nonRepetitive[j].family &&
            this[i].name == nonRepetitive[j].name) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }
}

extension sdfdsf on List<SubFraction> {
  List<SubFraction> ReturnFirstPiriodBalanceOFUnderoperationSubFractons(
      DateTimeRange initialDateRange) {
    //------------------------------------------------
    List<SubFraction> fractionscreatedBeforeperiod = where((element) =>
        element.actions.if_action_exist(
            subfractionAction.create_new_subfraction.getTitle) &&
        element.actions
                .get_Date_of_action(
                    subfractionAction.create_new_subfraction.getTitle)
                .formatToInt() <
            initialDateRange.start.formatToInt()).toList();

    List<SubFraction> fractionscuttedBeforeStart = where((element) =>
        (element.actions.if_action_exist(subfractionAction.cut_subfraction_on_R.getTitle) == true &&
            element.actions
                    .get_Date_of_action(
                        subfractionAction.cut_subfraction_on_R.getTitle)
                    .formatToInt() <
                initialDateRange.start.formatToInt()) ||
        (element.actions.if_action_exist(subfractionAction.cut_subfraction_on_A.getTitle) == true &&
            element.actions
                    .get_Date_of_action(
                        subfractionAction.cut_subfraction_on_A.getTitle)
                    .formatToInt() <
                initialDateRange.start.formatToInt()) ||
        (element.actions.if_action_exist(subfractionAction.cut_subfraction_on_H.getTitle) == true &&
            element.actions
                    .get_Date_of_action(subfractionAction.cut_subfraction_on_H.getTitle)
                    .formatToInt() <
                initialDateRange.start.formatToInt())).toList();

    List<SubFraction> firstperiocBalance = //رصيد قبل الفتره
        List.from(Set.from(fractionscreatedBeforeperiod)
            .difference(Set.from(fractionscuttedBeforeStart)));
    return firstperiocBalance;
  }

  List<SubFraction> filtersubfractions() {
    List<SubFraction> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].item.H == nonRepetitive[j].item.H &&
            this[i].item.W == nonRepetitive[j].item.W &&
            this[i].item.L == nonRepetitive[j].item.L &&
            this[i].item.color == nonRepetitive[j].item.color &&
            this[i].item.type == nonRepetitive[j].item.type &&
            this[i].item.density == nonRepetitive[j].item.density) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }
}

extension Filter on List<FinalProductModel> {
  int countOf(FinalProductModel e) {
    var a = where((element) =>
        element.item.L == e.item.L &&
        element.item.W == e.item.W &&
        element.item.H == e.item.H &&
        element.item.color == e.item.color &&
        element.item.type == e.item.type &&
        element.item.density == e.item.density).map((e) => e.item.amount);

    return a.isEmpty ? 0 : a.reduce((a, b) => a + b);
  }

  List<FinalProductModel> filterItemsPasedOnDensites(
      BuildContext context, List<String> densities) {
    List<FinalProductModel> l = [];
    if (densities.isNotEmpty) {
      for (var f in densities) {
        for (var i in this) {
          if (i.item.density.toString() == f) {
            l.add(i);
          }
        }
      }
      return l;
    } else {
      return this;
    }
  }

  List<FinalProductModel> filterItemsPasedOncolors(
      BuildContext context, List<String> colors) {
    List<FinalProductModel> l = [];
    if (colors.isNotEmpty) {
      for (var f in colors) {
        for (var i in this) {
          if (i.item.color.toString() == f) {
            l.add(i);
          }
        }
      }
      return l;
    } else {
      return this;
    }
  }

  List<FinalProductModel> filterItemsPasedOntypes(
      BuildContext context, List<String> types) {
    List<FinalProductModel> l = [];
    if (types.isNotEmpty) {
      for (var f in types) {
        for (var i in this) {
          if (i.item.type.toString() == f) {
            l.add(i);
          }
        }
      }
      return l;
    } else {
      return this;
    }
  }

  List<FinalProductModel> filterFinalProductDateBetween(
      DateTimeRange initialDateRange) {
    return where((element) =>
        element.actions
                .get_Date_of_action(finalProdcutAction
                    .incert_finalProduct_from_cutingUnit.getactionTitle)
                .formatToInt() >=
            initialDateRange.start.formatToInt() &&
        element.actions
                .get_Date_of_action(finalProdcutAction
                    .incert_finalProduct_from_cutingUnit.getactionTitle)
                .formatToInt() <=
            initialDateRange.end.formatToInt()).toList();
  }

  List<FinalProductModel> filteronfinalproductwithcsissor() {
    List<FinalProductModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].item.H == nonRepetitive[j].item.H &&
            this[i].item.W == nonRepetitive[j].item.W &&
            this[i].item.L == nonRepetitive[j].item.L &&
            this[i].item.color == nonRepetitive[j].item.color &&
            this[i].item.type == nonRepetitive[j].item.type &&
            this[i].customer == nonRepetitive[j].customer &&
            this[i].scissor == nonRepetitive[j].scissor &&
            this[i].item.density == nonRepetitive[j].item.density) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  List<FinalProductModel> filteronfinalproduct() {
    List<FinalProductModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].item.H == nonRepetitive[j].item.H &&
            this[i].item.W == nonRepetitive[j].item.W &&
            this[i].item.L == nonRepetitive[j].item.L &&
            this[i].item.color == nonRepetitive[j].item.color &&
            this[i].item.type == nonRepetitive[j].item.type &&
            this[i].item.density == nonRepetitive[j].item.density) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  List<FinalProductModel> filter_type_density() {
    List<FinalProductModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].item.type == nonRepetitive[j].item.type &&
            this[i].item.density == nonRepetitive[j].item.density) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  List<FinalProductModel> filter_company() {
    List<FinalProductModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].customer == nonRepetitive[j].customer) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  List<FinalProductModel> filter_density_type_size() {
    List<FinalProductModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].item.density == nonRepetitive[j].item.density &&
            this[i].item.type == nonRepetitive[j].item.type &&
            this[i].item.L == nonRepetitive[j].item.L &&
            this[i].item.W == nonRepetitive[j].item.W &&
            this[i].item.H == nonRepetitive[j].item.H) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  List<FinalProductModel> filter_date(BuildContext context, String chosenDate) {
    DateFormat format = DateFormat('yyyy/MM/dd');
    return where((element) =>
        format.format(element.actions.get_Date_of_action(finalProdcutAction
            .incert_finalProduct_from_cutingUnit.getactionTitle)) ==
        chosenDate).toList();
  }
}

extension DD on List<ActionModel> {
  List<ActionModel> filter_date(BuildContext context, String chosenDate) {
    DateFormat format = DateFormat('yyyy/MM/dd');
    return where((element) => format.format(element.when) == chosenDate)
        .toList();
  }
}

// ignore: camel_case_extensions
extension sdsd on List<NotFinal> {
  List<NotFinal> filter_date(BuildContext context) {
    DateFormat format = DateFormat('yyyy/MM/dd');
    return where((element) =>
        format.format(element.actions.get_Date_of_action(
            NotFinalAction.create_Not_final_cumingFrom_H.getTitle)) ==
        context.read<SettingController>().currentDate()).toList();
  }
}

extension Filterfgddf on List<FractionModel> {
  List<FractionModel> ReturnFirstPiriodBalanceOFUnderoperationFractons(
      DateTimeRange initialDateRange) {
    //------------------------------------------------
    List<FractionModel> fractionscreatedBeforeperiod = where((element) =>
        element.actions
            .if_action_exist(FractionActon.creat_fraction.getTitle) &&
        element.actions
                .get_Date_of_action(FractionActon.creat_fraction.getTitle)
                .formatToInt() <
            initialDateRange.start.formatToInt()).toList();
    List<FractionModel> fractionscuttedBeforeStart = where((element) =>
        (element.actions.if_action_exist(FractionActon.cut_fraction_OnRscissor.getTitle) == true &&
            element.actions
                    .get_Date_of_action(
                        FractionActon.cut_fraction_OnRscissor.getTitle)
                    .formatToInt() <
                initialDateRange.start.formatToInt()) ||
        (element.actions.if_action_exist(FractionActon.cut_fraction_OnAscissor.getTitle) == true &&
            element.actions
                    .get_Date_of_action(
                        FractionActon.cut_fraction_OnAscissor.getTitle)
                    .formatToInt() <
                initialDateRange.start.formatToInt()) ||
        (element.actions.if_action_exist(FractionActon.cut_fraction_OnRscissor.getTitle) == true &&
            element.actions
                    .get_Date_of_action(FractionActon.cut_fraction_OnRscissor.getTitle)
                    .formatToInt() <
                initialDateRange.start.formatToInt())).toList();

    List<FractionModel> firstperiocBalance = //رصيد قبل الفتره
        List.from(Set.from(fractionscreatedBeforeperiod)
            .difference(Set.from(fractionscuttedBeforeStart)));
    return firstperiocBalance;
    //------------------------------------------------
    // var fractionscuttedINPeriod = // الغرد المقصوصه فى الغتره
    //     where((element) =>
    //         (element.actions.get_Date_of_action(FractionActon.cut_fraction_OnAscissor.getTitle).formatToInt() >=
    //                 initialDateRange.start.formatToInt() &&
    //             element.actions
    //                     .get_Date_of_action(
    //                         FractionActon.cut_fraction_OnAscissor.getTitle)
    //                     .formatToInt() <
    //                 initialDateRange.end.formatToInt()) ||
    //         (element.actions.get_Date_of_action(FractionActon.cut_fraction_OnRscissor.getTitle).formatToInt() >=
    //                 initialDateRange.start.formatToInt() &&
    //             element.actions
    //                     .get_Date_of_action(
    //                         FractionActon.cut_fraction_OnRscissor.getTitle)
    //                     .formatToInt() <
    //                 initialDateRange.end.formatToInt()) ||
    //         (element.actions.get_Date_of_action(FractionActon.cut_fraction_OnHscissor.getTitle).formatToInt() >=
    //                 initialDateRange.start.formatToInt() &&
    //             element.actions
    //                     .get_Date_of_action(
    //                         FractionActon.cut_fraction_OnHscissor.getTitle)
    //                     .formatToInt() <
    //                 initialDateRange.end.formatToInt())).toList();
    // // print(fractionscuttedINPeriod.length);
    // //------------------------------------------------
    // return List.from(Set.from(firstperiocBalance)
    //     .difference(Set.from(fractionscuttedINPeriod)));
  }

  List<FractionModel> filteronFractionModel() {
    List<FractionModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].block_ID == nonRepetitive[j].block_ID) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  List<FractionModel> filter_Fractios___() {
    List<FractionModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].item.L == nonRepetitive[j].item.L &&
            this[i].item.H == nonRepetitive[j].item.H &&
            this[i].item.color == nonRepetitive[j].item.color &&
            this[i].item.type == nonRepetitive[j].item.type &&
            this[i].item.density == nonRepetitive[j].item.density &&
            this[i].item.W == nonRepetitive[j].item.W) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  List<FractionModel> filter_Fractios_T_D_C() {
    List<FractionModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].item.color == nonRepetitive[j].item.color &&
            this[i].item.type == nonRepetitive[j].item.type &&
            this[i].item.density == nonRepetitive[j].item.density) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

// filter date and not archive
}

extension C33r on List<NotFinal> {
  List<NotFinal> filter_notfinals___() {
    List<NotFinal> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].type == nonRepetitive[j].type) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

// filter date and not archive
}

extension C3 on List<ActionModel> {
  //get finalProdcut date for this action

  //get final prodcut who of this action
  String get_finalProdcut_Who_Of(finalProdcutAction action) {
    return where((element) => element.action == action.getactionTitle)
        .first
        .who;
  }

  String get_order_Who_Of(OrderAction action) {
    return where((element) => element.action == action.getTitle).first.who;
  }

  String get_purche_Who_Of(PurcheAction action) {
    return where((element) => element.action == action.getTitle).first.who;
  }

  String get_block_Who_Of(BlockAction action) {
    return where((element) => element.action == action.getactionTitle)
        .first
        .who;
  }

  String get_Who_Of(String action) {
    return where((element) => element.action == action).first.who;
  }
  //get fraction date for this action

  DateTime get_Date_of_action(String action) {
    return where((element) => element.action == action).isEmpty
        ? DateTime.utc(0)
        : where((element) => element.action == action).first.when;
  }

  //weather this action for block done or not
  bool block_action_Stutus(BlockAction action) {
    return where((element) => element.action == action.getactionTitle)
        .isNotEmpty;
  }

  // return true if action exist
  bool if_action_exist(String actiontitle) {
    return where((element) => element.action == actiontitle).isNotEmpty;
  }
}

extension A1 on List<BlockModel> {
  List<BlockModel> search(String value) {
    if (value.isEmpty) {
      return this;
    } else {
      return where((user) => user.number.toString().contains(value))
          .toList()
          .sortedBy<num>((element) => element.number)
          .reversed
          .toList();

      // we use the toLowerCase() method to make it case-insensitive
    }
  }

  List<BlockModel> search2(String value) {
    if (value.isEmpty) {
      return this;
    } else {
      return where((user) => user.number.toString().contains(value))
          .toList()
          .sortedBy<num>((element) => element.number)
          .toList();

      // we use the toLowerCase() method to make it case-insensitive
    }
  }

  List<BlockModel> filterConsumeDateBetween(DateTimeRange initialDateRange) {
    return where((element) =>
        element.OutTo == "صالة الانتاج" &&
        element.actions
                .get_Date_of_action(BlockAction.consume_block.getactionTitle)
                .formatToInt() >=
            initialDateRange.start.formatToInt() &&
        element.actions
                .get_Date_of_action(BlockAction.consume_block.getactionTitle)
                .formatToInt() <=
            initialDateRange.end.formatToInt()).toList();
  }

  List<BlockModel> filterserials() {
    List<BlockModel> nonRepetitive = [];

    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].serial == nonRepetitive[j].serial) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  List<BlockModel> ffffffffffffff() {
    List<BlockModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].Block_Id == nonRepetitive[j].Block_Id) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  //filter date and archive
  List<BlockModel> filter_date_consumed(BuildContext context) {
    DateFormat format = DateFormat('yyyy/MM/dd');
    return where((element) => element.actions
            .if_action_exist(BlockAction.consume_block.getactionTitle))
        .where((element) =>
            format.format(element.actions.get_Date_of_action(
                BlockAction.consume_block.getactionTitle)) ==
            context.read<SettingController>().currentDate())
        .toList();
  }

  List<BlockModel> filter_filter_type_and_density() {
    List<BlockModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].item.type == nonRepetitive[j].item.type &&
            this[i].item.density == nonRepetitive[j].item.density) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  List<BlockModel> filter_filter_type_and_density_color() {
    List<BlockModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].item.type == nonRepetitive[j].item.type &&
            this[i].item.color == nonRepetitive[j].item.color &&
            this[i].item.density == nonRepetitive[j].item.density) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  List<BlockModel> filter_description() {
    List<BlockModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].discreption == nonRepetitive[j].discreption) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  List<BlockModel> filter_filter_type_density_color_size() {
    List<BlockModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].item.type == nonRepetitive[j].item.type &&
            this[i].item.density == nonRepetitive[j].item.density &&
            this[i].item.color == nonRepetitive[j].item.color &&

            // this[i].hight == nonRepetitive[j].hight &&

            this[i].item.L == nonRepetitive[j].item.L &&
            this[i].item.W == nonRepetitive[j].item.W) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  List<BlockModel> filter_filter_type_density_color_size_serial() {
    List<BlockModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].item.type == nonRepetitive[j].item.type &&
            this[i].item.density == nonRepetitive[j].item.density &&
            this[i].item.color == nonRepetitive[j].item.color &&
            this[i].serial == nonRepetitive[j].serial &&
            this[i].item.L == nonRepetitive[j].item.L &&
            this[i].item.W == nonRepetitive[j].item.W &&
            this[i].item.H == nonRepetitive[j].item.H) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }
}

extension G5 on List<Itme> {
  List<Itme> filterRepeats() {
    List<Itme> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].L == nonRepetitive[j].L &&
            this[i].W == nonRepetitive[j].W &&
            this[i].H == nonRepetitive[j].H &&
            this[i].color == nonRepetitive[j].color &&
            this[i].type == nonRepetitive[j].type &&
            this[i].density == nonRepetitive[j].density) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  int countOf(Itme e) {
    return where((element) =>
        element.L == e.L &&
        element.W == e.W &&
        element.H == e.H &&
        element.color == e.color &&
        element.type == e.type &&
        element.density == e.density).length;
  }

  double volume() {
    return isEmpty
        ? 0
        : map((e) => e.H * e.L * e.W / 1000000).reduce((a, b) => a + b);
  }
}

extension R4 on List<StockCheckModel> {
  List<StockCheckModel> beweenTowDates(int from, int to) {
    return where((element) =>
        element.actions
                .get_Date_of_action(
                    StockCheckAction.creat_new_StockCheck.getTitle)
                .formatToInt() >=
            from &&
        element.actions
                .get_Date_of_action(
                    StockCheckAction.creat_new_StockCheck.getTitle)
                .formatToInt() <=
            to).toList();
  }

  List<StockCheckModel> getIdentCalOf(FinalProdcutBalanceModel e) {
    return where((element) =>
            element.item.L == e.L &&
            element.item.W == e.W &&
            element.item.H == e.H &&
            element.item.density == e.density &&
            element.item.type == e.type &&
            element.item.color == e.color)
        .sortedBy<num>((element) => element.actions
            .get_Date_of_action(StockCheckAction.creat_new_StockCheck.getTitle)
            .formatToInt())
        .toList();
  }
}
