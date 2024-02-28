// ignore_for_file: camel_case_types

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/ChemicalsController.dart';
import 'package:jason_company/controllers/dropDowen_controller.dart';
import 'package:jason_company/controllers/setting_controller.dart';
import 'package:jason_company/ui/chemical_stock/comonantForOuting.dart';
import 'package:jason_company/ui/chemical_stock/componants.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/reports/%D8%A7%D9%84%D9%85%D8%B5%D8%B1%D9%88%D9%81%20%D9%85%D9%82%D8%A7%D8%A8%D9%84%20%D8%A7%D9%84%D8%A7%D9%86%D8%AA%D8%A7%D8%AC/Report10_viewMdel.dart';
import 'package:provider/provider.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class Test extends StatelessWidget {
  Test({super.key});
  final _verticalController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TableView.builder(
        verticalDetails:
            ScrollableDetails.vertical(controller: _verticalController),
        cellBuilder: (BuildContext context, TableVicinity vicinity) {
          return TableViewCell(
            child: Text('Tile c: ${vicinity.column}, r: ${vicinity.row}'),
          );
        },
        columnCount: 6,
        columnBuilder: (int index) {
          return TableSpan(
            foregroundDecoration: const TableSpanDecoration(
              border: TableSpanBorder(
                trailing: BorderSide(),
              ),
            ),
            extent: const FractionalTableSpanExtent(0.4),
            onEnter: (_) => print('Entered column $index'),
            cursor: SystemMouseCursors.forbidden,
          );
        },
        rowCount: 22,
        rowBuilder: (int index) {
          return TableSpan(
            onEnter: (_) => print('Entered column $index'),
            backgroundDecoration: const TableSpanDecoration(
              border: TableSpanBorder(
                trailing: BorderSide(
                  width: 1,
                ),
              ),
            ),
            extent: const FixedTableSpanExtent(33),
            cursor: SystemMouseCursors.click,
          );
        },
      ),
    );
  }
}

class Chemical_view extends StatelessWidget {
  Chemical_view({super.key});
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Chemicals_controller x = context.read<Chemicals_controller>();

    List<String> familys = x.Chemicals.map((e) => e.family).toSet().toList();

    List<String> selctedFamilys = x.selctedFamilys.toSet().toList();

    List<String> selctedNames = x.selctedNames.toSet().toList();
    final List<String> items = [
      'تقرير الكمية المتوفره فقط',
      'تقرير حركة المخزون',
      'تقرير الوارد فقط',
      'تقرير المنصرف فقط ',
      "تقرير الكميه الموشكة على الانتهاء"
    ];
    String? selectedValue;
    final List<String> items2 = [
      'حتى يوم',
      'خلال يوم',
      'خلال شهر',
      'خلال السنه',
      "خلال مده "
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                context.gonext(context, CreateChemicalCategory());
              },
              child: const Text(
                "تكويد اصناف",
                style: TextStyle(color: Color.fromARGB(255, 156, 0, 0)),
              )).permition(context, UserPermition.show_Chemical_category),
          TextButton(
              onPressed: () {
                context.gonext(context, Suplying());
              },
              child: const Text(
                "توريد",
                style: TextStyle(color: Color.fromARGB(255, 156, 0, 0)),
              )),
          TextButton(
              onPressed: () {},
              child: const Text(
                "صرف",
                style: TextStyle(color: Color.fromARGB(255, 156, 0, 0)),
              ))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * .35,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.teal),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
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
                    value: selectedValue,
                    onChanged: (String? value) {
                      selectedValue = value;
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
                        items: familys.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            //disable default onTap to avoid closing menu when selecting an item
                            enabled: false,
                            child: StatefulBuilder(
                              builder: (context, menuSetState) {
                                final isSelected =
                                    selctedFamilys.contains(item);
                                return InkWell(
                                  onTap: () {
                                    isSelected
                                        ? selctedFamilys.remove(item)
                                        : selctedFamilys.add(item);
                                    x.filterdedNames.clear();
                                    x.filterdedNames =
                                        x.Chemicals.filterItemsPasedOnFamilys(
                                                context, selctedFamilys)
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
                        value:
                            selctedFamilys.isEmpty ? null : selctedFamilys.last,
                        onChanged: (value) {},
                        selectedItemBuilder: (context) {
                          return familys.map(
                            (item) {
                              return Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  selctedFamilys.join(', '),
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
                                final isSelected = selctedNames.contains(item);
                                return InkWell(
                                  onTap: () {
                                    isSelected
                                        ? selctedNames.remove(item)
                                        : selctedNames.add(item);
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
                        value: selctedNames.isEmpty ? null : selctedNames.last,
                        onChanged: (value) {},
                        selectedItemBuilder: (context) {
                          return myType.filterdedNames.map(
                            (item) {
                              return Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  selctedNames.join(', '),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const DatepickerTo2(),
                const DatepickerFrom2(),
                Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: SizedBox(
                    width: 100,
                    height: 50,
                    child: DropdownButtonFormField2<String>(
                      decoration: const InputDecoration(
                          label: Text("التاريخ"),
                          contentPadding: EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1.3, color: Colors.teal))),
                      hint: const Text(
                        'حتى اليوم',
                        style: TextStyle(fontSize: 14),
                      ),
                      items: items2
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Center(
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select gender.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        //Do something when selected item is changed.
                      },
                      onSaved: (value) {},
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 22,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 9),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width * .8,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.teal,
                        Colors.teal.shade200,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(5, 5),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'عرض',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DatepickerFrom2 extends StatefulWidget {
  const DatepickerFrom2({super.key});

  @override
  State<DatepickerFrom2> createState() => _DatepickerState();
}

class _DatepickerState extends State<DatepickerFrom2> {
  Rscissor_viewmodel vm = Rscissor_viewmodel();

  @override
  Widget build(BuildContext context) {
    var vm2 = context.read<SettingController>();
    return Column(
      children: [
        TextButton(
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now());

              if (pickedDate != null) {
                setState(() {
                  context.read<SettingController>().from = pickedDate;
                  context.read<SettingController>().Refresh_Ui();
                });
              } else {}
            },
            child: Column(
              children: [
                const Text(
                  "من",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.teal),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    vm2.from.formatt(),
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
  }
}

class DatepickerTo2 extends StatefulWidget {
  const DatepickerTo2({super.key});

  @override
  State<DatepickerTo2> createState() => _DatepickerStatef();
}

class _DatepickerStatef extends State<DatepickerTo2> {
  Rscissor_viewmodel vm = Rscissor_viewmodel();
  @override
  Widget build(BuildContext context) {
    var vm2 = context.read<SettingController>();

    return Column(
      children: [
        TextButton(
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: context.read<SettingController>().from,
                  lastDate: DateTime(2101));

              if (pickedDate != null) {
                setState(() {
                  context.read<SettingController>().to = pickedDate;
                  context.read<SettingController>().Refresh_Ui();
                });
              } else {}
            },
            child: Column(
              children: [
                const Text(
                  "الى",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.teal),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    vm2.to.formatt(),
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
  }
}
