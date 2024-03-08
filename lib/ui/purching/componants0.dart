// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jason_company/ui/commen/textformfield.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/validation.dart';
import 'package:jason_company/controllers/purchesController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/services/pdfprevei.dart';
import 'package:jason_company/ui/purching/Purches_veiwModel.dart';
import 'package:jason_company/ui/purching/pdf.dart';

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
                                  lastPrice: 0.0,
                                  offers: [],
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

class Details extends StatelessWidget {
  Details({
    Key? key,
    required this.e,
  }) : super(key: key);
  final PurcheOrder e;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...e.items.map((t) => GG(
                  e: t,
                  i: e.items.indexOf(t) + 1,
                ))
          ],
        ),
      ),
    );
  }
}

class GG extends StatelessWidget {
  GG({
    Key? key,
    required this.e,
    required this.i,
  }) : super(key: key);

  TextStyle style = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  final PurcheItem e;
  final int i;
  @override
  Widget build(BuildContext context) {
    TextEditingController supplyer = TextEditingController();
    TextEditingController price = TextEditingController();
    return Consumer<PurchesController>(
      builder: (context, myType, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .10,
                    decoration:
                        BoxDecoration(border: Border.all(), color: Colors.grey),
                    child: Center(
                      child: Text(
                        "م",
                        style: style,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .12,
                    decoration:
                        BoxDecoration(border: Border.all(), color: Colors.grey),
                    child: Center(
                      child: Text("الكميه", style: style),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .16,
                    decoration:
                        BoxDecoration(border: Border.all(), color: Colors.grey),
                    child: Center(
                      child: Text("الوحده", style: style),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .29,
                    decoration:
                        BoxDecoration(border: Border.all(), color: Colors.grey),
                    child: Center(
                      child: Text("الصنف", style: style),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .21,
                    decoration:
                        BoxDecoration(border: Border.all(), color: Colors.grey),
                    child: Center(
                      child: Text("ملاحظات", style: style),
                    ),
                  ),
                ].reversed.toList(),
              ),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .10,
                    decoration: BoxDecoration(border: Border.all()),
                    child: Center(
                      child: Text(
                        i.toString(),
                        style: style,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .12,
                    decoration: BoxDecoration(border: Border.all()),
                    child: Center(
                      child: Text(e.quantity.toString(), style: style),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .16,
                    decoration: BoxDecoration(border: Border.all()),
                    child: Center(
                      child: Text(e.Unit, style: style),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .29,
                    decoration: BoxDecoration(border: Border.all()),
                    child: Center(
                      child: Text(e.item, style: style),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .21,
                    decoration: BoxDecoration(border: Border.all()),
                    child: Center(
                      child: Text(e.note, style: style),
                    ),
                  ),
                ].reversed.toList(),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  content: SizedBox(
                                    height: 110,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 7),
                                          child: CustomTextFormField(
                                              keybordtupe: TextInputType.name,
                                              hint: "المورد",
                                              width: 130,
                                              controller: supplyer),
                                        ),
                                        CustomTextFormField(
                                            hint: "السعر للكميه",
                                            width: 120,
                                            controller: price),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          if (price.text.isNotEmpty &&
                                              supplyer.text.isNotEmpty) {
                                            context
                                                .read<PurchesController>()
                                                .Add_purche_item_offer(
                                                    e,
                                                    PurcheItemOffers(
                                                        PurcheItemOffers_Id:
                                                            DateTime.now()
                                                                .millisecondsSinceEpoch,
                                                        item_Id: e.item_Id,
                                                        purcheOrder_Id:
                                                            e.purcheOrder_Id,
                                                        syplyer: supplyer.text,
                                                        price: price.text
                                                            .to_double(),
                                                        actions: []));
                                            price.clear();
                                            supplyer.clear();
                                            Navigator.pop(context);
                                          }
                                          context
                                              .read<PurchesController>()
                                              .Refrech_UI();
                                        },
                                        child: const Text("تم"))
                                  ],
                                ));
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.deepOrange,
                      )),
                  Text(
                    "عروض الاسعار",
                    style: style,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 200,
              child: Column(
                children: [
                  Table(
                    border: TableBorder.all(),
                    children: e.offers
                        .map((o) => TableRow(
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 202, 201, 201)),
                            children: [
                              Center(
                                child: Text(
                                  "المورد",
                                  style: style,
                                ),
                              ),
                              Center(child: Text("السعر للكميه", style: style))
                            ].reversed.toList()))
                        .toList(),
                  ),
                  Table(
                    border: TableBorder.all(),
                    children: e.offers
                        .map((o) => TableRow(
                            decoration: BoxDecoration(),
                            children: [
                              Text(
                                o.syplyer,
                                style: style,
                              ),
                              Text(o.price.toString(), style: style)
                            ].reversed.toList()))
                        .toList(),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
