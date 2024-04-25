import 'package:flutter/material.dart';
import '../../app/extentions.dart';
import '../../controllers/ObjectBoxController.dart';
import '../../main.dart';
import '../../models/moderls.dart';
import '../base/base_view_mode.dart';
import 'package:provider/provider.dart';

class ConstantsViewModel extends BaseViewModel {
  addchipblock(BuildContext context) {
    database.addchips(ChipBlockModel(
      description: blockdesription.text,
      notes: notes.text,
      wight: wightcontroller.text.to_double(),
      title: tiitlecontroller.text,
      scissor: double.tryParse(scissorcontroller.text) ?? 0,
      color: colercontroller.text,
      density: double.tryParse(densitycontroller.text) ?? 0,
      type: typecontroller.text,
      serial: codecontroller.text,
      number: double.tryParse(blocknumbercontroller.text) ?? 0,
      width: double.tryParse(widthcontroller.text) ?? 0,
      lenth: double.tryParse(lenthcontroller.text) ?? 0,
      hight: double.tryParse(hightncontroller.text) ?? 0,
    ));
    context.read<ObjectBoxController>().get();
  }

  addfractionchip(BuildContext context) {
    database.addFractionchip(ChipFraction(
        width: double.tryParse(widthcontroller.text) ?? 0,
        lenth: double.tryParse(lenthcontroller.text) ?? 0,
        hight: double.tryParse(hightncontroller.text) ?? 0));
    context.read<ObjectBoxController>().get();
  }
}
