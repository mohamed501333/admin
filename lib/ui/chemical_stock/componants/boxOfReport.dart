import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/ChemicalsController.dart';
import 'package:jason_company/controllers/dropDowen_controller.dart';
import 'package:jason_company/controllers/setting_controller.dart';

import 'package:provider/provider.dart';

class BoxOFReport extends StatelessWidget {
  BoxOFReport({super.key});
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'تقرير الكمية المتوفره فقط',
      'تقرير حركة المخزون',
      'تقرير الوارد فقط',
      'تقرير المنصرف فقط ',
      "تقرير الكميه الموشكة على الانتهاء"
    ];
    //value of report type

    return Container(
      height: MediaQuery.of(context).size.height * .25,
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
      child: Column(
        children: [
          //نوع التقرير
          Consumer<dropDowenContoller>(
            builder: (context, myType, child) {
              return DropdownButtonHideUnderline(
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
                    myType.Refrsh_ui();
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
              );
            },
          ),
          //العائلات والاصناف
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<Chemicals_controller>(
                builder: (context, myType, child) {
                  return DropdownButton2<String>(
                      isExpanded: true,
                      hint: Center(
                        child: Text(
                          'كل العائلات',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ),
                      items: myType.Chemicals.map((e) => e.family)
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
                                  myType.selctedFamilys.contains(item);
                              return InkWell(
                                onTap: () {
                                  isSelected
                                      ? myType.selctedFamilys.remove(item)
                                      : myType.selctedFamilys.add(item);
                                  myType.filterdedNames.clear();
                                  myType.filterdedNames = myType.Chemicals
                                          .filterItemsPasedOnFamilys(
                                              context, myType.selctedFamilys)
                                      .map((e) => e.name)
                                      .toSet()
                                      .toList();
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
                                      const SizedBox(width: 16),
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
                      value: myType.selctedFamilys.isEmpty
                          ? null
                          : myType.selctedFamilys.last,
                      onChanged: (value) {},
                      selectedItemBuilder: (context) {
                        return myType.Chemicals.map((e) => e.family)
                            .toSet()
                            .toList()
                            .map(
                          (item) {
                            return Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                myType.selctedFamilys.join(', '),
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
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        height: 50,
                        width: MediaQuery.of(context).size.width * .47,
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
                      ));
                },
              ),
              Consumer<Chemicals_controller>(
                builder: (context, myType, child) {
                  return DropdownButton2<String>(
                      isExpanded: true,
                      hint: Center(
                        child: Text(
                          'كل الاصناف',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ),
                      items: myType.filterdedNames.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          //disable default onTap to avoid closing menu when selecting an item
                          enabled: false,
                          child: StatefulBuilder(
                            builder: (context, menuSetState) {
                              final isSelected =
                                  myType.filterdedNames.contains(item);
                              return InkWell(
                                onTap: () {
                                  isSelected
                                      ? myType.filterdedNames.remove(item)
                                      : myType.filterdedNames.add(item);
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
                                      const SizedBox(width: 16),
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
                      value: myType.selctedNames.isEmpty
                          ? null
                          : myType.selctedNames.last,
                      onChanged: (value) {},
                      selectedItemBuilder: (context) {
                        return myType.filterdedNames.map(
                          (item) {
                            return Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                myType.selctedNames.join(', '),
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
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        height: 50,
                        width: MediaQuery.of(context).size.width * .47,
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
                      ));
                },
              )
            ].reversed.toList(),
          ),
          //التاريخ
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const DatepickerTo2(),
              context.read<dropDowenContoller>().selectedreport ==
                      'تقرير الكمية المتوفره فقط'
                  ? const SizedBox()
                  : const DatepickerFrom2(),
            ],
          ),
          //عرض
          // Padding(
          //   padding: const EdgeInsets.only(top: 9),
          //   child: GestureDetector(
          //     onTap: () {},
          //     child: Container(
          //       width: MediaQuery.of(context).size.width * .8,
          //       height: 60,
          //       decoration: BoxDecoration(
          //         gradient: LinearGradient(
          //           colors: [
          //             Colors.teal,
          //             Colors.teal.shade200,
          //           ],
          //           begin: Alignment.topLeft,
          //           end: Alignment.bottomRight,
          //         ),
          //         borderRadius: BorderRadius.circular(20),
          //         boxShadow: const [
          //           BoxShadow(
          //             color: Colors.black12,
          //             offset: Offset(5, 5),
          //             blurRadius: 10,
          //           )
          //         ],
          //       ),
          //       child: const Center(
          //         child: Text(
          //           'عرض',
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 30,
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class DateSetting extends StatelessWidget {
  DateSetting({
    super.key,
  });

  final List<String> items2 = [
    'حتى يوم',
    'خلال يوم',
    'خلال شهر',
    'خلال السنه',
    "خلال مده "
  ];
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DatepickerTo2(),
        DatepickerFrom2(),

        // Padding(
        //   padding: const EdgeInsets.only(top: 22),
        //   child: SizedBox(
        //     width: 100,
        //     height: 50,
        //     child: DropdownButtonFormField2<String>(
        //       decoration: const InputDecoration(
        //           label: Text("التاريخ"),
        //           contentPadding: EdgeInsets.symmetric(vertical: 16),
        //           border: OutlineInputBorder(),
        //           disabledBorder: OutlineInputBorder(
        //               borderSide: BorderSide(color: Colors.teal)),
        //           enabledBorder: OutlineInputBorder(
        //               borderSide:
        //                   BorderSide(width: 1.3, color: Colors.teal))),
        //       hint: const Text(
        //         'حتى اليوم',
        //         style: TextStyle(fontSize: 14),
        //       ),
        //       items: items2
        //           .map((item) => DropdownMenuItem<String>(
        //                 value: item,
        //                 child: Center(
        //                   child: Text(
        //                     item,
        //                     style: const TextStyle(
        //                       fontSize: 14,
        //                     ),
        //                   ),
        //                 ),
        //               ))
        //           .toList(),
        //       validator: (value) {
        //         if (value == null) {
        //           return 'Please select value.';
        //         }
        //         return null;
        //       },
        //       onChanged: (value) {
        //         //Do something when selected item is changed.
        //       },
        //       onSaved: (value) {},
        //       buttonStyleData: const ButtonStyleData(
        //         padding: EdgeInsets.only(right: 8),
        //       ),
        //       iconStyleData: const IconStyleData(
        //         icon: Icon(
        //           Icons.arrow_drop_down,
        //           color: Colors.black45,
        //         ),
        //         iconSize: 22,
        //       ),
        //       dropdownStyleData: DropdownStyleData(
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(15),
        //         ),
        //       ),
        //       menuItemStyleData: const MenuItemStyleData(
        //         padding: EdgeInsets.symmetric(horizontal: 2),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class DatepickerFrom2 extends StatelessWidget {
  const DatepickerFrom2({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SettingController>().from2 =
        context.read<Chemicals_controller>().firstDateOfData();
    return Consumer<SettingController>(
      builder: (context, myType, child) {
        return Column(
          children: [
            TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: myType.from2,
                      firstDate: context
                          .read<Chemicals_controller>()
                          .firstDateOfData(),
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    myType.from2 = pickedDate;
                    myType.Refresh_Ui();
                    context.read<Chemicals_controller>().Refresh_Ui();
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
                        myType.from2.formatt(),
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

class DatepickerTo2 extends StatelessWidget {
  const DatepickerTo2({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingController>(
      builder: (context, myType, child) {
        return Column(
          children: [
            TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: context.read<SettingController>().from2,
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    myType.to2 = pickedDate;
                    myType.Refresh_Ui();
                    context.read<Chemicals_controller>().Refresh_Ui();
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
                        myType.to2.formatt(),
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
