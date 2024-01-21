// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names, use_key_in_widget_constructors, unused_element

import 'dart:io';

import 'package:date_ranger/date_ranger.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/services/file_handle_api.dart';

import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';

import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

TextStyle textstyle11 =
    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
Future<void> createAndopenEXL(
  GlobalKey<SfDataGridState> mkey,
) async {
  permission();
  Directory? appDocDirectory = await getExternalStorageDirectory();

  final Workbook workbook = Workbook();
  final Worksheet worksheet = workbook.worksheets[0];
  mkey.currentState!.exportToExcelWorksheet(worksheet);
  final List<int> bytes = workbook.saveAsStream();
  File('${appDocDirectory!.path}/البلوكات.xlsx')
      .writeAsBytes(bytes, flush: true)
      .then((value) => FileHandleApi.openFile(value));
}

class Block_detaild_view extends StatelessWidget {
  Block_detaild_view();

  var columns = <GridColumn>[
    GridColumn(
        allowFiltering: true,
        columnName: 'size',
        label: Container(
            padding: const EdgeInsets.all(4),
            alignment: Alignment.center,
            child: Text(
              'المقاس',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'color',
        label: Container(
            alignment: Alignment.center,
            child: Text(
              'لون',
              style: textstyle11,
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'denety',
        label: Container(
            alignment: Alignment.center,
            child: Text(
              'كثافه',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'type',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'نوع',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'serial',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'كود',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'description',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'وصف',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'wight',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'وزن',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'num',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'رقم',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'date',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'تاريخ الصرف',
              style: textstyle11,
            ))),
  ];

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SfDataGridState> kkkkk = GlobalKey<SfDataGridState>();

    return Consumer<BlockFirebasecontroller>(builder: (context, blocks, child) {
      return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        context.gonext(context, Datepker());
                      },
                      icon: const Icon(Icons.date_range)),
                  IconButton(
                    onPressed: () async {
                      createAndopenEXL(kkkkk);
                    },
                    icon: const Icon(Icons.explicit_outlined),
                  ),
                ],
              ),
              body: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: 1000,
                    child: SfDataGrid(
                      tableSummaryRows: [
                        GridTableSummaryRow(
                            showSummaryInRow: true,
                            title: 'Total  Count: {Count}',
                            titleColumnSpan: 3,
                            columns: [
                              const GridSummaryColumn(
                                  name: 'Count',
                                  columnName: 'num',
                                  summaryType: GridSummaryType.count),
                            ],
                            position: GridTableSummaryRowPosition.top),
                      ],
                      gridLinesVisibility: GridLinesVisibility.both,
                      headerGridLinesVisibility: GridLinesVisibility.both,
                      isScrollbarAlwaysShown: true,
                      key: kkkkk,
                      allowSorting: true,
                      allowMultiColumnSorting: true,
                      allowTriStateSorting: true,
                      allowFiltering: true,
                      source: EmployeeDataSource22(coumingData: blocks.blocks),
                      columnWidthMode: ColumnWidthMode.fill,
                      columns: columns,
                    ),
                  ),
                ),
              ))
          .permition(
              context, UserPermition.show_Reports_details_of_block_stock);
    });
  }
}

class EmployeeDataSource22 extends DataGridSource {
//DataGridRowهنا تحويل البيانات الى قائمه من
  EmployeeDataSource22({
    required List<BlockModel> coumingData,
  }) {
    data = coumingData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'size',
                  value: "${e.hight}*${e.width}*${e.lenth}"),
              DataGridCell<String>(columnName: 'color', value: e.color),
              DataGridCell<double>(columnName: 'denety', value: e.density),
              DataGridCell<String>(columnName: 'type', value: e.type),
              DataGridCell<String>(columnName: 'serial', value: e.serial),
              DataGridCell<String>(
                  columnName: 'description', value: e.discreption),
              DataGridCell<double>(columnName: 'wight', value: e.wight),
              DataGridCell<int>(columnName: 'num', value: e.number),
              DataGridCell<String>(
                  columnName: 'date',
                  value: e.actions.if_action_exist(
                          BlockAction.consume_block.getactionTitle)
                      ? DateFormat('yyyy/MM/dd').format(e.actions
                          .get_Date_of_action(
                              BlockAction.consume_block.getactionTitle))
                      : '0 غير مصروف '),
            ]))
        .toList();
  }

  List<DataGridRow> data = [];

  @override
  List<DataGridRow> get rows => data;
  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Text(summaryValue),
    );
  }

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

/////////////////////////////////////////////////////////////////////////////////////////////

class Datepker extends StatelessWidget {
  const Datepker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, myType, child) {
        return Scaffold(
            appBar: AppBar(),
            body: SizedBox(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: DateRanger(
                    initialRange: myType.initialDateRange,
                    onRangeChanged: (range) {
                      myType.initialDateRange = range;

                      myType.filterdatesbbbbb();
                      myType.Refresh_the_UI();
                    },
                  ),
                ),
              ),
            ));
      },
    );
  }
}
