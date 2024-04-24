// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/reports/%D8%AA%D9%82%D8%A7%D8%B1%D9%8A%D8%B1%20%D9%85%D9%86%D8%AA%D8%AC%20%D8%AA%D8%A7%D9%85/finalprodcutreprotsviewModel.dart';
import 'package:provider/provider.dart';

class FinalprodcutsReportsView extends StatelessWidget {
  const FinalprodcutsReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BoxOFReportForfinalProdcutsReport(),
            Consumer<final_prodcut_controller>(
              builder: (context, myType, child) {
                return Column(
                  children: [
            
                    
                    if (myType.selectedreport == 'تقرير المنصرف فقط')
                      const FinalprodcutReport1(),
                    if (myType.selectedreport == 'تقرير الوارد فقط')
                      const FinalprodcutReport2(),
                    if (myType.selectedreport == 'الكميه المتوفره فقط')
                      const FinalprodcutReport3()
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FinalprodcutReport1 extends StatelessWidget {
  const FinalprodcutReport1({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, finalprodcuts, child) {
        List<FinalProductModel> finalproductsBetweenTowDates = finalprodcuts
            .finalproducts
            .filterFinalProduct_out_DateBetween(
                finalprodcuts.pickedDateFrom!, finalprodcuts.pickedDateTo!)
            .filterItemsPasedOncolors(context, finalprodcuts.selctedcolors)
            .filterItemsPasedOnDensites(context, finalprodcuts.selctedDensities)
            .filterItemsPasedOntypes(context, finalprodcuts.selctedtybes)
            .filterItemsPasedOnCustomers(
                context, finalprodcuts.selctedcustomers)
            .filterItemsPasedOnsizes(context, finalprodcuts.selctedsizes);
        return SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Table(
                border: TableBorder.all(),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: const [
                  TableRow(
                      decoration: BoxDecoration(color: Colors.grey),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("اجمالى المصروف  "),
                          ],
                        ),
                      ]),
                ],
              ),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(1),
                },
                border: TableBorder.all(),
                children: const [
                  TableRow(children: [
                    Center(
                      child: Text("من"),
                    ),
                    Center(
                      child: Text("عدد"),
                    )
                  ]),
                ],
              ),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(1),
                },
                border: TableBorder.all(),
                children: finalproductsBetweenTowDates
                    .filteronfinalproduct()
                    .sortedBy<num>((element) => element.item.density)
                    .map((e) => TableRow(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  textDirection: TextDirection.rtl,
                                  "      ${e.item.color} ${e.item.type} ك ${e.item.density.removeTrailingZeros}"),
                              Text(
                                  textDirection: TextDirection.rtl,
                                  "${e.item.L.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.H.removeTrailingZeros}"),
                            ],
                          ),
                          Center(
                            child: Text(
                              finalproductsBetweenTowDates
                                  .countOf(e)
                                  .toString(),
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ]))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class FinalprodcutReport2 extends StatelessWidget {
  const FinalprodcutReport2({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, finalprodcuts, child) {
        List<FinalProductModel> finalproductsBetweenTowDates = finalprodcuts
            .finalproducts
            .filterFinalProduct_IN_DateBetween(
                finalprodcuts.pickedDateFrom!, finalprodcuts.pickedDateTo!)
            .filterItemsPasedOncolors(context, finalprodcuts.selctedcolors)
            .filterItemsPasedOnDensites(context, finalprodcuts.selctedDensities)
            .filterItemsPasedOntypes(context, finalprodcuts.selctedtybes)
            .filterItemsPasedOnCustomers(
                context, finalprodcuts.selctedcustomers)
            .filterItemsPasedOnsizes(context, finalprodcuts.selctedsizes);
        return SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Table(
                border: TableBorder.all(),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: const [
                  TableRow(
                      decoration: BoxDecoration(color: Colors.grey),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("اجمالى الوارد  "),
                          ],
                        ),
                      ]),
                ],
              ),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(1),
                },
                border: TableBorder.all(),
                children: const [
                  TableRow(children: [
                    Center(
                      child: Text("من"),
                    ),
                    Center(
                      child: Text("عدد"),
                    )
                  ]),
                ],
              ),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(1),
                },
                border: TableBorder.all(),
                children: finalproductsBetweenTowDates
                    .filteronfinalproduct()
                    .sortedBy<num>((element) => element.item.density)
                    .map((e) => TableRow(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  textDirection: TextDirection.rtl,
                                  "      ${e.item.color} ${e.item.type} ك ${e.item.density.removeTrailingZeros}"),
                              Text(
                                  textDirection: TextDirection.rtl,
                                  "${e.item.L.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.H.removeTrailingZeros}"),
                            ],
                          ),
                          Center(
                            child: Text(
                              finalproductsBetweenTowDates
                                  .countOf(e)
                                  .toString(),
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 11, 134, 0)),
                            ),
                          ),
                        ]))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class FinalprodcutReport3 extends StatelessWidget {
  const FinalprodcutReport3({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, finalprodcuts, child) {
        List<FinalProductModel> finalproductsBetweenTowDates = finalprodcuts
            .finalproducts
            .data_until_date(finalprodcuts.pickedDateTo!)
            .filterItemsPasedOncolors(context, finalprodcuts.selctedcolors)
            .filterItemsPasedOnDensites(context, finalprodcuts.selctedDensities)
            .filterItemsPasedOntypes(context, finalprodcuts.selctedtybes)
            .filterItemsPasedOnCustomers(
                context, finalprodcuts.selctedcustomers)
            .filterItemsPasedOnsizes(context, finalprodcuts.selctedsizes);
        return SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Table(
                border: TableBorder.all(),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: const [
                  TableRow(
                      decoration: BoxDecoration(color: Colors.grey),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("الكميه المتوفره فقط "),
                          ],
                        ),
                      ]),
                ],
              ),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(1),
                },
                border: TableBorder.all(),
                children: const [
                  TableRow(children: [
                    Center(
                      child: Text("من"),
                    ),
                    Center(
                      child: Text("عدد"),
                    )
                  ]),
                ],
              ),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(1),
                },
                border: TableBorder.all(),
                children: finalproductsBetweenTowDates
                        .ReturnItmeWithTotalAndRemovewhreTotalZeto()
                    .sortedBy<num>((element) => element.density)
                    .map((e) => TableRow(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  textDirection: TextDirection.rtl,
                                  "      ${e.color} ${e.type} ك ${e.density.removeTrailingZeros}"),
                              Text(
                                  textDirection: TextDirection.rtl,
                                  "${e.L.removeTrailingZeros}*${e.W.removeTrailingZeros}*${e.H.removeTrailingZeros}"),
                            ],
                          ),
                          Center(
                            child: Text(
                              e.amount.toString(),
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 11, 134, 0)),
                            ),
                          ),
                        ]))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BoxOFReportForfinalProdcutsReport extends StatelessWidget {
  BoxOFReportForfinalProdcutsReport({super.key});
  final TextEditingController textEditingController = TextEditingController();
  FinalProdcutsViewModel vm = FinalProdcutsViewModel();

  @override
  Widget build(BuildContext context) {
    context.read<final_prodcut_controller>().pickedDateFrom = DateTime.now();
    context.read<final_prodcut_controller>().pickedDateTo = DateTime.now();
    final List<String> items = [
      'الكميه المتوفره فقط',
      'تقرير حركة المخزون ',
      'تقرير الوارد فقط',
      'تقرير المنصرف فقط',
    ];
    //value of report type

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
      child: Consumer<final_prodcut_controller>(
        builder: (context, myType, child) {
          List<FinalProductModel> f = [];
                  
                  if (myType.selectedreport =='الكميه المتوفره فقط') {
                    f=myType.finalproducts
            .data_until_date(myType.pickedDateTo!)
            .filterItemsPasedOncolors(context, myType.selctedcolors)
            .filterItemsPasedOnDensites(context, myType.selctedDensities)
            .filterItemsPasedOntypes(context, myType.selctedtybes)
            .filterItemsPasedOnCustomers(
                context, myType.selctedcustomers)
            .filterItemsPasedOnsizes(context, myType.selctedsizes);;
                  }
                  if (myType.selectedreport =='تقرير الوارد فقط') {
                    f=myType.finalproducts
            .filterFinalProduct_IN_DateBetween(
                myType.pickedDateFrom!, myType.pickedDateTo!)
            .filterItemsPasedOncolors(context, myType.selctedcolors)
            .filterItemsPasedOnDensites(context, myType.selctedDensities)
            .filterItemsPasedOntypes(context, myType.selctedtybes)
            .filterItemsPasedOnCustomers(
                context, myType.selctedcustomers)
            .filterItemsPasedOnsizes(context, myType.selctedsizes);
                  }
                  if (myType.selectedreport =='تقرير المنصرف فقط') {
                    f= myType.finalproducts
            .filterFinalProduct_out_DateBetween(
                myType.pickedDateFrom!, myType.pickedDateTo!)
            .filterItemsPasedOncolors(context, myType.selctedcolors)
            .filterItemsPasedOnDensites(context, myType.selctedDensities)
            .filterItemsPasedOntypes(context, myType.selctedtybes)
            .filterItemsPasedOnCustomers(
                context, myType.selctedcustomers)
            .filterItemsPasedOnsizes(context, myType.selctedsizes);
                  }

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
                  value: myType.selectedreport,
                  onChanged: (String? value) {
                    myType.selectedreport = value;
                    myType.Refresh_Ui();
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
              
              Row(
                children: [
                  DropdownButton2<String>(
                      isExpanded: true,
                      hint: Center(
                        child: Text(
                          'كل الالوان',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ),
                      items: f
                          .map((e) => e.item.color)
                          .toSet()
                          .toList()
                          .map((item) {
                        return DropdownMenuItem(
                          value: item,
                          //disable default onTap to avoid closing menu when selecting an item
                          enabled: false,
                          child: StatefulBuilder(
                            builder: (context, menuSetState) {
                              final isSelected =
                                  myType.selctedcolors.contains(item);
                              return InkWell(
                                onTap: () {
                                  isSelected
                                      ? myType.selctedcolors.remove(item)
                                      : myType.selctedcolors.add(item);

                                  //This rebuilds the StatefulWidget to update the button's text
                                  myType.Refresh_Ui();
                                  //This rebuilds the dropdownMenu Widget to update the check mark
                                  menuSetState(() {});
                                },
                                child: Container(
                                  height: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      if (isSelected)
                                        const Icon(Icons.check_box_outlined)
                                      else
                                        const Icon(
                                            Icons.check_box_outline_blank),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                      //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                      value: myType.selctedcolors.isEmpty
                          ? null
                          : myType.selctedcolors.last,
                      onChanged: (value) {},
                      selectedItemBuilder: (context) {
                        return f.map((e) => e.item.color).toSet().toList().map(
                          (item) {
                            return Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                myType.selctedcolors.join(', '),
                                style: const TextStyle(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            );
                          },
                        ).toList();
                      },
                      buttonStyleData: ButtonStyleData(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            color: const Color.fromARGB(255, 204, 225, 241)),
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        height: 50,
                        width: MediaQuery.of(context).size.width * .3,
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        maxHeight: 200,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.zero,
                      ),
                      dropdownSearchData: DropdownSearchData(
                        searchController: textEditingController,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: Container(
                          height: 50,
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 4,
                            right: 8,
                            left: 8,
                          ),
                          child: TextFormField(
                            expands: true,
                            maxLines: null,
                            controller: textEditingController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'Search for an item...',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return item.value.toString().contains(searchValue);
                        },
                      )),
                  DropdownButton2<String>(
                      isExpanded: true,
                      hint: Center(
                        child: Text(
                          'كل الانواع',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ),
                      items: f
                          .map((e) => e.item.type)
                          .toSet()
                          .toList()
                          .map((item) {
                        return DropdownMenuItem(
                          value: item,
                          //disable default onTap to avoid closing menu when selecting an item
                          enabled: false,
                          child: StatefulBuilder(
                            builder: (context, menuSetState) {
                              final isSelected =
                                  myType.selctedtybes.contains(item);
                              return InkWell(
                                onTap: () {
                                  isSelected
                                      ? myType.selctedtybes.remove(item)
                                      : myType.selctedtybes.add(item);

                                  //This rebuilds the StatefulWidget to update the button's text
                                  myType.Refresh_Ui();
                                  //This rebuilds the dropdownMenu Widget to update the check mark
                                  menuSetState(() {});
                                },
                                child: Container(
                                  height: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      if (isSelected)
                                        const Icon(Icons.check_box_outlined)
                                      else
                                        const Icon(
                                            Icons.check_box_outline_blank),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                      //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                      value: myType.selctedtybes.isEmpty
                          ? null
                          : myType.selctedtybes.last,
                      onChanged: (value) {},
                      selectedItemBuilder: (context) {
                        return f.toSet().toList().map(
                          (item) {
                            return Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                myType.selctedtybes.join(', '),
                                style: const TextStyle(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            );
                          },
                        ).toList();
                      },
                      buttonStyleData: ButtonStyleData(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            color: const Color.fromARGB(255, 204, 225, 241)),
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        height: 50,
                        width: MediaQuery.of(context).size.width * .3,
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        maxHeight: 200,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.zero,
                      ),
                      dropdownSearchData: DropdownSearchData(
                        searchController: textEditingController,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: Container(
                          height: 50,
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 4,
                            right: 8,
                            left: 8,
                          ),
                          child: TextFormField(
                            expands: true,
                            maxLines: null,
                            controller: textEditingController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'Search for an item...',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return item.value.toString().contains(searchValue);
                        },
                      )),
                  //كل الكثافات
                  DropdownButton2<String>(
                      isExpanded: true,
                      hint: Center(
                        child: Text(
                          'كل الكثافات',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ),
                      items: f
                          .map((e) => e.item.density.toString())
                          .toSet()
                          .toList()
                          .sortedBy((element) => element)
                          .map((item) {
                        return DropdownMenuItem(
                          value: item,
                          //disable default onTap to avoid closing menu when selecting an item
                          enabled: false,
                          child: StatefulBuilder(
                            builder: (context, menuSetState) {
                              final isSelected =
                                  myType.selctedDensities.contains(item);
                              return InkWell(
                                onTap: () {
                                  isSelected
                                      ? myType.selctedDensities.remove(item)
                                      : myType.selctedDensities.add(item);

                                  //This rebuilds the StatefulWidget to update the button's text
                                  myType.Refresh_Ui();
                                  //This rebuilds the dropdownMenu Widget to update the check mark
                                  menuSetState(() {});
                                },
                                child: Container(
                                  height: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      if (isSelected)
                                        const Icon(Icons.check_box_outlined)
                                      else
                                        const Icon(
                                            Icons.check_box_outline_blank),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                      //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                      value: myType.selctedDensities.isEmpty
                          ? null
                          : myType.selctedDensities.last,
                      onChanged: (value) {},
                      selectedItemBuilder: (context) {
                        return f
                            .map((e) => e.item.density)
                            .toSet()
                            .toList()
                            .map(
                          (item) {
                            return Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                myType.selctedDensities.join(', '),
                                style: const TextStyle(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            );
                          },
                        ).toList();
                      },
                      buttonStyleData: ButtonStyleData(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            color: const Color.fromARGB(255, 204, 225, 241)),
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        height: 50,
                        width: MediaQuery.of(context).size.width * .33,
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        maxHeight: 200,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.zero,
                      ),
                      dropdownSearchData: DropdownSearchData(
                        searchController: textEditingController,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: Container(
                          height: 50,
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 4,
                            right: 8,
                            left: 8,
                          ),
                          child: TextFormField(
                            expands: true,
                            maxLines: null,
                            controller: textEditingController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'Search for an item...',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return item.value.toString().contains(searchValue);
                        },
                      )),
                ],
              ),
            
              Row(
                children: [
                  DropdownButton2<String>(
                      isExpanded: true,
                      hint: Center(
                        child: Text(
                          'كل العملاء',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ),
                      items: f
                          .map((e) => e.customer.customername(context))
                          .toSet()
                          .toList()
                          .map((item) {
                        return DropdownMenuItem(
                          value: item,
                          //disable default onTap to avoid closing menu when selecting an item
                          enabled: false,
                          child: StatefulBuilder(
                            builder: (context, menuSetState) {
                              final isSelected =
                                  myType.selctedcustomers.contains(item);
                              return InkWell(
                                onTap: () {
                                  isSelected
                                      ? myType.selctedcustomers.remove(item)
                                      : myType.selctedcustomers.add(item);

                                  //This rebuilds the StatefulWidget to update the button's text
                                  myType.Refresh_Ui();
                                  //This rebuilds the dropdownMenu Widget to update the check mark
                                  menuSetState(() {});
                                },
                                child: Container(
                                  height: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      if (isSelected)
                                        const Icon(Icons.check_box_outlined)
                                      else
                                        const Icon(
                                            Icons.check_box_outline_blank),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                      //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                      value: myType.selctedcustomers.isEmpty
                          ? null
                          : myType.selctedcustomers.last,
                      onChanged: (value) {},
                      selectedItemBuilder: (context) {
                        return f.toSet().toList().map(
                          (item) {
                            return Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                myType.selctedcustomers.join(', '),
                                style: const TextStyle(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            );
                          },
                        ).toList();
                      },
                      buttonStyleData: ButtonStyleData(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            color: const Color.fromARGB(255, 204, 225, 241)),
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        height: 50,
                        width: MediaQuery.of(context).size.width * .5,
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        maxHeight: 200,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.zero,
                      ),
                      dropdownSearchData: DropdownSearchData(
                        searchController: textEditingController,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: Container(
                          height: 50,
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 4,
                            right: 8,
                            left: 8,
                          ),
                          child: TextFormField(
                            expands: true,
                            maxLines: null,
                            controller: textEditingController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'Search for an item...',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return item.value.toString().contains(searchValue);
                        },
                      )),
                  DropdownButton2<String>(
                      isExpanded: true,
                      hint: Center(
                        child: Text(
                          'كل المقاسات',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ),
                      items: f
                          .map((e) =>
                              "${e.item.L.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.H.removeTrailingZeros}")
                          .toSet()
                          .toList()
                          .sortedBy((element) => element)
                          .map((item) {
                        return DropdownMenuItem(
                          value: item,
                          //disable default onTap to avoid closing menu when selecting an item
                          enabled: false,
                          child: StatefulBuilder(
                            builder: (context, menuSetState) {
                              final isSelected =
                                  myType.selctedsizes.contains(item);
                              return InkWell(
                                onTap: () {
                                  isSelected
                                      ? myType.selctedsizes.remove(item)
                                      : myType.selctedsizes.add(item);

                                  //This rebuilds the StatefulWidget to update the button's text
                                  myType.Refresh_Ui();
                                  //This rebuilds the dropdownMenu Widget to update the check mark
                                  menuSetState(() {});
                                },
                                child: Container(
                                  height: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      if (isSelected)
                                        const Icon(Icons.check_box_outlined)
                                      else
                                        const Icon(
                                            Icons.check_box_outline_blank),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                      //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                      value: myType.selctedsizes.isEmpty
                          ? null
                          : myType.selctedsizes.last,
                      onChanged: (value) {},
                      selectedItemBuilder: (context) {
                        return f
                            .map((e) =>
                                "${e.item.L.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.H.removeTrailingZeros}")
                            .toSet()
                            .toList()
                            .map(
                          (item) {
                            return Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                myType.selctedsizes.join(', '),
                                style: const TextStyle(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            );
                          },
                        ).toList();
                      },
                      buttonStyleData: ButtonStyleData(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            color: const Color.fromARGB(255, 204, 225, 241)),
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        height: 50,
                        width: MediaQuery.of(context).size.width * .4,
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        maxHeight: 200,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.zero,
                      ),
                      dropdownSearchData: DropdownSearchData(
                        searchController: textEditingController,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: Container(
                          height: 50,
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 4,
                            right: 8,
                            left: 8,
                          ),
                          child: TextFormField(
                            expands: true,
                            maxLines: null,
                            controller: textEditingController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'Search for an item...',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return item.value
                              .toString()
                              .replaceAll(RegExp('[^0-9]'), '')
                              .contains(searchValue);
                        },
                      )),
                ],
              ),
              //التاريخ
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const DatepickerTo4(),
                  if (myType.selectedreport != 'الكميه المتوفره فقط')
                    const DatepickerFrom4(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class DatepickerFrom4 extends StatelessWidget {
  const DatepickerFrom4({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<final_prodcut_controller>().pickedDateFrom = DateTime.now();
    return Consumer<final_prodcut_controller>(
      builder: (context, myType, child) {
        return Column(
          children: [
            TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: myType.pickedDateFrom,
                      firstDate: myType.AllDatesOfOfData().min,
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    myType.pickedDateFrom = pickedDate;
                    myType.Refresh_Ui();
                  } else {}
                },
                child: Column(
                  children: [
                    const Text(
                      "من",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.teal),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        myType.pickedDateFrom!.formatt(),
                        style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 97, 92, 92),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }
}

class DatepickerTo4 extends StatelessWidget {
  const DatepickerTo4({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<final_prodcut_controller>().pickedDateFrom = DateTime.now();

    context.read<final_prodcut_controller>().pickedDateTo = DateTime.now();
    return Consumer<final_prodcut_controller>(
      builder: (context, myType, child) {
        if (myType.pickedDateFrom!.microsecondsSinceEpoch >
            myType.pickedDateTo!.microsecondsSinceEpoch) {
          myType.pickedDateTo = myType.pickedDateFrom;
        }
        return Column(
          children: [
            TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: myType.pickedDateTo!,
                      firstDate: myType.pickedDateFrom!,
                      lastDate: myType.AllDatesOfOfData().max);

                  if (pickedDate != null) {
                    myType.pickedDateTo = pickedDate;
                    myType.Refresh_Ui();
                  } else {}
                },
                child: Column(
                  children: [
                    const Text(
                      "الى",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.teal),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        myType.pickedDateTo!.formatt(),
                        style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 97, 92, 92),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }
}
