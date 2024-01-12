// ignore_for_file: file_names, must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/validation.dart';
import 'package:jason_company/controllers/Order_controller.dart';
import 'package:jason_company/controllers/dropDowen_controller.dart';
import 'package:jason_company/ui/commen/textformfield.dart';
import 'package:jason_company/ui/final_product_imported/finalProductStock_viewmodel.dart';
import 'package:jason_company/ui/recources/color_manager.dart';
import 'package:provider/provider.dart';

class HeaderOftable extends StatelessWidget {
  const HeaderOftable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3),
        3: FlexColumnWidth(3),
        4: FlexColumnWidth(1),
        5: FlexColumnWidth(1),
        6: FlexColumnWidth(2),
        7: FlexColumnWidth(1),
        8: FlexColumnWidth(1),
        9: FlexColumnWidth(2),
        10: FlexColumnWidth(.8),
        11: FlexColumnWidth(.7),
      },
      border: TableBorder.all(width: 1, color: Colors.black),
      children: [
        TableRow(
            decoration: BoxDecoration(
              color: Colors.amber[50],
            ),
            children: [
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text("حذف"))),
              Container(
                  padding: const EdgeInsets.all(0),
                  child: const Center(child: Text(' التخزين'))),
              Container(
                  padding: const EdgeInsets.all(0),
                  child: const Center(child: Text(' الجوده'))),
              Container(
                  padding: const EdgeInsets.all(0),
                  child: const Center(child: Text('الاستلام'))),
              Container(
                  padding: const EdgeInsets.all(0),
                  child: const Center(child: Text('مقص'))),
              Container(
                  padding: const EdgeInsets.all(0),
                  child: const Center(child: Text('كثافه'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('عميل'))),
              Container(
                  padding: const EdgeInsets.all(0),
                  child: const Center(child: Text('النوع'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('لون'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Center(child: Text('مقاس')))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('عدد'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('م'))),
            ])
      ],
    );
  }
}

class Fields extends StatelessWidget {
  const Fields({
    super.key,
    required this.vm,
  });

  final FinalProductStockViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          // ignore: prefer_const_constructors
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              DropDdowenFor_scissors(),
              DropDdowenForOrders_sizes(),
            ],
          ),

          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomTextFormField(
                keybordtupe: TextInputType.name,
                width: MediaQuery.of(context).size.width * .23,
                hint: "ملاحظات ",
                controller: vm.notes,
              ),
              CustomTextFormField(
                width: MediaQuery.of(context).size.width * .23,
                hint: "العدد ",
                controller: vm.amountcontroller,
                validator: Validation.validateothers,
              ),
              const DropDdowenForOrders(),
            ],
          ),
        ],
      ),
    );
  }
}

class DropDdowenForOrders extends StatelessWidget {
  const DropDdowenForOrders({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderController>(
      builder: (context, Mytype, child) {
        // Mytype.getBlocks(context, vm);
        return Column(
          children: [
            const Text("اوامر التشغيل"),
            DropdownButton(
                value: Mytype.initionalForRadio_order_Serials,
                items: Mytype.getOrdersForRadio_order_Serials()
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.serial.toString()),
                        ))
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    //اسناد قيمة الدروب لل كنترولر
                    Mytype.initionalForRadio_order_sizes = null;

                    Mytype.initionalForRadio_order_Serials = v;
                    Mytype.Refrsh_ui();
                  }
                }),
          ],
        );
      },
    );
  }
}

