// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names, use_key_in_widget_constructors, unused_element

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:date_ranger/date_ranger.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/main.dart';
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
  File('${appDocDirectory!.path}/${formatwitTime2.format(DateTime.now())}تفاصيل البلوكات.xlsx')
      .writeAsBytes(bytes, flush: true)
      .then((value) => FileHandleApi.openFile(value));
}

class Block_detaild_view extends StatelessWidget {
  Block_detaild_view();

  var columns = <GridColumn>[
    GridColumn(
        visible: false,
        allowFiltering: true,
        columnName: 'id',
        label: Container(
            padding: const EdgeInsets.all(4),
            alignment: Alignment.center,
            child: Text(
              'ID',
              style: textstyle11,
            ))),
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
        columnName: 'density',
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
                      allowSwiping: true,
                      swipeMaxOffset: 100.0,
                      endSwipeActionsBuilder: (BuildContext context,
                          DataGridRow row, int rowIndex) {
                        return GestureDetector(
                            onTap: () {
                              print(row.getCells().first.value);
                              blocks.deleteblock(blocks.blocks
                                  .where((element) =>
                                      element.id == row.getCells().first.value)
                                  .first);
                            },
                            child: Container(
                                color: Colors.redAccent,
                                child: const Center(
                                  child: Icon(Icons.delete),
                                ))).permition(context,
                            UserPermition.delete_in_finalprodcut_details);
                      },
                      gridLinesVisibility: GridLinesVisibility.both,
                      headerGridLinesVisibility: GridLinesVisibility.both,
                      allowEditing: permitionss(
                          context, UserPermition.allow_edit_in_details_blocks),
                      selectionMode: SelectionMode.multiple,
                      navigationMode: GridNavigationMode.cell,
                      isScrollbarAlwaysShown: true,
                      key: kkkkk,
                      allowSorting: true,
                      allowMultiColumnSorting: true,
                      allowTriStateSorting: true,
                      allowFiltering: true,
                      source: EmployeeDataSource22(context,
                          coumingData: blocks.blocks),
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

dynamic newCellValue;
TextEditingController editingController = TextEditingController();

class EmployeeDataSource22 extends DataGridSource {
//DataGridRowهنا تحويل البيانات الى قائمه من
  EmployeeDataSource22(
    this.context, {
    required List<BlockModel> coumingData,
  }) {
    data = coumingData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(
                  columnName: 'size',
                  value: "${e.hight}*${e.width}*${e.lenth}"),
              DataGridCell<String>(columnName: 'color', value: e.color),
              DataGridCell<double>(columnName: 'density', value: e.density),
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
    data2 = coumingData;
  }
  final BuildContext context;

  List<DataGridRow> data = [];
  List<BlockModel> data2 = [];

  @override
  List<DataGridRow> get rows => data;
  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Text(summaryValue),
    );
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value
            ?.toString() ??
        '';
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value ??
        '';

    final int dataRowIndex = data.indexOf(dataGridRow);
    final BlockModel u = data2.elementAt(dataRowIndex);

    newCellValue = "";

    final bool isNumericType =
        column.columnName == 'id' || column.columnName == 'amount';

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
      child: TextField(
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign: isNumericType ? TextAlign.right : TextAlign.left,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 16.0),
        ),
        keyboardType: isNumericType ? TextInputType.number : TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (isNumericType) {
              newCellValue = int.parse(value);
            } else {
              newCellValue = value;
            }
          } else {
            newCellValue = null;
          }
        },
        onSubmitted: (String value) {
          // print(u);
          print(dataGridRow.getCells()[0].value);
          print(dataGridRow.getCells()[1].value);
          print(oldValue);
          print(column.columnName);
          if (column.columnName == "size") {
            String i = value;
            List<String> b = i.replaceAll("*", " ").split(" ");
            print(b);
            context
                .read<BlockFirebasecontroller>()
                .edit_cell_size(oldValue, u.id, column.columnName, b);
          } else {
            context
                .read<BlockFirebasecontroller>()
                .edit_cell(u.id, column.columnName, value);
            submitCell();
          }
          submitCell();
        },
      ),
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

                      myType.filterBlocksCreatedBetweenTowDates();
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
