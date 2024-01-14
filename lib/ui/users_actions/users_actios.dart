import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/Customer_controller.dart';
import 'package:jason_company/controllers/Order_controller.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/controllers/invoice_controller.dart';
import 'package:jason_company/controllers/non_final_controller.dart';
import 'package:jason_company/main.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:provider/provider.dart';

class UsersActions extends StatefulWidget {
  const UsersActions({super.key});

  @override
  State<UsersActions> createState() => _UsersActionsState();
}

class _UsersActionsState extends State<UsersActions> {
  String chosenDate = format.format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    List<ActionModel> a = context
        .read<BlockFirebasecontroller>()
        .all
        .map((e) => e.actions)
        .toList()
        .expand((element) => element)
        .toList();
    List<ActionModel> b = context
        .read<BlockFirebasecontroller>()
        .all
        .map((e) => e.fractions)
        .expand((element) => element)
        .map((e) => e.actions)
        .expand((element) => element)
        .toList();
    List<ActionModel> c = context
        .read<BlockFirebasecontroller>()
        .all
        .map((e) => e.fractions)
        .expand((element) => element)
        .map((e) => e.notfinals)
        .expand((element) => element)
        .map((e) => e.actions)
        .expand((element) => element)
        .toList();
    List<ActionModel> d = context
        .read<BlockFirebasecontroller>()
        .all
        .map((e) => e.notfinals)
        .expand((element) => element)
        .map((e) => e.actions)
        .expand((element) => element)
        .toList();
    List<ActionModel> e = context
        .read<Customer_controller>()
        .initalData
        .map((e) => e.actions)
        .toList()
        .expand((element) => element)
        .toList();
    List<ActionModel> f = context
        .read<final_prodcut_controller>()
        .initalData
        .map((e) => e.actions)
        .toList()
        .expand((element) => element)
        .toList();
    List<ActionModel> g = context
        .read<Invoice_controller>()
        .invoices
        .map((e) => e.actions)
        .toList()
        .expand((element) => element)
        .toList();
    List<ActionModel> h = context
        .read<OrderController>()
        .orders
        .map((e) => e.actions)
        .toList()
        .expand((element) => element)
        .toList();
    List<ActionModel> j = context
        .read<NonFinalController>()
        .not_finals
        .map((e) => e.actions)
        .toList()
        .expand((element) => element)
        .toList();
    List<ActionModel> all = a + b + c + d + f + e + g + h + j;

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  setState(() {
                    String formattedDate = format.format(pickedDate);
                    chosenDate = formattedDate;
                  });
                } else {}
              },
              child: Text(
                chosenDate,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: all
                  .filter_date(context, chosenDate)
                  .sortedBy<DateTime>((element) => element.when)
                  .reversed
                  // .where((element) => element.action.contains("archive_"))
                  .map((e) => Text(
                      "${formatwitTime.format(e.when)} >> ${e.who} >> ${e.action}"))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
