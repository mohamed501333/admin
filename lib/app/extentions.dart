// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/controllers/ChemicalsController.dart';
import 'package:jason_company/controllers/setting_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';
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
  List<ChemicalsModel> filterItemsPasedOnFamilys(BuildContext context) {
    List<String> selctedFamilys =
        context.read<Chemicals_controller>().selctedFamilys;

    List<ChemicalsModel> items = context.read<Chemicals_controller>().Chemicals;

    List<ChemicalsModel> l = [];
    for (var v in selctedFamilys) {
      l.addAll(items.where((element) => element.family == v).toList());
    }

    return l;
  }
}

extension Filter on List<FinalProductModel> {
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
        if (this[i].hight == nonRepetitive[j].hight &&
            this[i].width == nonRepetitive[j].width &&
            this[i].lenth == nonRepetitive[j].lenth &&
            this[i].color == nonRepetitive[j].color &&
            this[i].type == nonRepetitive[j].type &&
            this[i].customer == nonRepetitive[j].customer &&
            this[i].scissor == nonRepetitive[j].scissor &&
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

  List<FinalProductModel> filteronfinalproduct() {
    List<FinalProductModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].hight == nonRepetitive[j].hight &&
            this[i].width == nonRepetitive[j].width &&
            this[i].lenth == nonRepetitive[j].lenth &&
            this[i].color == nonRepetitive[j].color &&
            this[i].type == nonRepetitive[j].type &&
            this[i].customer == nonRepetitive[j].customer &&
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

  List<FinalProductModel> filter_type_density() {
    List<FinalProductModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].type == nonRepetitive[j].type &&
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
        if (this[i].density == nonRepetitive[j].density &&
            this[i].type == nonRepetitive[j].type &&
            this[i].lenth == nonRepetitive[j].lenth &&
            this[i].width == nonRepetitive[j].width &&
            this[i].hight == nonRepetitive[j].hight) {
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
extension sdsd on List<NotFinalmodel> {
  List<NotFinalmodel> filter_date(BuildContext context) {
    DateFormat format = DateFormat('yyyy/MM/dd');
    return where((element) =>
        format.format(element.date) ==
        context.read<SettingController>().currentDate()).toList();
  }
}

extension Filterfgddf on List<FractionModel> {
  List<FractionModel> filteronFractionModel() {
    List<FractionModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].blockmodelmum == nonRepetitive[j].blockmodelmum &&
            this[i].serial == nonRepetitive[j].serial) {
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
        if (this[i].lenth == nonRepetitive[j].lenth &&
            this[i].hight == nonRepetitive[j].hight &&
            this[i].color == nonRepetitive[j].color &&
            this[i].type == nonRepetitive[j].type &&
            this[i].density == nonRepetitive[j].density &&
            this[i].wedth == nonRepetitive[j].wedth) {
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

extension C33r on List<NotFinalmodel> {
  List<NotFinalmodel> filter_notfinals___() {
    List<NotFinalmodel> nonRepetitive = [];
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

  String get_block_Who_Of(BlockAction action) {
    return where((element) => element.action == action.getactionTitle)
        .first
        .who;
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
        if (this[i].id == nonRepetitive[j].id) {
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
        if (this[i].type == nonRepetitive[j].type &&
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

  List<BlockModel> filter_filter_type_and_density_color() {
    List<BlockModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].type == nonRepetitive[j].type &&
            this[i].color == nonRepetitive[j].color &&
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
        if (this[i].type == nonRepetitive[j].type &&
            this[i].density == nonRepetitive[j].density &&
            this[i].color == nonRepetitive[j].color &&

            // this[i].hight == nonRepetitive[j].hight &&

            this[i].lenth == nonRepetitive[j].lenth &&
            this[i].width == nonRepetitive[j].width) {
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
        if (this[i].type == nonRepetitive[j].type &&
            this[i].density == nonRepetitive[j].density &&
            this[i].color == nonRepetitive[j].color &&
            this[i].serial == nonRepetitive[j].serial &&
            this[i].lenth == nonRepetitive[j].lenth &&
            this[i].width == nonRepetitive[j].width &&
            this[i].hight == nonRepetitive[j].hight) {
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
