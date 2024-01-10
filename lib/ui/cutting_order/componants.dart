// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/controllers/Customer_controller.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/controllers/Order_controller.dart';
import 'package:jason_company/controllers/dropDowen_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/services/pdfprevei.dart';
import 'package:jason_company/ui/cutting_order/cuting_order_pdf.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';
import 'package:jason_company/app/validation.dart';
import 'package:jason_company/ui/commen/textformfield.dart';
import 'package:jason_company/ui/cutting_order/cutting_ordera_viewModer.dart';

class Fields001 extends StatelessWidget {
  const Fields001({
    super.key,
    required this.vm,
  });

  final CuttingOrderViewModel vm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Form(
        key: vm.formKey,
        child: SizedBox(
          height: 210,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropDdowenForDensity(),
                  DropDdowenForcolor(),
                  DropDdowenFortype(),
                  DropDdowenForcustomers()
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .19,
                    hint: "الارتفاع",
                    controller: vm.hightncontroller,
                    validator: Validation.validateothers,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .19,
                    hint: "العرض",
                    controller: vm.widthcontroller,
                    validator: Validation.validateothers,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .19,
                    hint: "الطول ",
                    controller: vm.lenthcontroller,
                    validator: Validation.validateothers,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .19,
                    hint: "الكميه ",
                    controller: vm.amountcontroller,
                    validator: Validation.validateothers,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .19,
                    child: TextFormField(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                pickedDate.millisecondsSinceEpoch.toString();
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            vm.datecontroller.text =
                                formattedDate; //set output date to TextField value.
                          } else {
                            print("Date is not selected");
                          }
                        },
                        readOnly: true,
                        controller: vm.datecontroller,
                        validator: Validation.validateothers,
                        decoration: const InputDecoration(
                            hintText: "التسليم",
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.teal)),
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            fillColor: Color.fromARGB(31, 184, 161, 161),
                            filled: true)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Buttoms001 extends StatelessWidget {
  const Buttoms001({
    super.key,
    required this.vm,
  });

  final CuttingOrderViewModel vm;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (context.read<Customer_controller>().initialForRaido != null) {
          vm.addOrder(context);
        }
      },
      child: const SizedBox(
        width: 90,
        height: 45,
        child: Center(
          child: Text(
            "اضافة",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class Buttoms003 extends StatelessWidget {
  const Buttoms003({
    super.key,
    required this.vm,
  });

  final CuttingOrderViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectBoxController>(
      builder: (context, myType, child) {
        return ElevatedButton(
          onPressed: () {
            dropDowenContoller g = context.read<dropDowenContoller>();
            vm.validate();
            if (vm.formKey.currentState!.validate() &&
                g.initialcolor != null &&
                g.initialdensity != null &&
                g.initialtype != null) {
              vm.addItem(context, context.read<dropDowenContoller>());
            }

            context.read<ObjectBoxController>().get();
          },
          child: SizedBox(
            width: 90,
            height: 45,
            child: Center(
              child: Text(
                " ${vm.temp.length + 1}مقاس",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Buttoms002 extends StatelessWidget {
  const Buttoms002({
    super.key,
    required this.vm,
  });

  final CuttingOrderViewModel vm;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        vm.clearfields();
        context.read<dropDowenContoller>().initialcolor = null;
        context.read<dropDowenContoller>().initialdensity = null;
        context.read<dropDowenContoller>().initialtype = null;
        context.read<Customer_controller>().initialForRaido = null;
        context.read<Customer_controller>().Refrsh_ui();
        context.read<dropDowenContoller>().Refrsh_ui();
        context.read<ObjectBoxController>().get();
      },
      child: const SizedBox(
        width: 90,
        height: 45,
        child: Center(
          child: Text(
            "clear",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class TheTable001 extends StatelessWidget {
  const TheTable001({
    super.key,
    required this.vm,
  });
  final CuttingOrderViewModel vm;
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderController>(
      builder: (context, orders, child) {
        return Expanded(
          flex: 4,
          child: SingleChildScrollView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 1100,
              child: ListView(
                children: [
                  const HeaderOftable001(),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(3),
                      3: FlexColumnWidth(3),
                      4: FlexColumnWidth(3),
                      5: FlexColumnWidth(2),
                      6: FlexColumnWidth(2),
                      7: FlexColumnWidth(1),
                      8: FlexColumnWidth(1),
                      9: FlexColumnWidth(1.3),
                      10: FlexColumnWidth(2.2),
                      11: FlexColumnWidth(1),
                      12: FlexColumnWidth(1),
                      13: FlexColumnWidth(1.3),
                    },
                    children: orders.orders
                        .sortedBy<num>((element) => element.serial)
                        .map((order) {
                          return TableRow(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                color: order.serial % 2 == 0
                                    ? Colors.blue[50]
                                    : Colors.amber[50],
                              ),
                              children: [
                                //ايقونة المسج
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    child: GestureDetector(
                                        onTap: () {
                                          permission().then((value) async {
                                            Cuting_order_pdf()
                                                .generate(context, order)
                                                .then((value) => context.gonext(
                                                    context,
                                                    PDfpreview(
                                                      v: value.save(),
                                                    )));
                                          });
                                        },
                                        child: const Icon(
                                          Icons.print,
                                          color:
                                              Color.fromARGB(255, 108, 207, 83),
                                        ))),
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    child: GestureDetector(
                                        onTap: () {
                                          //TODO:
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))),

                                //الكنترول
                                GestureDetector(
                                  onTap: () {
                                    if (order.actions.if_action_exist(
                                            OrderAction
                                                .order_aproved_from_control
                                                .getTitle) ==
                                        false) {
                                      showmyAlertDialog(
                                          context,
                                          OrderAction
                                              .order_aproved_from_control,
                                          order);
                                    }
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Column(
                                        children: [
                                          Icon(order.actions.if_action_exist(
                                                      OrderAction
                                                          .order_aproved_from_control
                                                          .getTitle) ==
                                                  true
                                              ? Icons.check
                                              : Icons.close),
                                          order.actions.if_action_exist(OrderAction
                                                      .order_aproved_from_control
                                                      .getTitle) ==
                                                  true
                                              ? Text(DateFormat(
                                                      'dd-MM-yy/hh:mm a')
                                                  .format(order.actions
                                                      .get_Order_DateOf(OrderAction
                                                          .order_aproved_from_control))
                                                  .toString()
                                                  .toString()
                                                  .toString())
                                              : const SizedBox(),

                                          //اليوزر اذا تم القص
                                          order.actions.if_action_exist(OrderAction
                                                      .order_aproved_from_control
                                                      .getTitle) ==
                                                  true
                                              ? Text(order.actions
                                                  .get_order_Who_Of(OrderAction
                                                      .order_aproved_from_control))
                                              : const SizedBox(),
                                        ],
                                      )),
                                ),

                                //موافقة الحسابات
                                GestureDetector(
                                  onTap: () {
                                    if (order.actions.if_action_exist(
                                            OrderAction
                                                .order_aproved_from_calculation
                                                .getTitle) ==
                                        false) {
                                      showmyAlertDialog(
                                          context,
                                          OrderAction
                                              .order_aproved_from_calculation,
                                          order);
                                    }
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Column(
                                        children: [
                                          Icon(order.actions.if_action_exist(
                                                      OrderAction
                                                          .order_aproved_from_calculation
                                                          .getTitle) ==
                                                  true
                                              ? Icons.check
                                              : Icons.close),
                                          order.actions.if_action_exist(OrderAction
                                                      .order_aproved_from_calculation
                                                      .getTitle) ==
                                                  true
                                              ? Text(DateFormat(
                                                      'dd-MM-yy/hh:mm a')
                                                  .format(order.actions
                                                      .get_Order_DateOf(OrderAction
                                                          .order_aproved_from_calculation))
                                                  .toString()
                                                  .toString()
                                                  .toString())
                                              : const SizedBox(),

                                          //اليوزر اذا تم القص
                                          order.actions.if_action_exist(OrderAction
                                                      .order_aproved_from_calculation
                                                      .getTitle) ==
                                                  true
                                              ? Text(order.actions
                                                  .get_order_Who_Of(OrderAction
                                                      .order_aproved_from_calculation))
                                              : const SizedBox(),
                                        ],
                                      )),
                                ),
                                //الانشاء
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Column(
                                        children: [
                                          Icon(order.actions.if_action_exist(
                                                      OrderAction.create_order
                                                          .getTitle) ==
                                                  true
                                              ? Icons.check
                                              : Icons.close),
                                          order.actions.if_action_exist(
                                                      OrderAction.create_order
                                                          .getTitle) ==
                                                  true
                                              ? Text(DateFormat(
                                                      'dd-MM-yy/hh:mm a')
                                                  .format(order.actions
                                                      .get_Order_DateOf(
                                                          OrderAction
                                                              .create_order))
                                                  .toString()
                                                  .toString()
                                                  .toString())
                                              : const SizedBox(),
                                          order.actions.if_action_exist(
                                                      OrderAction.create_order
                                                          .getTitle) ==
                                                  true
                                              ? Text(order.actions
                                                  .get_order_Who_Of(
                                                      OrderAction.create_order))
                                              : const SizedBox(),
                                        ],
                                      )),
                                ),

                                //اجمالى 3

                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 3),
                                            child: Text(
                                                ' ${[
                                                  item.Qantity *
                                                      item.lenth *
                                                      item.hight *
                                                      item.widti /
                                                      1000000
                                                ].first.removeTrailingZeros}  m3 ',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: order.items.indexOf(
                                                                  item) %
                                                              2 ==
                                                          0
                                                      ? Colors.cyan
                                                      : Colors.black,
                                                ))),
                                      )
                                      .toList(),
                                ),
                                //الانجاز
                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 3),
                                            child: Text(
                                              "${vm.petcentage_of_cutingOrder(context, order, item).removeTrailingZeros} %",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    order.items.indexOf(item) %
                                                                2 ==
                                                            0
                                                        ? Colors.cyan
                                                        : Colors.black,
                                              ),
                                            )),
                                      )
                                      .toList(),
                                ),
                                //العميل
                                Center(
                                  child: Container(
                                      padding: const EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        order.customer.toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                //النوع
                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 0),
                                            child: Text(
                                              item.type.toString(),
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    order.items.indexOf(item) %
                                                                2 ==
                                                            0
                                                        ? Colors.cyan
                                                        : Colors.black,
                                              ),
                                            )),
                                      )
                                      .toList(),
                                ),

                                //الكثافه
                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 3),
                                            child: Text(
                                              item.density.toString(),
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    order.items.indexOf(item) %
                                                                2 ==
                                                            0
                                                        ? Colors.cyan
                                                        : Colors.black,
                                              ),
                                            )),
                                      )
                                      .toList(),
                                ),

                                //المقاس
                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 3),
                                            child: Text(
                                              "${item.hight.removeTrailingZeros}*${item.widti.removeTrailingZeros}*${item.lenth.removeTrailingZeros}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    order.items.indexOf(item) %
                                                                2 ==
                                                            0
                                                        ? Colors.cyan
                                                        : Colors.black,
                                              ),
                                            )),
                                      )
                                      .toList(),
                                ),

                                //الكميه
                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 3),
                                            child: Text(
                                              item.Qantity.toString(),
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    order.items.indexOf(item) %
                                                                2 ==
                                                            0
                                                        ? Colors.cyan
                                                        : Colors.black,
                                              ),
                                            )),
                                      )
                                      .toList(),
                                ),
                                //رقم
                                Center(
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      child: Text(
                                        order.serial.toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                              ]);
                        })
                        .toList()
                        .reversed
                        .toList(),
                    border: TableBorder.all(width: 1, color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class HeaderOftable001 extends StatelessWidget {
  const HeaderOftable001({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(3),
        3: FlexColumnWidth(3),
        4: FlexColumnWidth(3),
        5: FlexColumnWidth(2),
        6: FlexColumnWidth(2),
        7: FlexColumnWidth(1),
        8: FlexColumnWidth(1),
        9: FlexColumnWidth(1.3),
        10: FlexColumnWidth(2.2),
        11: FlexColumnWidth(1),
        12: FlexColumnWidth(1),
        13: FlexColumnWidth(1.3),
      },
      border: TableBorder.all(width: 1, color: Colors.black),
      children: [
        TableRow(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 111, 191, 216),
            ),
            children: [
              Container(
                  padding: const EdgeInsets.all(5), child: const Text("حذف")),
              Container(
                  padding: const EdgeInsets.all(5), child: const Text("")),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text("controll approval")),
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text("finance approval")),
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text("sales approval")),
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text("اجمالى م3")),
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text(" %الانجاز")),
              ),
              Container(
                  padding: const EdgeInsets.all(5), child: const Text("عميل")),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('نوع'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(
                    child: Text('كثافه',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold)),
                  )),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(
                    child: Text('مقاس',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold)),
                  )),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('كميه'))),
              Container(
                  padding: const EdgeInsets.all(4), child: const Text('تسلسل')),
            ])
      ],
    );
  }
}

