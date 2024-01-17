// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names, use_key_in_widget_constructors, unused_element

import 'dart:io';

import 'package:date_ranger/date_ranger.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/controllers/Customer_controller.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
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
  File('${appDocDirectory!.path}/البلوكات.xlsx')
      .writeAsBytes(bytes, flush: true)
      .then((value) => FileHandleApi.openFile(value));
}

class details_of_finalProdcut extends StatelessWidget {
  details_of_finalProdcut();

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
        columnName: 'amount',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'الكميه',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'customer',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'عميل',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'ading',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'الاضافه',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'outorder',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'الصرف',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'scissor',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'استلام المقصات',
              style: textstyle11,
            ))),
  ];

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SfDataGridState> kkkkk = GlobalKey<SfDataGridState>();

    return Consumer<final_prodcut_controller>(
        builder: (context, mytype, child) {
      return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    context.gonext(context, const Datepker());
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
                        title: 'Total  Quantity: {Count}',
                        titleColumnSpan: 3,
                        columns: [
                          const GridSummaryColumn(
                              name: 'Count',
                              columnName: 'amount',
                              summaryType: GridSummaryType.sum),
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
                  source: EmployeeDataSource2233(context,
                      coumingData: mytype.finalproducts.toList()),
                  columnWidthMode: ColumnWidthMode.fill,
                  columns: columns,
                ),
              ),
            ),
          ));
    });
  }
}

class EmployeeDataSource2233 extends DataGridSource {
//DataGridRowهنا تحويل البيانات الى قائمه من
  EmployeeDataSource2233(
    this.context, {
    required List<FinalProductModel> coumingData,
  }) {
    data = coumingData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'size',
                  value:
                      "${e.hight.removeTrailingZeros}*${e.width.removeTrailingZeros}*${e.lenth.removeTrailingZeros}"),
              DataGridCell<String>(columnName: 'color', value: e.color),
              DataGridCell<double>(columnName: 'denety', value: e.density),
              DataGridCell<String>(columnName: 'type', value: e.type),
              DataGridCell<int>(columnName: 'amount', value: e.amount),
              DataGridCell<String>(
                  columnName: 'customer',
                  value: context
                      .read<Customer_controller>()
                      .customers
                      .where((element) => element.serial == e.customer.to_int())
                      .first
                      .name),
              DataGridCell<String>(
                  columnName: 'ading',
                  value: e.actions.if_action_exist(finalProdcutAction
                          .recive_Done_Form_FinalProdcutStock.getactionTitle)
                      ? format.format(e.actions.get_Date_of_action(
                          finalProdcutAction.recive_Done_Form_FinalProdcutStock
                              .getactionTitle))
                      : "--"),
              DataGridCell<String>(
                  columnName: 'outorder',
                  value: e.actions.if_action_exist(
                          finalProdcutAction.out_order.getactionTitle)
                      ? format.format(e.actions.get_Date_of_action(
                          finalProdcutAction.out_order.getactionTitle))
                      : "--"),
              DataGridCell<String>(
                  columnName: 'scissor',
                  value: e.actions.if_action_exist(finalProdcutAction
                          .incert_finalProduct_from_cutingUnit.getactionTitle)
                      ? format.format(e.actions.get_Date_of_action(
                          finalProdcutAction.incert_finalProduct_from_cutingUnit
                              .getactionTitle))
                      : "--"),
            ]))
        .toList();
  }
  final BuildContext context;
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
