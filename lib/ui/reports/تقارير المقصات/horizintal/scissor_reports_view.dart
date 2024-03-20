// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/main.dart';
import 'package:jason_company/services/pdfprevei.dart';
import 'package:jason_company/ui/reports/%D8%AA%D9%82%D8%A7%D8%B1%D9%8A%D8%B1%20%D8%A7%D9%84%D9%85%D9%82%D8%B5%D8%A7%D8%AA/horizintal/pdfForAllOF_h.dart';
import 'package:jason_company/ui/reports/%D8%AA%D9%82%D8%A7%D8%B1%D9%8A%D8%B1%20%D8%A7%D9%84%D9%85%D9%82%D8%B5%D8%A7%D8%AA/horizintal/scissor_viewmodel.dart';
import 'package:jason_company/ui/reports/%D8%AA%D9%82%D8%A7%D8%B1%D9%8A%D8%B1%20%D8%A7%D9%84%D9%85%D9%82%D8%B5%D8%A7%D8%AA/horizintal/pdfForScissors.dart';
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
        return Scaffold(
          appBar: AppBar(
            title: const Text(" تقارير المقصات الراسى"),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               
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
               
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        permission().then((value) async {
                          PdfForAllOfH.generate(1, myType.blocks, chosenDate)
                              .then((value) => context.gonext(
                                  context,
                                  PDfpreview(
                                    v: value.save(),
                                  )));
                        });
                      },
                      child: Container(
                        child: const Row(
                          children: [
                            Text("كل الراسى"),
                            Icon(Icons.picture_as_pdf),
                          ],
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        permission().then((value) async {
                          PdfForHscissor.generate(1, myType.blocks, chosenDate)
                              .then((value) => context.gonext(
                                  context,
                                  PDfpreview(
                                    v: value.save(),
                                  )));
                        });
                      },
                      child: const Row(
                        children: [
                          Text("الراسى الاول"),
                          Icon(Icons.picture_as_pdf),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        permission().then((value) async {
                          PdfForHscissor.generate(2, myType.blocks, chosenDate)
                              .then((value) => context.gonext(
                                  context,
                                  PDfpreview(
                                    v: value.save(),
                                  )));
                        });
                      },
                      child: const Row(
                        children: [
                          Text("الراسى الثانى"),
                          Icon(Icons.picture_as_pdf),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        permission().then((value) async {
                          PdfForHscissor.generate(3, myType.blocks, chosenDate)
                              .then((value) => context.gonext(
                                  context,
                                  PDfpreview(
                                    v: value.save(),
                                  )));
                        });
                      },
                      child: const Row(
                        children: [
                          Text("الراسى الثالث"),
                          Icon(Icons.picture_as_pdf),
                        ],
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
