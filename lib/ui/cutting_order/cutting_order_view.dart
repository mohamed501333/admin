// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/ui/cutting_order/componants.dart';
import 'package:jason_company/ui/cutting_order/cutting_ordera_viewModer.dart';
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
        ],
      ),
    );
  }
}