showmyAlertDialog(BuildContext context, OrderAction action, OrderModel item) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('  ?'),
          content: const SizedBox(
            height: 200,
            child: Column(children: [
              Text('هل انت متاكد'),
            ]),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No')),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {
                  context.read<OrderController>().addAction(item, action);
                  Navigator.pop(context);
                },
                child: const Text(
                  'yes',
                )),
          ],
        );
      });
}

class DropDdowenForcustomers extends StatelessWidget {
  DropDdowenForcustomers({
    super.key,
  });
  CuttingOrderViewModel vm = CuttingOrderViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<Customer_controller>(
      builder: (context, Mytype, child) {
        return Column(
          children: [
            const Text("العميل"),
            DropdownButton(
                value: Mytype.initialForRaido,
                items: Mytype.customers
                    .map((e) => e.serial)
                    .toList()
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        ))
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    //اسناد قيمة الدروب لل كنترولر

                    Mytype.initialForRaido = v;

                    Mytype.Refrsh_ui();
                  }
                }),
          ],
        );
      },
    );
  }
}

class DropDdowenFortype extends StatelessWidget {
  DropDdowenFortype({
    super.key,
  });
  CuttingOrderViewModel vm = CuttingOrderViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<dropDowenContoller>(
      builder: (context, Mytype, child) {
        Mytype.getBlocks(context, vm);
        return Column(
          children: [
            const Text("النوع"),
            DropdownButton(
                value: Mytype.initialtype,
                items: Mytype.filterType()
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        ))
                    .toList(),
                onTap: () {
                  Mytype.getBlocks(context, vm);
                  Mytype.Refrsh_ui();
                },
                onChanged: (v) {
                  if (v != null) {
                    //اسناد قيمة الدروب لل كنترولر
                    Mytype.initialtype = v;
                    Mytype.getBlocks(context, vm);
                    vm.typecontroller.text = v.toString();
                    Mytype.getBlocks(context, vm);
                    Mytype.Refrsh_ui();
                  }
                }),
          ],
        );
      },
    );
  }
}

