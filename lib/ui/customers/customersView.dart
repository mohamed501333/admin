// ignore_for_file: must_be_immutable, camel_case_types, file_names

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/validation.dart';
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
            return Form(
              key: vm.formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                            validator: Validation.validateothers,
                            controller: vm.customerName,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.teal)),
                                border: OutlineInputBorder(),
                                hintText: "اسم العميل",
                                labelText: "اسم العميل",
                                labelStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                fillColor: Color.fromARGB(31, 184, 161, 161),
                                filled: true)),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      CustomTextFormField(
                          validator: Validation.if_cusomer_serial_already_exist(
                              context, vm),
                          hint: "كود العميل ",
                          width: 100,
                          controller: vm.customerSerial),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (vm.formKey.currentState!.validate()) {
                              CustomerModel customer = CustomerModel(
                                  id: DateTime.now().millisecondsSinceEpoch,
                                  serial: vm.customerSerial.text.to_int(),
                                  name: vm.customerName.text,
                                  actions: []);
                              myType.Add_new_customer(customer);
                              vm.clearfields();
                            }
                          },
                          child: const Text("اضافه"))
                    ],
                  ),
                  Table(
                      columnWidths: const {
                        0: FlexColumnWidth(3),
                      },
                      border: TableBorder.all(width: 1),
                      children: myType.customers
                          .sortedBy<num>((element) => element.serial)
                          .map((e) => TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    e.name,
                                    style: const TextStyle(
                                        fontSize: 16,
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
              ),
            );
          },
        ));
  }
}
