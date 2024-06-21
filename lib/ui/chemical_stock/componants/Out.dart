//صفحة الصرف
// ignore_for_file: must_be_immutable, file_names

import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/ChemicalsController.dart';
import 'package:jason_company/main.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/chemical_stock/ChemicalStock_viewModel.dart';
import 'package:jason_company/ui/commen/errmsg.dart';
import 'package:jason_company/ui/commen/textformfield.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

class Outing extends StatelessWidget {
  Outing({super.key});
  ChemicalStockViewModel vm = ChemicalStockViewModel();

  @override
  Widget build(BuildContext context) {
    return Consumer<Chemicals_controller>(
      builder: (context, myType, child) {
        vm.OutingNum.text = myType.Chemicals.isNotEmpty
            ? (myType.Chemicals.sortedBy<num>(
                            (element) => element.StockRequisitionNum)
                        .last
                        .StockRequisitionNum +
                    1)
                .toString()
            : 1.toString();

        return Scaffold(
          appBar: AppBar(
            title: const Text("امر صرف مخزنى"),
          ),
          body: Column(
            children: [   errmsg() ,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropForCustomer(
                    items: myType.ChemicalCategorys.where(
                        (e) => e.OutTo.isNotEmpty).map((e) => e.OutTo).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: SizedBox(
                      child: CustomTextFormField(
                          hint: "رقم الصرف",
                          width: MediaQuery.of(context).size.width * .27,
                          controller: vm.OutingNum),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      DropForFamily(
                        items:
                            myType.Chemicals.where((e) => e.family.isNotEmpty)
                                .map((e) => e.family)
                                .toList(),
                      ),
                      const Text("العائله"),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      DropForItme(
                        items: myType.Chemicals.where((e) => e.name.isNotEmpty)
                            .map((e) => e.name)
                            .toList(),
                      ),
                      const Text("صنف")
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 11),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomTextFormField(
                        hint: "العدد",
                        width: MediaQuery.of(context).size.width * .2,
                        controller: vm.quantity),
                    DropForunit(
                      items: myType.ChemicalCategorys.where((e) => e.unit.isNotEmpty)
                          .map((e) => e.unit)
                          .toList(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                    keybordtupe: TextInputType.name,
                    hint: "ملاحظات",
                    width: MediaQuery.of(context).size.width * .7,
                    controller: vm.notess),
              ),
              ElevatedButton(
                  onPressed: () {
                    vm.OutNewChemical(context);
                    myType.makeNull();
                    myType.Refresh_Ui();
                  },
                  child: const Text("صرف")),
              ChemicaTableForSupplying(),
            ],
          ),
        );
      },
    );
  }
}

// hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
class DropForCustomer extends StatefulWidget {
  const DropForCustomer({super.key, required this.items});
  final List<String> items;

  @override
  State<DropForCustomer> createState() => _DroStatepp();
}

class _DroStatepp extends State<DropForCustomer> {
  String? selectedValue;

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? selectedValue =
        context.read<Chemicals_controller>().selectedValueForcustomer;
    widget.items.isEmpty
        ? context.read<Chemicals_controller>().selectedValueForcustomer = null
        : DoNothingAction();
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          selectedValue == null ? 'اختر العميل' : selectedValue.toString(),
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: widget.items
            .toSet()
            .toList()
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            context.read<Chemicals_controller>().selectedValueForcustomer =
                value;
          });
        },
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 40,
          width: 200,
        ),
        dropdownStyleData: const DropdownStyleData(
          maxHeight: 200,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
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
                hintText: '  ... البحث عن عميل',
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
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    );
  }
}

// hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
class DropForFamily extends StatefulWidget {
  const DropForFamily({super.key, required this.items});
  final List<String> items;

  @override
  State<DropForFamily> createState() => _DroStatee();
}

class _DroStatee extends State<DropForFamily> {
  String? selectedValue;

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? selectedValue =
        context.read<Chemicals_controller>().selectedValueForFamily;
    widget.items.isEmpty
        ? context.read<Chemicals_controller>().selectedValueForFamily = null
        : DoNothingAction();
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            const Icon(
              Icons.list,
              size: 16,
              color: Colors.yellow,
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                selectedValue == null
                    ? 'اختر العائله'
                    : selectedValue.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items.toSet().toList()
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            context.read<Chemicals_controller>().selectedValueForFamily = value;
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: MediaQuery.of(context).size.width * .8,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Colors.redAccent,
          ),
          elevation: 2,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.yellow,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: MediaQuery.of(context).size.width * .8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.redAccent,
          ),
          offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
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
                hintText: '  ... البحث عن عائله',
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
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    );
  }
}

// hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
class DropForunit extends StatefulWidget {
  const DropForunit({super.key, required this.items});
  final List<String> items;

  @override
  State<DropForunit> createState() => _DroStatev();
}