class DropDdowenForcolor extends StatelessWidget {
  DropDdowenForcolor({
    super.key,
  });
  CuttingOrderViewModel vm = CuttingOrderViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<dropDowenContoller>(
      builder: (context, Mytype, child) {
        Mytype.getBlocks(context, vm);
        return Column(
          children: [
            const Text("اللون"),
            DropdownButton(
                value: Mytype.initialcolor,
                items: Mytype.filtercolor()
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        ))
                    .toList(),
                onTap: () {
                  Mytype.getBlocks(context, vm);
                  Mytype.Refrsh_ui();
                },
                onChanged: (v) {
                  if (v != null) {
                    //اسناد قيمة الدروب لل كنترولر
                    Mytype.getBlocks(context, vm);

                    Mytype.initialcolor = v;
                    Mytype.getBlocks(context, vm);
                    Mytype.Refrsh_ui();
                  }
                }),
          ],
        );
      },
    );
  }
}

class DropDdowenForDensity extends StatelessWidget {
  DropDdowenForDensity({
    super.key,
  });
  CuttingOrderViewModel vm = CuttingOrderViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<dropDowenContoller>(
      builder: (context, Mytype, child) {
        Mytype.getBlocks(context, vm);
        return Column(
          children: [
            const Text("الكثافه"),
            DropdownButton(
                value: Mytype.initialdensity,
                items: Mytype.filterdensity()
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        ))
                    .toList(),
                onTap: () {
                  Mytype.getBlocks(context, vm);
                  Mytype.Refrsh_ui();
                },
                onChanged: (v) {
                  if (v != null) {
                    //اسناد قيمة الدروب لل كنترولر
                    vm.densitycontroller.text = v.toString();
                    Mytype.initialdensity = v;
                    Mytype.getBlocks(context, vm);
                    Mytype.Refrsh_ui();
                  }
                }),
          ],
        );
      },
    );
  }
}
