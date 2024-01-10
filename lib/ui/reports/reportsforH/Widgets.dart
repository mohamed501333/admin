// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/controllers/fractinsFirebaseController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/reports/reportsforH/h_reports_viewModel.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

//جدول المنصرف من الخزن
class BlockStockInventoryForH extends StatelessWidget {
  const BlockStockInventoryForH({super.key, required this.scissor});
  final int scissor;

  @override
  Widget build(BuildContext context) {
    const textstyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
    var columns = <GridColumn>[
      GridColumn(
          columnName: 'amount',
          label: Container(
              alignment: Alignment.center,
              child: const Text(
                'عدد',
                style: textstyle,
              ))),
      GridColumn(
          minimumWidth: 110,
          columnName: 'size',
          label: Container(
              padding: const EdgeInsets.all(4),
              alignment: Alignment.center,
              child: const Text(
                'المقاس',
                style: textstyle,
              ))),
      GridColumn(
          columnName: 'color',
          label: Container(
              alignment: Alignment.center,
              child: const Text(
                'لون',
                style: textstyle,
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'denety',
          label: Container(
              alignment: Alignment.center,
              child: const Text(
                'كثافه',
                style: textstyle,
              ))),
      GridColumn(
          columnName: 'type',
          label: Container(
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              child: const Text(
                'نوع',
                style: textstyle,
              ))),
      GridColumn(
          columnName: 'serial',
          label: Container(
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              child: const Text(
                'كود',
                style: textstyle,
              ))),
    ];
    return Consumer<BlockFirebasecontroller>(
      builder: (context, blocks, child) {
        return SfDataGridTheme(
          data: SfDataGridThemeData(
              headerColor: const Color.fromARGB(255, 189, 233, 228)),
          child: SfDataGrid(
            allowSorting: true,
            allowMultiColumnSorting: true,
            allowTriStateSorting: true,
            source: EmployeeDataSourcee(
                coumingData: blocks.blocks
                    .filter_date_consumed(context)
                    .where((element) =>
                        element.actions.if_action_exist(
                            BlockAction.consume_block.getactionTitle) ==
                        false)
                    .toList(),
                scissor: scissor),
            columnWidthMode: ColumnWidthMode.fill,
            columns: columns,
          ),
        );
      },
    );
  }
}

class EmployeeDataSourcee extends DataGridSource {
  HReportsViewModel vm = HReportsViewModel();
//DataGridRowهنا تحويل البيانات الى قائمه من
  EmployeeDataSourcee(
      {required List<BlockModel> coumingData, required int scissor}) {
    data = coumingData
        .where((e) => e.Hscissor == scissor)
        .toList()
        .filter_filter_type_density_color_size_serial()
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: 'amount',
                  value: vm.total_amount_for_single_siz__(
                      e, coumingData, scissor)),
              DataGridCell<String>(
                  columnName: 'size',
                  value: "${e.hight}*${e.width}*${e.lenth}"),
              DataGridCell<String>(columnName: 'color', value: e.color),
              DataGridCell<double>(columnName: 'denety', value: e.density),
              DataGridCell<String>(columnName: 'type', value: e.type),
              DataGridCell<String>(columnName: 'serial', value: e.serial),
            ]))
        .toList();
  }

  List<DataGridRow> data = [];

  @override
  List<DataGridRow> get rows => data;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      //انشاء ستايل ل بيانات الخلايا
      TextStyle? getTextStyle() {
        if (e.columnName == 'amount') {
          return const TextStyle(color: Colors.pinkAccent);
        } else {
          return null;
        }
      }

      //هنا الخلايا
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4.0),
        child: Text(
          e.value.toString(),
          style: getTextStyle(),
        ),
      );
    }).toList());
  }
}

//جدول النواتج
class Results extends StatelessWidget {
  const Results({super.key, required this.scissor});
  final int scissor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          const HeaderOftable22(),
          TheTable23(
            scissor: scissor,
          )
        ],
      ),
    );
  }
}

class HeaderOftable22 extends StatelessWidget {
  const HeaderOftable22({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(.4),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(.3),
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
                    child: const Text("ناتج")),
                Container(
                    padding: const EdgeInsets.all(4),
                    child: const Center(child: Text('تصنيع'))),
                Container(
                    padding: const EdgeInsets.all(4), child: const Text('م')),
              ])
        ],
      ),
    );
  }
}

class TheTable23 extends StatelessWidget {
  TheTable23({
    super.key,
    required this.scissor,
  });
  final int scissor;
  HReportsViewModel vm = HReportsViewModel();

  @override
  Widget build(BuildContext context) {
    int x = 0;
    return Consumer<FractionFirebaseController>(
      builder: (context, fractions, child) {
        return Expanded(
          flex: 4,
          child: SingleChildScrollView(
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(.4),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(.3),
              },
              children: fractions.fractions
                  .where((element) => element.Hscissor == scissor)
                  .toList()
                  .filter_Fractios___()
                  .map((e) {
                x++;

                return TableRow(
                    decoration: BoxDecoration(
                      color: Colors.teal[50],
                    ),
                    children: [
                      Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            vm
                                .total_amount_for_single_siz__fractions(
                                    e, fractions.fractions, scissor)
                                .toString(),
                          )),
                      Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            "${e.hight}*${e.wedth}*${e.lenth}",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 221, 2, 75)),
                          )),
                      Container(
                          padding: const EdgeInsets.all(4), child: Text("$x")),
                    ]);
              }).toList(),
              border: TableBorder.all(width: 1, color: Colors.black),
            ),
          ),
        );
      },
    );
  }
}
