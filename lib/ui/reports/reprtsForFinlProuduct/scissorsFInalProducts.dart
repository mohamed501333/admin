// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/reports/reprtsForFinlProuduct/finalProductReports_view.dart';
import 'package:jason_company/ui/reports/reprtsForFinlProuduct/reports_viewmoder.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/models/moderls.dart';

// ignore: must_be_immutable
class ScissorsFInalProducts extends StatelessWidget {
  ScissorsFInalProducts({super.key});
  final GlobalKey<SfDataGridState> mkey = GlobalKey<SfDataGridState>();

  Future<List<int>> _readFontData() async {
    final ByteData bytes =
        await rootBundle.load("assets/fonts/HacenTunisia.ttf");
    return bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text('انتاج تام الصنع لكل مقص'),
              IconButton(
                  onPressed: () async {
                    await createAndopenPdf(_readFontData, mkey, "لكل مقص");
                  },
                  icon: const Icon(Icons.picture_as_pdf_outlined))
            ],
          ),
        ),
        body: Consumer<final_prodcut_controller>(
          builder: (context, finalproducts, child) {
            const textstyle =
                TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
            return SfDataGridTheme(
              data: SfDataGridThemeData(
                  headerColor: const Color.fromARGB(255, 189, 233, 228)),
              child: SfDataGrid(
                key: mkey,
                allowSorting: true,
                allowMultiColumnSorting: true,
                allowTriStateSorting: true,
                source: EmployeeDataSource(
                  context: context,
                  employeeData: finalproducts.finalproducts
                      .where((element) =>
                          element.actions.if_action_exist(finalProdcutAction
                              .final_prodcut_DidQalityCheck.getactionTitle) ==
                          true)
                      .toList()
                      .filteronfinalproductwithcsissor(),
                  finalproducts: finalproducts.finalproducts
                      .where((element) =>
                          element.actions.if_action_exist(finalProdcutAction
                              .final_prodcut_DidQalityCheck.getactionTitle) ==
                          true)
                      .toList(),
                ),
                columnWidthMode: ColumnWidthMode.fill,
                columns: <GridColumn>[
                  GridColumn(
                      columnName: 'نوع',
                      label: Container(
                          padding: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'نوع',
                            style: textstyle,
                          ))),
                  GridColumn(
                      columnName: 'كثافه',
                      label: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'كثافه',
                            style: textstyle,
                          ))),
                  GridColumn(
                      columnName: 'لون',
                      label: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'لون',
                            style: textstyle,
                            overflow: TextOverflow.ellipsis,
                          ))),
                  GridColumn(
                      columnName: 'مقص',
                      label: GestureDetector(
                        onTap: () {
                          EmployeeDataSource(
                            context: context,
                            employeeData: finalproducts.finalproducts
                                .where((element) =>
                                    element.actions.if_action_exist(
                                        finalProdcutAction
                                            .final_prodcut_DidQalityCheck
                                            .getactionTitle) ==
                                    true)
                                .toList()
                                .filteronfinalproductwithcsissor(),
                            finalproducts: finalproducts.finalproducts
                                .where((element) =>
                                    element.actions.if_action_exist(
                                        finalProdcutAction
                                            .final_prodcut_DidQalityCheck
                                            .getactionTitle) ==
                                    true)
                                .toList(),
                          ).sortedColumns.add(const SortColumnDetails(
                              name: 'مقص',
                              sortDirection: DataGridSortDirection.ascending));
                        },
                        child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'مقص',
                              style: textstyle,
                            )),
                      )),
                  GridColumn(
                      columnName: 'كميه',
                      label: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'عدد',
                            style: textstyle,
                          ))),
                  GridColumn(
                      minimumWidth: 110,
                      columnName: 'مقاس',
                      label: Container(
                          padding: const EdgeInsets.all(4),
                          alignment: Alignment.center,
                          child: const Text(
                            'المقاس',
                            style: textstyle,
                          ))),
                ],
              ),
            );
          },
        ));
  }
}

class EmployeeDataSource extends DataGridSource {
  ReportsViewModel vm = ReportsViewModel();
  BuildContext context;
  List<FinalProductModel> finalproducts;

  EmployeeDataSource(
      {required List<FinalProductModel> employeeData,
      required this.context,
      required this.finalproducts}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'نوع', value: e.type),
              DataGridCell<double>(columnName: 'كثافه', value: e.density),
              DataGridCell<String>(columnName: 'لون', value: e.color),
              DataGridCell<int>(columnName: 'مقص', value: e.scissor),
              DataGridCell<int>(
                  columnName: 'كميه',
                  value: vm.totalofSingleSizeOfsingleScissor(e, finalproducts)),
              DataGridCell<String>(
                  columnName: 'مقاس',
                  value:
                      "${e.hight.removeTrailingZeros}*${e.width.removeTrailingZeros}*${e.lenth.removeTrailingZeros}"),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      TextStyle? getTextStyle() {
        if (e.columnName == 'كميه') {
          return const TextStyle(color: Colors.pinkAccent);
        } else {
          return null;
        }
      }

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
