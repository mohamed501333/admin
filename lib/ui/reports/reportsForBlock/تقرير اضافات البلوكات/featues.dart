import 'dart:io';

import 'package:jason_company/services/file_handle_api.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;

Future<void> generateAndSaveExcel() async {
  final xcel.Workbook workbook = xcel.Workbook(); // create a new excel workbook
  final xcel.Worksheet sheet = workbook
      .worksheets[0]; // the sheet we will be populating (only the first sheet)
  const String excelFile = 'test_download'; // the name of the excel

  sheet.getRangeByIndex(1, 1).setText('Student Name');
  sheet.getRangeByIndex(1, 2).setText('Masdfgfdgfsgfggffgths');
  sheet.getRangeByIndex(1, 3).setText('English');
  sheet.getRangeByIndex(1, 4).setText('Kiswahili');
  sheet.getRangeByIndex(1, 5).setText('Physics');
  sheet.getRangeByIndex(1, 6).setText('Biology');
  sheet.getRangeByIndex(1, 7).setText('Chemistry');
  sheet.getRangeByIndex(1, 8).setText('Geography');
  sheet.getRangeByIndex(1, 9).setText('Spanish');
  sheet.getRangeByIndex(1, 10).setText('Total');

  // loop through the results to set the data in the excel sheet cells
  for (var i = 0; i < 5; i++) {
    sheet.getRangeByIndex(i + 2, 1).setText('1');
    sheet.getRangeByIndex(i + 2, 2).setText("2");
    sheet.getRangeByIndex(i + 2, 3).setText("3");
    sheet.getRangeByIndex(i + 2, 4).setText("4");
    sheet.getRangeByIndex(i + 2, 5).setText("5");
    sheet.getRangeByIndex(i + 2, 6).setText("6");
    sheet.getRangeByIndex(i + 2, 7).setText("7");
    sheet.getRangeByIndex(i + 2, 8).setText("8");
    sheet.getRangeByIndex(i + 2, 9).setText("9");
    sheet.getRangeByIndex(i + 2, 10).setText("10");
  }

  // save the document in the downloads file
  final List<int> bytes = workbook.saveAsStream();
  File('/storage/emulated/0/Download/$excelFile.xlsx')
      .writeAsBytes(bytes)
      .then((value) => FileHandleApi.openFile(value));

  //dispose the workbook
  // workbook.dispose();
}
