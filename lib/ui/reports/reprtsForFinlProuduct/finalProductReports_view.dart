// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/main.dart';
import 'package:jason_company/services/file_handle_api.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/reports/reprtsForFinlProuduct/reports_viewmoder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';

class FinalProductReportsview extends StatelessWidget {
  FinalProductReportsview({super.key});
  final GlobalKey<SfDataGridState> mkey = GlobalKey<SfDataGridState>();
  Future<List<int>> _readFontData() async {
    final ByteData bytes =
        await rootBundle.load("assets/fonts/HacenTunisia.ttf");
    return bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  }

  String chosenDate = format.format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text('انتاج تام الصنع'),
              IconButton(
                  onPressed: () async {
                    await createAndopenPdf(_readFontData, mkey, chosenDate);
                  },
                  icon: Icon(Icons.picture_as_pdf_outlined))
            ],
          ),
          actions: [
            TextButton(onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101));

              if (pickedDate != null) {
                String formattedDate = format.format(pickedDate);
                chosenDate = formattedDate;
                context.read<final_prodcut_controller>().Refresh_Ui();
              } else {}
            }, child: Consumer<final_prodcut_controller>(
              builder: (context, myType, child) {
                return Text(
                  chosenDate,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                );
              },
            ))
          ],
        ),
        body: Consumer<final_prodcut_controller>(
          builder: (context, finalproducts, child) {
            const textstyle =
                TextStyle(fontWeight: FontWeight.bold, fontSize: 13);
            return Column(
              children: [
                Results(chosenDate: chosenDate),
                SizedBox(
                  height: 500,
                  child: SfDataGridTheme(
                    data: SfDataGridThemeData(
                        headerColor: const Color.fromARGB(255, 189, 233, 228)),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: SfDataGrid(
                        allowSorting: true,
                        allowMultiColumnSorting: true,
                        allowTriStateSorting: true,
                        key: mkey,
                        source: EmployeeDataSource(
                            context: context,
                            employeeData: finalproducts.finalproducts
                                .where((element) =>
                                    element.actions.if_action_exist(
                                        finalProdcutAction
                                            .incert_finalProduct_from_cutingUnit
                                            .getactionTitle) ==
                                    true)
                                .toList()
                                .filter_date(context, chosenDate)
                                .filteronfinalproduct(),
                            finalproducts: finalproducts.finalproducts
                                .where((element) =>
                                    element.actions.if_action_exist(
                                        finalProdcutAction
                                            .incert_finalProduct_from_cutingUnit
                                            .getactionTitle) ==
                                    true)
                                .toList()
                                .filter_date(context, chosenDate)),
                        columnWidthMode: ColumnWidthMode.fill,
                        columns: <GridColumn>[
                          GridColumn(
                              columnName: 'نوع',
                              label: Container(
                                  padding: const EdgeInsets.all(1.0),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'نوع',
                                    style: textstyle,
                                  ))),
                          GridColumn(
                              columnName: 'كثافه',
                              label: Container(
                                  padding: const EdgeInsets.all(1.0),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'كثافه',
                                    style: textstyle,
                                  ))),
                          GridColumn(
                              columnName: 'لون',
                              label: Container(
                                  padding: const EdgeInsets.all(1.0),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'لون',
                                    style: textstyle,
                                    overflow: TextOverflow.ellipsis,
                                  ))),
                          GridColumn(
                              columnName: 'عميل',
                              label: Container(
                                  padding: const EdgeInsets.all(1.0),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'شركه',
                                    style: textstyle,
                                  ))),
                          GridColumn(
                              columnName: 'كميه',
                              label: Container(
                                  padding: const EdgeInsets.all(1.0),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'عدد',
                                    style: textstyle,
                                  ))),
                          GridColumn(
                              minimumWidth: 110,
                              columnName: 'مقاس',
                              label: Container(
                                  padding: const EdgeInsets.all(1.0),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'المقاس',
                                    style: textstyle,
                                  ))),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        )).permition(context, UserPermition.show_Reports_finalprodcut);
  }
}