class _DroStatev extends State<DropForunit> {
  String? selectedValue;

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? selectedValue =
        context.read<Chemicals_controller>().selectedValueForUnit;
    if (widget.items.isEmpty) {
      context.read<Chemicals_controller>().selectedValueForUnit = null;
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            const Icon(
              Icons.list,
              size: 16,
              color: Colors.yellow,
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                selectedValue == null ? 'اختر وحده' : selectedValue.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items.toSet().toList()
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            context.read<Chemicals_controller>().selectedValueForUnit = value;
          });
        },

        buttonStyleData: ButtonStyleData(
          height: 50,
          width: 160,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Colors.redAccent,
          ),
          elevation: 2,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.yellow,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.redAccent,
          ),
          offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),

        // buttonStyleData: const ButtonStyleData(
        //   padding: EdgeInsets.symmetric(horizontal: 16),
        //   height: 40,
        //   width: 200,
        // ),
        // dropdownStyleData: const DropdownStyleData(
        //   maxHeight: 200,
        // ),
        // menuItemStyleData: const MenuItemStyleData(
        //   height: 40,
        // ),
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
                hintText: '  ... البحث عن وحده',
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
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    );
  }
}

// hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
class DropForItme extends StatefulWidget {
  const DropForItme({super.key, required this.items});
  final List<String> items;

  @override
  State<DropForItme> createState() => _DroStatevcv();
}

class _DroStatevcv extends State<DropForItme> {
  String? selectedValue;

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? selectedValue =
        context.read<Chemicals_controller>().selectedValueForItem;
    widget.items.isEmpty
        ? context.read<Chemicals_controller>().selectedValueForItem = null
        : DoNothingAction();
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            const Icon(
              Icons.list,
              size: 16,
              color: Colors.yellow,
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                selectedValue == null ? 'اختر صنف' : selectedValue.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            context.read<Chemicals_controller>().selectedValueForItem = value;
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: MediaQuery.of(context).size.width * .8,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Colors.redAccent,
          ),
          elevation: 2,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.yellow,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: MediaQuery.of(context).size.width * .8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.redAccent,
          ),
          offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
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
                hintText: '  ... البحث عن صنف',
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
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    );
  }
}

//جدول عرض فى الموردين
class ChemicaTableForSupplying extends StatefulWidget {
  ChemicaTableForSupplying({super.key});

  @override
  State<ChemicaTableForSupplying> createState() =>
      _ChemicaTableForSupplyingState();
}

class _ChemicaTableForSupplyingState extends State<ChemicaTableForSupplying> {
  ChemicalStockViewModel vm = ChemicalStockViewModel();
  String chosenDate = format.format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    List<ChemicalsModel> Chemicals = context
        .read<Chemicals_controller>()
        .Chemicals.sortedBy<num>((element) => element.supplyOrderNum).reversed.toList()
        .where((element) =>
            element.StockRequisitionNum != 0 &&
            element.actions
                    .get_Date_of_action(
                        ChemicalAction.creat_Out_ChemicalAction_item.getTitle)
                    .formatt() ==
                chosenDate)
        .toList();
    return Expanded(
      child: SingleChildScrollView(
        reverse: true,
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 800,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                ],
              ),
              const HeaderChemicaTableForSupplying(),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1.2),
                  2: FlexColumnWidth(1.2),
                  3: FlexColumnWidth(2),
                  4: FlexColumnWidth(4),
                  5: FlexColumnWidth(3),
                  6: FlexColumnWidth(3),
                  7: FlexColumnWidth(2),
                  8: FlexColumnWidth(1),
                },
                border: TableBorder.all(width: 1, color: Colors.black),
                children: Chemicals.sortedBy<num>((element) => element.chemical_ID).map((e) => TableRow(
                    decoration: BoxDecoration(color: Colors.teal[50]
                        // : Colors.amber[50],
                        ),
                    children: [
                      Center(child: Text(e.StockRequisitionNum.toString())),
                      Center(child: Text(e.outTo.toString())),
                      Center(child: Text(e.family.toString())),
                      Center(child: Text(e.name.toString())),
                      Center(child: Text(e.unit.toString())),
                      Center(child: Text(e.quantity.toString())),
                      Center(child: Text(e.Totalquantity.toString())),
                      Center(child: Text(e.notes.toString())),
                      Center(
                        child: IconButton(
                            onPressed: () {
                              vm.DeleteChemical(context, e);
                            },
                            icon: const Icon(color: Colors.red, Icons.delete)),
                      )
                    ].reversed.toList())).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderChemicaTableForSupplying extends StatelessWidget {
  const HeaderChemicaTableForSupplying({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1.2),
        2: FlexColumnWidth(1.2),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(4),
        5: FlexColumnWidth(3),
        6: FlexColumnWidth(3),
        7: FlexColumnWidth(2),
        8: FlexColumnWidth(1),
      },
      border: TableBorder.all(width: 1, color: Colors.black),
      children: [
        TableRow(
            decoration: const BoxDecoration(
              color:
                  // Colors.teal[50]:
                  Color.fromARGB(122, 26, 163, 140),
            ),
            children: const [
              Center(child: Text("رقم الصرف")),
              Center(child: Text("العميل")),
              Center(child: Text("عائله")),
              Center(child: Text("صنف")),
              Center(child: Text("وحده")),
              Center(child: Text("عدد")),
              Center(child: Text("الكميه")),
              Center(child: Text("ملاحظات")),
              Center(child: Text("حذف")),
            ].reversed.toList())
      ],
    );
  }
}
