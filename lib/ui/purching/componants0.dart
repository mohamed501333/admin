// ignore_for_file: camel_case_types, must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/validation.dart';
import 'package:jason_company/controllers/purchesController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/services/pdfprevei.dart';
import 'package:jason_company/ui/purching/Purches_veiwModel.dart';
import 'package:jason_company/ui/purching/componants.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class singnuturePad extends StatelessWidget {
  singnuturePad({
    super.key,
  });

  final keysingaturepad = GlobalKey<SfSignaturePadState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .6,
          width: MediaQuery.of(context).size.width,
          decoration:
              BoxDecoration(border: Border.all(width: 3), color: Colors.white),
          child: SfSignaturePad(
            strokeColor: Colors.black,
            minimumStrokeWidth: 10,
            key: keysingaturepad,
          ),
        ),
        ElevatedButton(
            onPressed: () {
              keysingaturepad.currentState!.clear();
            },
            child: const Text("clear")),
        ElevatedButton(
            onPressed: () async {
              keysingaturepad.currentState
                  ?.toImage()
                  .then(
                      (value) => value.toByteData(format: ImageByteFormat.png))
                  .then((value) => value!.buffer.asUint8List())
                  .then((value) => generate(value))
                  .then((value) => context.gonext(
                      context,
                      PDfpreview(
                        v: value.save(),
                      )));
            },
            child: const Text("Done"))
      ],
    );
  }
}

class NewPurch extends StatelessWidget {
  NewPurch({super.key});
  PurchesViewMolel vm = PurchesViewMolel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Consumer<PurchesController>(
          builder: (context, myType, child) {
            return Form(
              key: vm.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "تسجيل طلب شراء جديد",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * .30,
                        decoration: BoxDecoration(border: Border.all()),
                        child: Center(
                          child: TextFormField(
                            onChanged: (value) {
                              vm.administrationRequstTheOrder.text = value;
                            },
                            validator: Validation.validateOOOOOO,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Text(
                          ":الاداره الطالبه",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * .30,
                        decoration: BoxDecoration(border: Border.all()),
                        child: Center(
                          child: TextFormField(
                            onChanged: (value) {
                              vm.purcheOrderRequester.text = value;
                            },
                            validator: Validation.validateOOOOOO,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Text(
                          "اسم الطالب",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Header(),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: vm.permanentWidget
                          .map((e) => Center(
                                child: IntrinsicHeight(
                                    child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .10,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: const Center(
                                        child: Text(
                                          "م",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .12,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: Center(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            e.quantity = value.to_double();
                                          },
                                          keyboardType: TextInputType.number,
                                          validator: Validation.validateOOOOOO,
                                          initialValue: "",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .20,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: Center(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            e.Unit = value;
                                          },
                                          validator: Validation.validateOOOOOO,
                                          initialValue: e.Unit.toString(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .33,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: Center(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            e.item = value;
                                          },
                                          validator: Validation.validateOOOOOO,
                                          initialValue: e.item.toString(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .25,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: Center(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            e.note = value;
                                          },
                                          initialValue: e.note.toString(),
                                        ),
                                      ),
                                    ),
                                  ].reversed.toList(),
                                )),
                              ))
                          .toList(),
                    ),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (vm.formKey.currentState!.validate()) {
                              vm.permanentWidget.add(PurcheItem(
                                  item_Id:
                                      DateTime.now().microsecondsSinceEpoch,
                                  purcheOrder_Id: 0,
                                  quantity: 0,
                                  Unit: "",
                                  item: "",
                                  note: "",
                                  receiver: "",
                                  price: 0.0,
                                  actions: []));
                              myType.Refrech_UI();
                            }
                          },
                          icon: const Icon(
                            size: 40,
                            Icons.add,
                            color: Colors.red,
                          )),
                      ElevatedButton(
                          onPressed: () {
                            vm.addnewPurcheItem(context);
                             myType.Refrech_UI();
                          },
                          child: const Text('تسجيل'))
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }
}

class Header extends StatelessWidget {
   Header({
    super.key,
  });

  TextStyle style = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicHeight(
          child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .10,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: Text(
                "م",
                style: style,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .12,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: Text("الكميه", style: style),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .20,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: Text("الوحده", style: style),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .33,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: Text("الصنف", style: style),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .25,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: Text("ملاحظات", style: style),
            ),
          ),
        ].reversed.toList(),
      )),
    );
  }
}
