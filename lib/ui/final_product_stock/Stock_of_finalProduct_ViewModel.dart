// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';
import 'package:provider/provider.dart';

class stockOfFinalProductsViewModel extends BaseViewModel {
  //ارجاع قائمه باسم العميل والمقاسات الموجوده بها
  List<GroupModel> source(List<FinalProductModel> finalproducts) {
    var x = finalproducts;
    return x
        .filter_company()
        .map((e) => GroupModel(
            name: e.customer,
            items: x
                .where((element) => element.customer == e.customer)
                .toList()
                .filter_density_type_size()
                .map((e) => ItemModel(e.density, e.type, e.lenth, e.width,
                    e.hight, get_total(finalproducts, e), e.customer, e.color))
                .toList()))
        .toList();
  }

//ارجاع اجمالى العدد لكل مقاس
  get_total(List<FinalProductModel> finalproducts, FinalProductModel e) {
    return finalproducts
        .where((element) =>
            element.density == e.density &&
            element.customer == e.customer &&
            element.type == e.type &&
            element.width == e.width &&
            element.hight == e.hight &&
            element.lenth == e.lenth)
        .map((e) => e.amount)
        .reduce((a, b) => a + b);
  }

  //اضافة مقاس جديد عند عمل الجرد
  incertfinalProduct(BuildContext context) {
    context
        .read<final_prodcut_controller>()
        .incert_finalProduct_from_Others(FinalProductModel(
          worker: "",
          stageOfR: 0,
          isfinal: true,
          notes: notes.text,
          cuting_order_number: 0,
          actions: [],
          id: DateTime.now().millisecondsSinceEpoch,
          color: colercontroller.text,
          density: double.parse(densitycontroller.text),
          type: typecontroller.text,
          amount: int.parse(amountcontroller.text),
          scissor: int.tryParse(scissorcontroller.text) ?? 0,
          width: double.parse(widthcontroller.text),
          lenth: double.parse(lenthcontroller.text),
          hight: double.parse(hightncontroller.text),
          customer: companycontroller.text,
        ));
  }

  void add(BuildContext context) {
    if (formKey.currentState!.validate()) {
      incertfinalProduct(context);
      clearfields();
    }
  }

//الخاصه بالاضافه الى هذا المقاس
  void addtocertinsize(
      BuildContext context, ItemModel itemData, GroupModel headerData) {
    if (formKey.currentState!.validate() && itemData.total > 0) {
      context
          .read<final_prodcut_controller>()
          .incert_finalProduct_from_Others(FinalProductModel(
            worker: "",
            stageOfR: 0,
            isfinal: true,
            notes: notes.text,
            cuting_order_number: 0,
            actions: [],
            id: DateTime.now().millisecondsSinceEpoch,
            color: itemData.color,
            density: itemData.density,
            type: itemData.type,
            amount: int.parse(amountcontroller.text),
            scissor: int.tryParse(scissorcontroller.text) ?? 0,
            width: itemData.width,
            lenth: itemData.lenth,
            hight: itemData.hight,
            customer: headerData.name,
          ));
      clearfields();
    }
  }
}

class GroupModel {
  final String name;
  final List<ItemModel> items;
  GroupModel({required this.name, required this.items});
}

class ItemModel {
  final double density;
  final String type;
  final String color;
  final String company;
  final double lenth;
  final double width;
  final double hight;
  final int total;
  ItemModel(
    this.density,
    this.type,
    this.lenth,
    this.width,
    this.hight,
    this.total,
    this.company,
    this.color,
  );
}
