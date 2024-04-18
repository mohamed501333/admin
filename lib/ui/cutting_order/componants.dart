// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
import 'package:percent_indicator/linear_percent_indicator.dart';
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
          height: 450,
          child: Column(
            children: [
                     DropForCustomers(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
           
                  DropDdowenForDensity(),
                  DropDdowenForcolor(),
                  DropDdowenFortype(),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .19,
                    hint: "ارتفاع",
                    controller: vm.hightncontroller,
                    validator: Validation.validateothers,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .19,
                    hint: "عرض",
                    controller: vm.widthcontroller,
                    validator: Validation.validateothers,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .19,
                    hint: "طول",
                    controller: vm.lenthcontroller,
                    validator: Validation.validateothers,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .19,
                    hint: "كميه",
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
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            String formattedDate =
                                pickedDate.millisecondsSinceEpoch.toString();

                            vm.datecontroller.text = formattedDate;
                          } else {
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
           
           const SizedBox(height: 20,),
                  CustomTextFormField(
                    keybordtupe: TextInputType.name,
                    width: MediaQuery.of(context).size.width * .5,
                    hint: "ملحوظه",
                    controller: vm.notes,
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
          vm.notes.clear();
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
  TheTable001({
    super.key,
    required this.vm,
  });
  final CuttingOrderViewModel vm;
  int x = 0;
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
              width: 1450,
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
                      5: FlexColumnWidth(3),
                      6: FlexColumnWidth(2),
                      7: FlexColumnWidth(1.5),
                      8: FlexColumnWidth(1.5),
                      9: FlexColumnWidth(1),
                      10: FlexColumnWidth(1.3),
                      11: FlexColumnWidth(1.5),
                      12: FlexColumnWidth(5),
                      13: FlexColumnWidth(1),
                      14: FlexColumnWidth(1.2),
                    },
                    children: orders.orders
                        .where((element) =>
                            element.actions.if_action_exist(
                                OrderAction.order_colosed.getTitle) ==
                            false)
                        .sortedBy<num>((element) => element.serial)
                        .map((order) {
                          x++;

                          return TableRow(
                              decoration: BoxDecoration(
                                color: order.actions.if_action_exist(OrderAction
                                                .order_aproved_from_control
                                                .getTitle) ==
                                            false ||
                                        order.actions.if_action_exist(OrderAction
                                                .order_aproved_from_calculation
                                                .getTitle) ==
                                            false
                                    ? Colors.red
                                    : x % 2 == 0
                                        ? Colors.blue[50]
                                        : Colors.amber[50],
                              ),
                              children: [
                                //طباعة امر الشغل
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
                                        ))).permition(context,
                                    UserPermition.can_print_in_cutting_order),
                                //اغلاق امر الشغل
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    child: GestureDetector(
                                        onTap: () {
                                          showmyAlertDialog(context,
                                              OrderAction.order_colosed, order);
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))).permition(context,
                                    UserPermition.can_close_in_cutting_order),
                                Center(
                                  child: Text(order.notes),
                                ),
                                //موافقة الكنترول
                                GestureDetector(
                                  onTap: () {
                                    if (order.actions.if_action_exist(
                                                OrderAction
                                                    .order_aproved_from_control
                                                    .getTitle) ==
                                            false &&
                                        permitionss(
                                            context,
                                            UserPermition
                                                .can_aprove_from_controll)) {
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
                                                      .get_Date_of_action(
                                                          OrderAction
                                                              .order_aproved_from_control
                                                              .getTitle))
                                                  .toString()
                                                  .toString()
                                                  .toString())
                                              : const SizedBox(),
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
                                    if (order.actions.if_action_exist(OrderAction
                                                .order_aproved_from_calculation
                                                .getTitle) ==
                                            false &&
                                        permitionss(
                                            context,
                                            UserPermition
                                                .can_aprove_from_calculation)) {
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
                                                      .get_Date_of_action(
                                                          OrderAction
                                                              .order_aproved_from_calculation
                                                              .getTitle))
                                                  .toString()
                                                  .toString()
                                                  .toString())
                                              : const SizedBox(),
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
                                              ? Text(
                                                  DateFormat('dd-MM-yy/hh:mm a')
                                                      .format(order.actions
                                                          .get_Date_of_action(
                                                              OrderAction
                                                                  .create_order
                                                                  .getTitle))
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
                                //تاريخ التسليم
                                Center(
                                  child: Container(
                                      padding: const EdgeInsets.only(bottom: 3),
                                      child: Text(order.dateTOOrder.formatt(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                //العميل
                                Center(
                                  child: Container(
                                      padding: const EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        permitionss(
                                                context,
                                                UserPermition
                                                    .show_cusotmer_name_in_cutting_order)
                                            ? context
                                                .read<Customer_controller>()
                                                .customers
                                                .where((element) =>
                                                    element.serial ==
                                                    order.customer.to_int())
                                                .first
                                                .name
                                            : order.customer.toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                //الكميه
                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(width: .4)),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    ' ${[
                                                      item.Qantity *
                                                          item.lenth *
                                                          item.hight *
                                                          item.widti /
                                                          1000000
                                                    ].first.removeTrailingZeros}  m3 ',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    )),
                                              ],
                                            )),
                                      )
                                      .toList(),
                                ),
                                // المتبقى                      
                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(width: .4)),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text((item.Qantity- vm.Total_done_of_cutting_order(
                                                          context, order, item)).removeTrailingZeros
                                                 , style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      )
                                      .toList(),
                                ),
                                //الانتاج
                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(width: .4)),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  vm.Total_done_of_cutting_order(
                                                          context, order, item)
                                                      .removeTrailingZeros,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      )
                                      .toList(),
                                ),
                                //النسبه المويه الانجاز
                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(width: .4)),
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                child: LinearPercentIndicator(
                                                  width: 67.0,
                                                  lineHeight: 15.0,
                                                  percent:
                                                      vm.petcentage_of_cutingOrder(
                                                                      context,
                                                                      order,
                                                                      item) /
                                                                  100 >
                                                              1
                                                          ? 1
                                                          : vm.petcentage_of_cutingOrder(
                                                                  context,
                                                                  order,
                                                                  item) /
                                                              100,
                                                  progressColor:
                                                      vm.petcentage_of_cutingOrder(
                                                                  context,
                                                                  order,
                                                                  item) <
                                                              99
                                                          ? Colors.red
                                                          : Colors.green,
                                                ),
                                              ),
                                              Center(
                                                child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 4),
                                                    child: Text(
                                                      "${vm.petcentage_of_cutingOrder(context, order, item).removeTrailingZeros} %",
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),

                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(width: .4)),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  " ${item.color}<<",
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  item.type.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  " <<${item.density.removeTrailingZeros}ك<< ",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  "${item.hight.removeTrailingZeros}*${item.widti.removeTrailingZeros}*${item.lenth.removeTrailingZeros}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                                //الكميه
                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(width: .4)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    item.Qantity.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      )
                                      .toList(),
                                ),
                                //التسلسل
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
                      5: FlexColumnWidth(3),
                      6: FlexColumnWidth(2),
                      7: FlexColumnWidth(1.5),
                      8: FlexColumnWidth(1.5),
                      9: FlexColumnWidth(1),
                      10: FlexColumnWidth(1.3),
                      11: FlexColumnWidth(1.5),
                      12: FlexColumnWidth(5),
                      13: FlexColumnWidth(1),
                      14: FlexColumnWidth(1.2),
      },
      border: TableBorder.all(width: 1, color: Colors.black),
      children: [
        TableRow(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 111, 191, 216),
            ),
            children: [
              Container(
                  padding: const EdgeInsets.all(5), child: const Text("طباعه")),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5), child: const Text("غلق")),
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text("ملاحظات")),
              ),
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
              Container(
                  padding: const EdgeInsets.all(5), child: const Text("تاريخ التسليم")),
              Container(
                  padding: const EdgeInsets.all(5), child: const Text("عميل")),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text("اجمالى م3")),
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text(
                      "المتبقى",
                      style: TextStyle(fontSize: 11),
                    )),
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text(
                      "انتاج",
                      style: TextStyle(fontSize: 11),
                    )),
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text(" %الانجاز")),
              ),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(
                    child: Text('مقاس>>كثافه>>نوع',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No')),
            ElevatedButton(
                // style: ElevatedButton.styleFrom(primary: Colors.red),
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







class DropForCustomers extends StatelessWidget {
   DropForCustomers({super.key});
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
 
    return Consumer<Customer_controller>(
      builder: (context, myType, child) {
            String? selectedValue =
        context.read<Customer_controller>().initialForRaido;
        return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          selectedValue == null ? 'اختر العميل' : selectedValue.toString(),
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: myType.customers.sortedBy<num>((element) => element.serial)
            .map((item) => DropdownMenuItem(
                  value: item.name.toString(),
                  child: Text(
                    "${item.name}-${item.serial}"
                    ,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
            context.read<Customer_controller>().initialForRaido =
                value;
                myType.Refrsh_ui();
        },
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 40,
          width: 200,
        ),
        dropdownStyleData: const DropdownStyleData(
          maxHeight: 200,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: textEditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: '  ... البحث عن عميل',
                hintStyle: const TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value.toString().contains(searchValue);
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    ); },
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
