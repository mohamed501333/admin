// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, non_constant_identifier_names, file_names

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:provider/provider.dart';

import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/Order_controller.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/controllers/dropDowen_controller.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';
import 'package:jason_company/ui/recources/enums.dart';

class Rscissor_veiwModel extends BaseViewModel {

  List<FractionModel> getFractions_Cutted_On_Rscissor_today(
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

  List<SubFraction> getsubfraction_Cutted_On_Rscissor(
      BlockFirebasecontroller myType, int Rscissor) {
    return myType.blocks
        .expand((e) => e.fractions.expand((element) => element.SubFractions)).
            where((element) =>
            element.Rscissor == Rscissor &&
            element.actions
                    .get_Date_of_action(
                        FractionActon.cut_fraction_OnRscissor.getTitle)
                    .formatt() ==
                DateTime.now().formatt())
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

  List<FractionModel> getfractions_Underoperation(
      BuildContext context, List<BlockModel> blocks) {
    return blocks
        .map((e) => e.fractions)
        .expand((element) => element)
        .where((element) => element.underOperation == true)
        .toList();
  }
 
 List<int>  getAllStages( List<FractionModel> fractions,int Rscissor, List<FinalProductModel> finalproducts ){
                            List<int> allStagesOf_fractions = fractions.map((e) => e.stagenum).toSet().toList();

        List<int> allStagesOf_subfraction =get_subfractions(fractions,Rscissor).map((e) => e.Rstagenum).toSet().toList();
       
        List<int> allStagesOf_finalproduct = finalproducts.map((e) => e.stageOfR).toSet().toList();
       
        List<int> all = [];
        all.addAll(allStagesOf_fractions);
        all.addAll(allStagesOf_subfraction);
        all.addAll(allStagesOf_finalproduct);
       return all.toSet().toList().sortedBy<num>((element) => element).reversed.toList();
                      }

 List<SubFraction> get_subfractions(List<FractionModel> fractions,int Rscissor) {
    return fractions
          .expand((element) => element.SubFractions)
          .where((element) => element.Rscissor == Rscissor).toList();
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

  List<FinalProductModel> getDataOF_finalProdcutOF_scissor(BuildContext context,int Rscissor) {
    return context
          .read<final_prodcut_controller>()
          .SumTheTOw()
          .where((element) =>
              element.scissor == Rscissor + 3 &&
              element.actions
                      .get_Date_of_action(finalProdcutAction
                          .incert_finalProduct_from_cutingUnit.getactionTitle)
                      .formatt() ==
                  DateTime.now().formatt())
          .toList();
  }
   
   List<BLockDetailsOf> getAllDetiails_OFscissor_OFstage(  int StageOfR, List<FractionModel> fractions){
       return  fractions.where((element) => element.stagenum==StageOfR).map((e) => BLockDetailsOf(sapadescriotion: e.sapa_desc, sapaId: e.sapa_ID, density: e.item.density, type: e.item.type, color: e.item.color,stageOfR: StageOfR)).toList();
   }

  add_UnderOperatin_subfractions(BuildContext context,int Rscissor) {

     var quantity=amountcontroller.text.to_int();
     BLockDetailsOf? sapadetails= context.read<ObjectBoxController>().selectedValueOfBLockDetailsOf;
    
    var L = lenthcontroller.text.to_double();
    var w = widthcontroller.text.to_double();
    var h = hightncontroller.text.to_double();
    var volume = L * w * h / 1000000;
    var wight = sapadetails!.density * volume;

    var item = Itme(
        L: L,
        W: w,
        H: h,
        density: sapadetails.density,
        volume: volume,
        wight: wight,
        color: sapadetails.color,
        type: sapadetails.type,
        price: 0);

    var subfraction = SubFraction(
        subfraction_ID: DateTime.now().microsecondsSinceEpoch,
        fraction_ID:0 ,
        sapa_ID:sapadetails.sapaId,
        block_ID: 0,
        sapa_desc:sapadetails.sapadescriotion ,
        item: item,
        underOperation: true,
        Ascissor: 0,
        Hscissor: 0,
        Rscissor: Rscissor,
        quality: 0,
        notfinals: [],
        Rstagenum:sapadetails.stageOfR,
        Astagenum: 0,
        Hstagenum: 0,
        note: "",
        actions: [subfractionAction.create_new_subfraction.add]);

    context.read<BlockFirebasecontroller>().addsubfractions(List.generate(quantity.toInt(), (index) => subfraction));
   
        amountcontroller.clear();
        lenthcontroller.clear();
        widthcontroller.clear();
        hightncontroller.clear();
        sapadetails=null;



  }

}

class BLockDetailsOf {
  String sapadescriotion;
  String sapaId;
  double density;
  String type;
  String color;
  int stageOfR;
  BLockDetailsOf({
    required this.sapadescriotion,
    required this.sapaId,
    required this.density,
    required this.type,
    required this.color,
    required this.stageOfR,
  });
 }