Future<void> createAndopenPdf(
    readFontData, GlobalKey<SfDataGridState> mkey, String date) async {
  Directory? appDocDirectory = await getExternalStorageDirectory();

  String x =
      "${appDocDirectory!.path}/${formatwitTime2.format(DateTime.now())} يومية تام";
  permission();
  var arabicFont = PdfTrueTypeFont(await readFontData(), 14);
  PdfDocument document = mkey.currentState!.exportToPdfDocument(
      headerFooterExport:
          (DataGridPdfHeaderFooterExportDetails headerFooterExport) {
    final double width = headerFooterExport.pdfPage.getClientSize().width;

    final PdfPageTemplateElement header =
        PdfPageTemplateElement(Rect.fromLTWH(0, 0, width, 65));
    header.graphics.drawString("الانتاج التام $date", arabicFont,
        bounds: const Rect.fromLTWH(0, 25, 200, 60),
        format: PdfStringFormat(textDirection: PdfTextDirection.rightToLeft));
    headerFooterExport.pdfDocumentTemplate.top = header;
  }, cellExport: (details) {
    if (details.cellType == DataGridExportCellType.columnHeader) {
      details.pdfCell.style.backgroundBrush = PdfBrushes.pink;
      details.pdfCell.style.font = arabicFont;
      details.pdfCell.stringFormat.textDirection = PdfTextDirection.rightToLeft;
    }
    if (details.cellType == DataGridExportCellType.row) {
      details.pdfCell.style.backgroundBrush = PdfBrushes.lightCyan;
      details.pdfCell.style.font = arabicFont;
      details.pdfCell.stringFormat.textDirection = PdfTextDirection.rightToLeft;
    }
  });
  final List<int> bytes = document.saveSync();
  File('$x.pdf')
      .writeAsBytes(bytes)
      .then((value) => FileHandleApi.openFile(value));
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
              DataGridCell<String>(columnName: 'عميل', value: e.customer),
              DataGridCell<int>(
                  columnName: 'كميه',
                  value: vm.totalofSingleSize(e, finalproducts)),
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

// جدول الاجمالى
class Results extends StatelessWidget {
  const Results({super.key, required this.chosenDate});
  final String chosenDate;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        children: [const HeaderOftable22(), TheTable23(chosenDate: chosenDate)],
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
          3: FlexColumnWidth(1),
          1: FlexColumnWidth(.3),
          0: FlexColumnWidth(.3),
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
                    padding: const EdgeInsets.all(4), child: const Text("م")),
                Container(
                    padding: const EdgeInsets.all(4),
                    child: const Text("كثافه")),
                Container(
                    padding: const EdgeInsets.all(4),
                    child: const Center(child: Text('نوع'))),
                Container(
                    padding: const EdgeInsets.all(4),
                    child: const Text('اجمالى وارد مخزن منتج تام')),
              ])
        ],
      ),
    );
  }
}

class TheTable23 extends StatelessWidget {
  TheTable23({
    super.key,
    required this.chosenDate,
  });
  ReportsViewModel vm = ReportsViewModel();
  int x = 0;
  final String chosenDate;

  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, finalproducts, child) {
        List<FinalProductModel> f = finalproducts.finalproducts
            .where((element) =>
                format.format(element.actions.get_Date_of_action(
                    finalProdcutAction
                        .incert_finalProduct_from_cutingUnit.getactionTitle)) ==
                chosenDate)
            .toList();
        return Expanded(
          flex: 4,
          child: SingleChildScrollView(
            child: Table(
              columnWidths: const {
                3: FlexColumnWidth(1),
                1: FlexColumnWidth(.3),
                0: FlexColumnWidth(.3),
                2: FlexColumnWidth(.3),
              },
              children: f.filter_type_density().map((e) {
                x++;

                return TableRow(
                    decoration: BoxDecoration(
                      color: Colors.teal[50],
                    ),
                    children: [
                      Container(
                          padding: const EdgeInsets.all(4), child: Text("$x")),
                      Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(e.density.toString())),
                      Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            e.type,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 221, 2, 75)),
                          )),
                      Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(vm
                              .total_finalprodut(f, e)
                              .toStringAsFixed(1)
                              .toString())),
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
