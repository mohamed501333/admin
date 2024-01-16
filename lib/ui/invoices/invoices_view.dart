import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/controllers/invoice_controller.dart';
import 'package:jason_company/services/inviceForFinalProdct.dart';
import 'package:jason_company/services/pdfprevei.dart';
import 'package:provider/provider.dart';

class InvicesView extends StatelessWidget {
  const InvicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("اذونات اليوم"),
      ),
      body: Consumer<Invoice_controller>(
        builder: (context, myType, child) {
          return SingleChildScrollView(
            child: Column(
              children: myType.invoices
                  .sortedBy<num>((element) => element.number)
                  .reversed
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
                            child: Text(""),
                          ),
                          title: Column(
                            children: [
                              Text('customer : ${e.items.first.customer}'),
                              Text('serial : ${e.number}'),
                            ],
                          ),
                          subtitle: Text('    '),
                          trailing: Icon(Icons.print),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
