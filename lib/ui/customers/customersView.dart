// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/Customer_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/commen/textformfield.dart';
import 'package:jason_company/ui/customers/customers_viewModel.dart';
import 'package:provider/provider.dart';

class Customers_view extends StatelessWidget {
  Customers_view({super.key});
  Customer_viewmodel vm = Customer_viewmodel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Consumer<Customer_controller>(
          builder: (context, myType, child) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                        keybordtupe: TextInputType.name,
                        hint: "اسم العميل",
                        width: 100,
                        controller: vm.customerName),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomTextFormField(
                        hint: "كود العميل ",
                        width: 100,
                        controller: vm.customerSerial),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          CustomerModel customer = CustomerModel(
                              id: DateTime.now().millisecondsSinceEpoch,
                              serial: vm.customerSerial.text.to_int(),
                              name: vm.customerName.text,
                              actions: []);
                          myType.Add_new_customer(customer);
                          vm.clearfields();
                        },
                        child: const Text("اضافه"))
                  ],
                ),
                Table(
                    border: TableBorder.all(width: 1),
                    children: myType.customers
                        .map((e) => TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  e.name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  e.serial.toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]))
                        .toList()),
              ],
            );
          },
        ));
  }
}