class DropDdowenForOrders_sizes extends StatelessWidget {
  const DropDdowenForOrders_sizes({
    super.key,
  });
  // CuttingOrderViewModel vm = CuttingOrderViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderController>(
      builder: (context, Mytype, child) {
        // Mytype.getBlocks(context, vm);
        return Column(
          children: [
            const Text("المقاسات"),
            DropdownButton(
                value: Mytype.initionalForRadio_order_sizes,
                items: Mytype.getOrdersForRadio_order_sizes()
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Row(
                            children: [
                              Text(
                                "${e.lenth.removeTrailingZeros}*${e.widti.removeTrailingZeros}*${e.hight.removeTrailingZeros}>>>",
                              ),
                              Text(
                                "${e.color}>>ك${e.density.removeTrailingZeros}>>${e.type}",
                                style:
                                    const TextStyle(color: ColorManager.cobalt),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    Mytype.initionalForRadio_order_sizes = v;
                    Mytype.Refrsh_ui();
                  }
                }),
          ],
        );
      },
    );
  }
}

class DropDdowenFor_scissors extends StatelessWidget {
  const DropDdowenFor_scissors({super.key});

  // CuttingOrderViewModel vm = CuttingOrderViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<dropDowenContoller>(
      builder: (context, Mytype, child) {
        return Column(
          children: [
            const Text("المقص"),
            DropdownButton(
                value: Mytype.initioalFor_Scissors,
                items: Mytype.scissors
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Mytype.get_label(e),
                        ))
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    Mytype.initioalFor_Scissors = v;
                    Mytype.Refrsh_ui();
                  }
                }),
          ],
        );
      },
    );
  }
}

class Buttoms extends StatelessWidget {
  const Buttoms({
    super.key,
    required this.vm,
  });
  final FinalProductStockViewModel vm;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ChipsForFinalProduct(),
        const SizedBox(
          width: 30,
        ),
        ElevatedButton(
            onPressed: () {
              vm.incert_finalProduct_from_cutingUnit(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "اضافة",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )),
      ],
    );
  }
}

class AddUnregular extends StatelessWidget {
  AddUnregular({super.key});
  FinalProductStockViewModel vm = FinalProductStockViewModel();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    scrollable: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    content: SizedBox(
                      height: 450,
                      child: SingleChildScrollView(
                        child: Form(
                          key: vm.formKey,
                          child: Column(
                            children: [
                              Container(
                                color: Colors.blue[900],
                                height: 30,
                                child: const Center(
                                  child: Text(
                                    'مقاسات شاذه خارخ الاوردر',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomTextFormField(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        hint: "النوع",
                                        keybordtupe: TextInputType.name,
                                        controller: vm.typecontroller,
                                        validator: Validation.validateothers,
                                      ),
                                      CustomTextFormField(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        hint: "الكثافه",
                                        controller: vm.densitycontroller,
                                        validator: Validation.validateothers,
                                      ),
                                      CustomTextFormField(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        keybordtupe: TextInputType.number,
                                        hint: "العميل",
                                        controller: vm.companycontroller,
                                        validator:
                                            Validation.if_cusomer_serial_exist(
                                                context),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomTextFormField(
                                        validator: Validation.validateothers,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        keybordtupe: TextInputType.number,
                                        hint: "الكميه",
                                        controller: vm.amountcontroller,
                                      ),
                                      CustomTextFormField(
                                        validator: Validation.validateothers,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        keybordtupe: TextInputType.number,
                                        hint: "مقص",
                                        controller: vm.scissorcontroller,
                                      ),
                                      CustomTextFormField(
                                        validator: Validation.validateothers,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        keybordtupe: TextInputType.name,
                                        hint: "اللون",
                                        controller: vm.colercontroller,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomTextFormField(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        hint: "الارتفاع",
                                        controller: vm.hightncontroller,
                                        validator: Validation.validateothers,
                                      ),
                                      CustomTextFormField(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        hint: "العرض",
                                        controller: vm.widthcontroller,
                                        validator: Validation.validateothers,
                                      ),
                                      CustomTextFormField(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        hint: "الطول ",
                                        controller: vm.lenthcontroller,
                                        validator: Validation.validateothers,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red)),
                                        onPressed: () {
                                          vm.validate();
                                          vm.add_unregular(context);
                                        },
                                        child: const Text('أضافه')),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.blue)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('الغاء')),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ));
        },
        icon: const Icon(Icons.add));
  }
}
