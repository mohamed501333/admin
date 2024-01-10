// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:jason_company/ui/reports/block%20reports%20details.com/block_details_view.dart';
import 'package:jason_company/ui/reports/reportsForBlock/W.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class BlockReportsView extends StatelessWidget {
  const BlockReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تقارير مخزن البلوكات"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          //جدول الاجماليات
          const HeaderOftable4(),
          TheTable2(),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 200,
              height: 60,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(9))),
              child: const Center(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "جرد مخزن البلوك",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_downward),
                          Icon(Icons.arrow_downward),
                          Icon(Icons.arrow_downward),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          //جرد مخزن البلوك
          const BlockStockInventory()
        ],
      ),
    );
  }
}

class DailyBlockReportsView extends StatelessWidget {
  DailyBlockReportsView({super.key});
  final GlobalKey<SfDataGridState> kkkkk = GlobalKey<SfDataGridState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              createAndopenEXL(kkkkk);
            },
            icon: const Icon(Icons.explicit_outlined),
          )
        ],
        title: const Text(" تقارير يومية بلوكات"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          //جدول الاجماليات
          const HeaderOftable422(),
          TheTable222(),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 200,
              height: 60,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(9))),
              child: const Center(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "  البلوكات المصرفه اليوم",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_downward),
                          Icon(Icons.arrow_downward),
                          Icon(Icons.arrow_downward),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          //جرد مخزن البلوك
          BlockStockInventory22(
            kkkkk: kkkkk,
          )
        ],
      ),
    );
  }
}
