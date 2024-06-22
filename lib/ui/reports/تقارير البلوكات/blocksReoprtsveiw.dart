import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/ui/commen/errmsg.dart';
import 'package:jason_company/ui/recources/userpermitions.dart';
import 'package:provider/provider.dart';

import 'اجماليات/Bolck_reports_view.dart';
import 'تفاصيل مقاسات/sizes_details.dart';
import 'تقرير اضافات البلوكات/blockReport2.dart';

class BlocksReports extends StatelessWidget {
  const BlocksReports({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          BoxOfTypesOfReportsForBlocks(),
          Expanded(
            child: LayoutBuilder(builder: (context, consrain) {
              return SingleChildScrollView(
                child: Consumer<BlockFirebasecontroller>(
                  builder: (context, myType, child) {
                    return ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: consrain.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            errmsg(),
                            switch (myType.selectedReport) {
                              'الكميه المتوفره اجماليات' => const BlockReportsView().permition(context,  UserPermition.show_Reports_totals_of_blocks),
                              'الكميه المتوفره مقاسات' => BlocksSizesDetials(),
                              'اضافات البلوكات' => const BlockReport3().permition(context,  UserPermition.show_Reports_every_serial),
                              _ => const SizedBox(),
                            }
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class BoxOfTypesOfReportsForBlocks extends StatelessWidget {
  BoxOfTypesOfReportsForBlocks({super.key});
  final List<String> items = [
    'اضافات البلوكات',
    // 'تقرير الصرف',
    'الكميه المتوفره مقاسات',
    'الكميه المتوفره اجماليات',
    // 'الكميه المتوفره صبات',
    // 'الصبات المنتهيه'
    // الارشيف
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .33,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 204, 241, 252),
              Color.fromARGB(255, 202, 243, 239),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border.all(width: 2, color: Colors.teal),
          borderRadius: BorderRadius.circular(5)),
      child: Consumer<BlockFirebasecontroller>(
        builder: (context, myType, child) {
          return Column(
            children: [
              //نوع التقرير
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: const Center(
                    child: Text(
                      'نوع التقرير',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  items: items
                      .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ))
                      .toList(),
                  value: myType.selectedReport,
                  onChanged: (String? value) {
                    myType.selectedReport = value;
                    myType.Refresh_the_UI();
                  },
                  buttonStyleData: ButtonStyleData(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 50,
                    width: MediaQuery.of(context).size.width * .8,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                ),
              ),

              //التاريخ
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     const DatepickerTo4(),
              //     if (myType.selectedreport != 'الكميه المتوفره فقط')
              //       const DatepickerFrom4(),
              //   ],
              // ),
            ],
          );
        },
      ),
    );
  }
}
