// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/controllers/invoice_controller.dart';
import 'package:jason_company/main.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/services/inviceForFinalProdct.dart';
import 'package:jason_company/services/pdfprevei.dart';
import 'package:jason_company/ui/commen/errmsg.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/recources/userpermitions.dart';
import 'package:provider/provider.dart';

class InvicesView extends StatefulWidget {
  InvicesView({super.key});

  @override
  State<InvicesView> createState() => _InvicesViewState();
}

class _InvicesViewState extends State<InvicesView> {
  String chosenDate = format.format(DateTime.now());
  @override
  Widget build(BuildContext context) {
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
              )).permition(context, UserPermition.show_date_in_invoices)
        ],
        title: const Text("اذونات اليوم"),
      ),
      body: Consumer<Invoice_controller>(
        builder: (context, myType, child) {
          List<Invoice> t = myType.invoices
              .where((element) => format.format(element.actions.get_Date_of_action(InvoiceAction.creat_invoice.getTitle)) == chosenDate)
              .sortedBy<num>((element) => element.serial)
              .reversed
              .toList();
          return SingleChildScrollView(
            child: Column(
              children:[ 
                   errmsg() ,
                ...t
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        permission().then((value) async {
                          finalProductInvoice
                              .generate(context, e)
                              .then((value) => context.gonext(
                                  context,
                                  PDfpreview(
                                    v: value.save(),
                                  )));
                        });
                      },
                      child: Card(
                        color: Colors.blue[100],
                        elevation: 5,
                        child: ListTile(
                          leading: CircleAvatar(
                            child:
                                Text("${t.reversed.toList().indexOf(e) + 1}"),
                          ),
                          title: Column(
                            children: [
                              Text(
                                  'الوقت: ${formatwitTime3.format(e.actions.get_Date_of_action(InvoiceAction.creat_invoice.getTitle)).replaceAll(RegExp(r'PM'), 'م').replaceAll(RegExp(r'AM'), 'ص')}'),
                              Text(
                                  'عميل: ${e.items.isEmpty ? 0 : e.items.first.customer}'),
                              Text('تسلسل: ${e.serial}'),
                              Text('السائق : ${e.driverName}'),
                              Text('رقم العربه : ${e.carNumber}'),
                            ],
                          ),
                          subtitle: const Text('    '),
                          trailing: const Icon(Icons.print),
                        ),
                      ),
                    ),
                  )
                  .toList()],
            ),
          );
        },
      ),
    );
  }
}
