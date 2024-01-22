// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/controllers/setting_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

class BlocksStockViewModel extends BaseViewModel {
  fillFields(ChipBlockModel chi) {
    codecontroller.text = chi.serial;
    colercontroller.text = chi.color.toString();
    densitycontroller.text = chi.density.removeTrailingZeros.toString();
    hightncontroller.text = chi.hight.removeTrailingZeros.toString();
    lenthcontroller.text = chi.lenth.removeTrailingZeros.toString();
    typecontroller.text = chi.type.toString();
    widthcontroller.text = chi.width.removeTrailingZeros.toString();
    scissorcontroller.text = chi.scissor.removeTrailingZeros.toString();
    wightcontroller.text = chi.wight.removeTrailingZeros.toString();
    blockdesription.text = chi.description.toString();
  }

  @override
  clearfields() {
    blocknumbercontroller.clear();
    codecontroller.clear();
    colercontroller.clear();
    densitycontroller.clear();
    hightncontroller.clear();
    lenthcontroller.clear();
    typecontroller.clear();
    widthcontroller.clear();
    scissorcontroller.clear();
    wightcontroller.clear();
    cummingFrom.clear();
    outTo.clear();
  }

  incertblock(BuildContext context) {
    bool co = context.read<SettingController>().valueOfRadio1;
    context.read<BlockFirebasecontroller>().addblock(BlockModel(
        discreption: blockdesription.text,
        actions: co == true
            ? [
                BlockAction.create_block.add,
                BlockAction.consume_block.add,
              ]
            : [BlockAction.create_block.add],
        //هنا اذا كان الخيار مفعل فى الاعدادات
        //صرف عند الاضافه
        OutTo: outTo.text.isEmpty ? "" : outTo.text,
        cumingFrom: cummingFrom.text.isEmpty ? "المصنع" : cummingFrom.text,
        fractions: [],
        notfinals: [],
        id: DateTime.now().millisecondsSinceEpoch,
        Hscissor: int.tryParse(scissorcontroller.text) ?? 0,
        color: colercontroller.text,
        density: double.parse(densitycontroller.text),
        type: typecontroller.text,
        serial: codecontroller.text,
        number: int.parse(blocknumbercontroller.text),
        width: int.parse(widthcontroller.text),
        lenth: int.parse(lenthcontroller.text),
        hight: int.parse(hightncontroller.text),
        wight: wightcontroller.text.to_double(),
        Rcissor: 0,
        notes: notes.text.isEmpty ? "" : notes.text));
  }

  incertblockformchip(BuildContext context, ChipBlockModel chi) {
    int num = context.read<SettingController>().number;
    context.read<BlockFirebasecontroller>().addblock(
          BlockModel(
            discreption: chi.description,
            OutTo: outTo.text.isEmpty ? "" : outTo.text,
            cumingFrom: cummingFrom.text.isEmpty ? "المصنع" : cummingFrom.text,
            fractions: [],
            notfinals: [],
            actions: [BlockAction.create_block.add],
            Hscissor: 0,
            Rcissor: 0,
            wight: chi.wight,
            id: DateTime.now().millisecondsSinceEpoch,
            color: chi.color,
            density: chi.density,
            type: chi.type,
            serial: chi.serial,
            number: num,
            width: chi.width.removeTrailingZeros.to_int(),
            lenth: chi.lenth.removeTrailingZeros.to_int(),
            hight: chi.hight.removeTrailingZeros.to_int(),
            notes: chi.notes,
          ),
        );
    context.read<SettingController>().inceasenumber();
  }

  double wight_of_fractions(BlockModel block) {
    return block.fractions.isNotEmpty
        ? block.fractions
            .map((e) => e.wedth * e.lenth * e.hight * e.density / 1000000)
            .reduce((a, b) => a + b)
            .removeTrailingZeros
            .to_double()
        : 0;
  }

  double wight_of_notfinal(BlockModel block) {
    return block.notfinals.isNotEmpty
        ? block.notfinals
            .map((e) => e.wight)
            .reduce((a, b) => a + b)
            .removeTrailingZeros
            .to_double()
        : 0;
  }

  double difrence(BlockModel block) {
    return block.wight - wight_of_fractions(block) - wight_of_notfinal(block);
  }

  double percentage(BlockModel block) {
    return 100 * wight_of_notfinal(block) / block.wight;
  }
}
