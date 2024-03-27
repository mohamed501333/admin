// ignore_for_file: file_names, non_constant_identifier_names

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

class FinalProductStockViewModel extends BaseViewModel {
  OrderModel find(   
    List<OrderModel> orders,OperationOrederItems item) {
    return orders
        .where((element) => element.items.map((e) => e.id).contains(item.id))
        .first;
  }

  incert_finalProduct_from_cutingUnit(BuildContext context) {
    int? scissor = context.read<dropDowenContoller>().initioalFor_Scissors;

    OrderController my = context.read<OrderController>();
    if (my.order != null && my.item != null && scissor != null && validate()) {
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
            stageOfR: context.read<dropDowenContoller>().N.text.to_int(),
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
            scissor: scissor,
            width: my.item!.widti,
            lenth: my.item!.lenth,
            hight: my.item!.hight,
            customer: my.order!.customer,
            volume: my.item!.widti * my.item!.lenth * my.item!.hight / 1000000,
            whight: volume * my.item!.density,
          ));
      amountcontroller.clear();
      notes.clear();
      N.clear();
      context.read<dropDowenContoller>().initioalFor_Scissors = null;
      my.order = null;
      my.item = null;
      my.Refrsh_ui();
      context.read<dropDowenContoller>().Refrsh_ui();
    }
  }

  add_unregular(BuildContext context, bool isfinal) {
    double volume = int.parse(amountcontroller.text) *
        widthcontroller.text.to_double() *
        lenthcontroller.text.to_double() *
        hightncontroller.text.to_double() /
        1000000;
    FinalProductModel user = FinalProductModel(
        invoiceNum: 0,
        price: 0.0,
        stageOfR: N.text.to_int(),
        id: DateTime.now().millisecondsSinceEpoch,
        color: colercontroller.text,
        isfinal: isfinal,
        density: densitycontroller.text.to_double(),
        type: typecontroller.text,
        amount: int.parse(amountcontroller.text),
        scissor: scissorcontroller.text.to_int(),
        width: widthcontroller.text.to_double(),
        lenth: lenthcontroller.text.to_double(),
        hight: hightncontroller.text.to_double(),
        customer: companycontroller.text,
        worker: '',
        notes: "",
        cuting_order_number: 0,
        actions: [finalProdcutAction.incert_finalProduct_from_cutingUnit.add],
        volume: volume,
        whight: volume * densitycontroller.text.to_double());
    if (formKey.currentState!.validate()) {
      context
          .read<final_prodcut_controller>()
          .incert_finalProduct_from_cutingUnit(user);
      clearfields();
    }
  }



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
