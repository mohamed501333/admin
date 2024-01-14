// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/controllers/Order_controller.dart';
import 'package:jason_company/services/pdfprevei.dart';
import 'package:jason_company/ui/cutting_order/componants.dart';
import 'package:jason_company/ui/cutting_order/cuting_order_pdf.dart';
import 'package:jason_company/ui/cutting_order/cutting_ordera_viewModer.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

class CuttingOrderView extends StatelessWidget {
  const CuttingOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    CuttingOrderViewModel vm = CuttingOrderViewModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text('اوامر التشغيل'),
        actions: [
          IconButton(
              onPressed: () {
                context.gonext(context, HistoryPage());
              },
              icon: const Icon(Icons.history))
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Fields001(vm: vm),
          RowScroll(vm: vm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Buttoms001(
                vm: vm,
              ),
              Buttoms003(vm: vm),
              Buttoms002(vm: vm),
            ],
          ),
          TheTable001(
            vm: vm,
          )
        ],
      ),
    );
  }
}

class RowScroll extends StatelessWidget {
  const RowScroll({
    super.key,
    required this.vm,
  });

  final CuttingOrderViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectBoxController>(
      builder: (context, myType, child) {
        return Row(children: [
          Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  children: vm.temp
                      .map((e) => Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(14)),
                            child: Row(
                              children: [
                                Text(
                                  "${e.lenth.removeTrailingZeros}*${e.widti.removeTrailingZeros}*${e.hight.removeTrailingZeros}=>>>",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "${e.Qantity}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 226, 2, 133)),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                )),
          ),
        ]);
      },
    );
  }
}

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});
  CuttingOrderViewModel vm = CuttingOrderViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تاريخ اوامر التشغيل"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          HistoryForOrders(vm: vm),
        ],
      ),
    );
  }
}

class HistoryForOrders extends StatelessWidget {
  const HistoryForOrders({
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
                  const HeaderOftable00122(),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(3),
                      3: FlexColumnWidth(3),
                      4: FlexColumnWidth(3),
                      5: FlexColumnWidth(2),
                      6: FlexColumnWidth(1),
                      7: FlexColumnWidth(1.5),
                      8: FlexColumnWidth(4),
                      9: FlexColumnWidth(1),
                      10: FlexColumnWidth(1.2),
                    },
                    children: orders.orders
                        .where((element) =>
                            element.actions.if_action_exist(
                                OrderAction.order_colosed.getTitle) ==
                            true)
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
                                //ايقونة الطباعه
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
                                          order.actions.if_action_exist(
                                                      OrderAction.order_colosed
                                                          .getTitle) ==
                                                  false
                                              ? showmyAlertDialog(
                                                  context,
                                                  OrderAction.order_colosed,
                                                  order)
                                              : DoNothingAction();
                                        },
                                        child: Column(
                                          children: [
                                            const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: Column(
                                                  children: [
                                                    Icon(order.actions.if_action_exist(
                                                                OrderAction
                                                                    .order_colosed
                                                                    .getTitle) ==
                                                            true
                                                        ? Icons.check
                                                        : Icons.close),
                                                    order.actions.if_action_exist(
                                                                OrderAction
                                                                    .order_colosed
                                                                    .getTitle) ==
                                                            true
                                                        ? Text(DateFormat(
                                                                'dd-MM-yy/hh:mm a')
                                                            .format(order
                                                                .actions
                                                                .get_Date_of_action(
                                                                    OrderAction
                                                                        .order_colosed
                                                                        .getTitle))
                                                            .toString()
                                                            .toString()
                                                            .toString())
                                                        : const SizedBox(),

                                                    //اليوزر اذا تم القص
                                                    order.actions.if_action_exist(
                                                                OrderAction
                                                                    .order_colosed
                                                                    .getTitle) ==
                                                            true
                                                        ? Text(order.actions
                                                            .get_order_Who_Of(
                                                                OrderAction
                                                                    .order_colosed))
                                                        : const SizedBox(),
                                                  ],
                                                ))
                                          ],
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
                                                      .get_Date_of_action(
                                                          OrderAction
                                                              .order_aproved_from_control
                                                              .getTitle))
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
                                                      .get_Date_of_action(
                                                          OrderAction
                                                              .order_aproved_from_calculation
                                                              .getTitle))
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

                                //اجمالى 3

                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
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
                                //الانجاز
                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
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
                                //النوع

                                //الكثافه

                                //المقاس
                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                item.type.toString(),
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: order.items.indexOf(
                                                                  item) %
                                                              2 ==
                                                          0
                                                      ? Colors.cyan
                                                      : Colors.black,
                                                ),
                                              ),
                                              Text(
                                                " <<${item.density.removeTrailingZeros}ك<< ",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: order.items.indexOf(
                                                                  item) %
                                                              2 ==
                                                          0
                                                      ? Colors.cyan
                                                      : Colors.black,
                                                ),
                                              ),
                                              Text(
                                                "${item.hight.removeTrailingZeros}*${item.widti.removeTrailingZeros}*${item.lenth.removeTrailingZeros}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: order.items.indexOf(
                                                                  item) %
                                                              2 ==
                                                          0
                                                      ? Colors.cyan
                                                      : Colors.black,
                                                ),
                                              ),
                                            ],
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
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
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

class HeaderOftable00122 extends StatelessWidget {
  const HeaderOftable00122({
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
        4: FlexColumnWidth(3),
        5: FlexColumnWidth(2),
        6: FlexColumnWidth(1),
        7: FlexColumnWidth(1.5),
        8: FlexColumnWidth(4),
        9: FlexColumnWidth(1),
        10: FlexColumnWidth(1.2),
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
              Container(
                  padding: const EdgeInsets.all(5), child: const Text("")),
              Container(
                  padding: const EdgeInsets.all(5),
                  child: const Text("الملاحظات")),
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
              Container(
                  padding: const EdgeInsets.all(5), child: const Text("عميل")),
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
