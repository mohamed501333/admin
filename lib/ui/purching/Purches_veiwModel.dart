import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/controllers/purchesController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/base/base_view_mode.dart';
import 'package:provider/provider.dart';

class PurchesViewMolel extends BaseViewModel {
  List<PurcheItem> permanentWidget = [];
  List<PurcheItem> items = [];
  List<PurcheItem> item3s = [];
  addnewPurcheItem(BuildContext context) {
    PurcheOrder purcheOrder = PurcheOrder(
        Id: DateTime.now().millisecondsSinceEpoch,
        serial: context.read<PurchesController>().purchesOrders.isEmpty
            ? 1
            : context
                    .read<PurchesController>()
                    .purchesOrders
                    .sortedBy<num>((element) => element.Id)
                    .last
                    .serial +
                1,
        Adminstrationrequested: administrationRequstTheOrder.text,
        dueDate: DateTime.now(),
        fl: "",
        financeManagerSingiture: [],
        gl: "",
        generalManagerSigniture: [],
        requester: purcheOrderRequester.text,
        actions: [],
        items: items,
        status: "قيد الموافقه");

    context.read<PurchesController>().Add_purche_item(purcheOrder);
  }
}
