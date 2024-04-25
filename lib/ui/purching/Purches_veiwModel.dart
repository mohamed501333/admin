import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/purchesController.dart';
import '../../models/moderls.dart';
import '../base/base_view_mode.dart';
import '../recources/enums.dart';

class PurchesViewMolel extends BaseViewModel {
  List<PurcheItem> permanentWidget = [];

  addnewPurcheItem(BuildContext context) {
    if (formKey.currentState!.validate() && permanentWidget.isNotEmpty) {
      PurcheOrder purcheOrder = PurcheOrder(
          Id: DateTime.now().millisecondsSinceEpoch,
          serial: context.read<PurchesController>().initalData.isEmpty
              ? 1
              : context
                      .read<PurchesController>()
                      .initalData
                      .sortedBy<num>((element) => element.serial)
                      .last
                      .serial +
                  1,
          Adminstrationrequested: administrationRequstTheOrder.text,
          dueDate: DateTime.now(),
          fl: "",
          financeManagerSingiture: <int>[],
          gl: "",
          generalManagerSigniture: <int>[],
          requester: purcheOrderRequester.text,
          actions: [PurcheAction.creat_new_Purche.add],
          items: permanentWidget,
          status: "قيد الموافقه");

      context.read<PurchesController>().Add_purche_item(purcheOrder);
      permanentWidget.clear();
      administrationRequstTheOrder.clear();
      purcheOrderRequester.clear();
    }
  }
}
