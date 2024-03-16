// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/controllers/dropDowen_controller.dart';
import 'package:jason_company/main.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/services/pdfprevei.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/reports/%D8%AA%D9%82%D8%A7%D8%B1%D9%8A%D8%B1%20%D8%A7%D9%84%D9%85%D9%82%D8%B5%D8%A7%D8%AA/horizintal/scissor_viewmodel.dart';
import 'package:jason_company/ui/reports/%D8%AA%D9%82%D8%A7%D8%B1%D9%8A%D8%B1%20%D8%A7%D9%84%D9%85%D9%82%D8%B5%D8%A7%D8%AA/horizintal/widgets.dart';
import 'package:jason_company/ui/reports/%D8%AA%D9%82%D8%A7%D8%B1%D9%8A%D8%B1%20%D8%A7%D9%84%D9%85%D9%82%D8%B5%D8%A7%D8%AA/pdfForScissors.dart';
import 'package:provider/provider.dart';

class H_Reports_view extends StatefulWidget {
  const H_Reports_view({super.key});

  @override
  State<H_Reports_view> createState() => _H_Reports_viewState();
}

class _H_Reports_viewState extends State<H_Reports_view> {
  String chosenDate = format.format(DateTime.now());
  scissor_viewmodel vm = scissor_viewmodel();
  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, myType, child) {
        List<BlockModel> totalblocks = myType.blocks
            .where((element) =>
                element.Hscissor ==
                    context.read<dropDowenContoller>().initioalFor_ScissorsReports 
                    &&
                element.actions
                        .get_Date_of_action(
                            BlockAction.cut_block_on_H.getactionTitle)
                        .formatt() ==
                    chosenDate)
            .toList();
        List<FractionModel> fractions =
            totalblocks.expand((element) => element.fractions).toList();
        List<NotFinal> notfinals = [];
        // totalblocks.map((element) => element.stages).map((element) => element).toList();
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    permission().then((value) async {
                      PdfBlockReport123.generate(
                              context, myType.blocks, chosenDate)
                          .then((value) => context.gonext(
                              context,
                              PDfpreview(
                                v: value.save(),
                              )));
                    });
                  },
                  icon: const Icon(Icons.picture_as_pdf)),
              TextButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      setState(() {
                        String formattedDate = format.format(pickedDate);
                        chosenDate = formattedDate;
                      });
                    } else {}
                  },
                  child: Text(
                    chosenDate,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
            ],
            title: const Text(" تقارير المقصات الراسى"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const DropDdowenFor_scissors_reports(),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("${totalblocks.length}   : اجمالى عدد البلوكات"),
                      Text(
                          "${totalblocks.map((e) => e.lenth * e.width * e.hight / 1000000).isEmpty ? 0 : totalblocks.map((e) => e.lenth * e.width * e.hight / 1000000).reduce((value, element) => value + element).toStringAsFixed(2)}  :  اجمالى البلوكات  م3 "),
                      Text(
                          "${totalblocks.map((e) => e.lenth * e.width * e.hight / 1000000).isEmpty ? 0 : totalblocks.map((e) => e.density * e.lenth * e.width * e.hight / 1000000).reduce((value, element) => value + element).toStringAsFixed(2)}  :  اجمالى البلوكات  كج "),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: Text(""
                        // " kg ${totalblocks.map((e) => e.lenth * e.width * e.hight / 1000000).isEmpty ? 0 : totalblocks.map((e) => e.notfinals).expand((element) => element.map((e) => e.wight)).reduce((a, b) => a + b).toStringAsFixed(2)}    :  اجمالى الهوالك"
                        ),
                    children: notfinals
                        .filter_notfinals___()
                        .map((e) => Row(
                              children: [
                                Text(
                                    "kg ${notfinals.isEmpty ? 0 : vm.total_amount_for_notfinals(e, notfinals).toStringAsFixed(2)}"),
                                Text(" ${vm.get(e.type)}"),
                              ],
                            ))
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: Column(
                      children: [
                        Text(
                            " ${totalblocks.map((e) => e.lenth * e.width * e.hight / 1000000).isEmpty ? 0 : totalblocks.map((e) => e.fractions).expand((element) => element.map((e) => e.item.L * e.item.W * e.item.H / 1000000)).reduce((a, b) => a + b).toStringAsFixed(2)} :  اجمالى النواتج  م3"),
                        Text(
                            " ${totalblocks.map((e) => e.lenth * e.width * e.hight / 1000000).isEmpty ? 0 : totalblocks.map((e) => e.fractions).expand((element) => element.map((e) => e.item.density * e.item.L * e.item.W * e.item.H / 1000000)).reduce((a, b) => a + b).toStringAsFixed(2)} :  اجمالى النواتج  كج"),
                      ],
                    ),
                    children: fractions
                        .filter_Fractios___()
                        .map((e) => Row(
                              children: [
                                Text(
                                    " ${vm.total_amount_for_single_siz__fractions(e, fractions)}  <=عدد"),
                                Text(
                                    " ${e.item.color} ${e.item.type} ك${e.item.density}"),
                                Text(" ${e.item.L}*${e.item.W}*${e.item.H}"),
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
