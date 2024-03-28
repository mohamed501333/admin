// ignore_for_file: camel_case_types, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/Order_controller.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/controllers/dropDowen_controller.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

class Rscissor_veiwModel extends BaseViewModel {

  List<FractionModel> getFractions_Cutted_On_Rscissor(
      BlockFirebasecontroller myType, int Rscissor) {
    return myType.blocks
        .expand((e) => e.fractions.where((element) =>
            element.Rscissor == Rscissor &&
            element.actions
                    .get_Date_of_action(
                        FractionActon.cut_fraction_OnRscissor.getTitle)
                    .formatt() ==
                DateTime.now().formatt()))
        .toList();
  }

  List<FractionModel> getFractions_Cutted_On_Ascissor(
      BlockFirebasecontroller myType, int Ascissor) {
    return myType.blocks
        .expand((e) => e.fractions.where((element) =>
            element.Ascissor == Ascissor &&
            element.actions
                    .get_Date_of_action(
                        FractionActon.cut_fraction_OnAscissor.getTitle)
                    .formatt() ==
                DateTime.now().formatt()))
        .toList();
  }

  List<FractionModel> fractions_Underoperation(
      BuildContext context, List<BlockModel> blocks) {
    return blocks
        .map((e) => e.fractions)
        .expand((element) => element)
        .where((element) => element.underOperation == true)
        .toList();
  }

  incert_finalProduct_from_cutingUnitR2324(BuildContext context,int stageOFR,int Rscissor) {

    OrderController my = context.read<OrderController>();
    if (my.order != null && my.item != null  ) {
      double volume = my.item!.widti *
          my.item!.lenth *
          my.item!.hight *
          int.parse(amountcontroller.text) /
          1000000;
      context
          .read<final_prodcut_controller>()
          .incert_finalProduct_from_cutingUnit(FinalProductModel(
            invoiceNum: 0,
            price: 0.0,
            worker: "",
            stageOfR:stageOFR ,
            isfinal: true,
            notes: notes.text,
            cuting_order_number: my.order!.serial,
            actions: [
              finalProdcutAction.incert_finalProduct_from_cutingUnit.add
            ],
            id: DateTime.now().millisecondsSinceEpoch,
            color: my.item!.color,
            density: my.item!.density,
            type: my.item!.type,
            amount: int.parse(amountcontroller.text),
            scissor:Rscissor+3 ,
            width: my.item!.widti,
            lenth: my.item!.lenth,
            hight: my.item!.hight,
            customer: my.order!.customer,
            volume: my.item!.widti * my.item!.lenth * my.item!.hight / 1000000,
            whight: volume * my.item!.density,
          ));
      amountcontroller.clear();
      notes.clear();
      my.order = null;
      my.item = null;
      my.Refrsh_ui();
      context.read<dropDowenContoller>().Refrsh_ui();
    }
  }
 
  incert_finalProduct_from_cutingUnit_UnRegular_R2324(BuildContext context,int stageOFR,int Rscissor) {

    OrderController my = context.read<OrderController>();
    if (my.order != null && my.item != null  ) {
      double volume = my.item!.widti *
          my.item!.lenth *
          my.item!.hight *
          int.parse(amountcontroller.text) /
          1000000;
      context
          .read<final_prodcut_controller>()
          .incert_finalProduct_from_cutingUnit(FinalProductModel(
            invoiceNum: 0,
            price: 0.0,
            worker: "",
            stageOfR:stageOFR ,
            isfinal: true,
            notes: notes.text,
            cuting_order_number: my.order!.serial,
            actions: [
              finalProdcutAction.incert_finalProduct_from_cutingUnit.add
            ],
            id: DateTime.now().millisecondsSinceEpoch,
            color: my.item!.color,
            density: my.item!.density,
            type: my.item!.type,
            amount: int.parse(amountcontroller.text),
            scissor:Rscissor+3 ,
            width: my.item!.widti,
            lenth: my.item!.lenth,
            hight: my.item!.hight,
            customer: my.order!.customer,
            volume: my.item!.widti * my.item!.lenth * my.item!.hight / 1000000,
            whight: volume * my.item!.density,
          ));
      amountcontroller.clear();
      notes.clear();
      my.order = null;
      my.item = null;
      my.Refrsh_ui();
      context.read<dropDowenContoller>().Refrsh_ui();
    }
  }



// TO:DO
  add_UnderOperatin_work(BuildContext context) {

        var quantity=amountcontroller.text.to_int();
        var block=context.read<BlockFirebasecontroller>().blocks.where((element) => false);
    
    var L = lenthcontroller.text.to_double();
    var w = widthcontroller.text.to_double();
    var h = hightncontroller.text.to_double();
    var volume = L * w * h / 1000000;
    var wight = densitycontroller.text.to_double() * volume;

    var item = Itme(
        L: L,
        W: w,
        H: h,
        density: densitycontroller.text.to_double(),
        volume: volume,
        wight: wight,
        color: colercontroller.text,
        type: typecontroller.text,
        price: 0);

    var fraction = SubFraction(
        subfraction_ID: DateTime.now().microsecondsSinceEpoch,
        fraction_ID:0 ,
        sapa_ID:"",
        block_ID: 0,
        sapa_desc:"" ,
        item: item,
        underOperation: true,
        Ascissor: 0,
        Hscissor: 0,
        Rscissor: scissorcontroller.text.to_int(),
        quality: 0,
        notfinals: [],
        Rstagenum: N.text.to_int(),
        Astagenum: 0,
        note: "",
        actions: []);
  }

}
