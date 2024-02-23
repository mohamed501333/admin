// ignore_for_file: camel_case_types

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/ChemicalsController.dart';
import 'package:jason_company/ui/chemical_stock/componants.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class Chemical_view extends StatelessWidget {
  const Chemical_view({super.key});

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {
                context.gonext(context, MyCustomDropDowen());
              },
              child: const Text(
                "صرف",
                style: TextStyle(color: Color.fromARGB(255, 156, 0, 0)),
              ))
        ],
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}

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

class MyCustomDropDowen extends StatelessWidget {
  MyCustomDropDowen({super.key});
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Chemicals_controller x = context.read<Chemicals_controller>();

    List<String> familys = x.Chemicals.map((e) => e.family).toSet().toList();

    List<String> items = x.Chemicals.filterItemsPasedOnFamilys(context)
        .map((e) => e.name)
        .toSet()
        .toList();

    List<String> selectedItems = x.selctedFamilys.toSet().toList();

    List<String> selctedNames = x.selctedNames.toSet().toList();

    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: [
          Consumer<Chemicals_controller>(
            builder: (context, myType, child) {
              print(items.length);
              return DropdownButton2<String>(
                  isExpanded: true,
                  hint: Text(
                    'العائلات',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: familys.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      //disable default onTap to avoid closing menu when selecting an item
                      enabled: false,
                      child: StatefulBuilder(
                        builder: (context, menuSetState) {
                          final isSelected = selectedItems.contains(item);
                          return InkWell(
                            onTap: () {
                              isSelected
                                  ? selectedItems.remove(item)
                                  : selectedItems.add(item);
                              //This rebuilds the StatefulWidget to update the button's text
                              myType.Refresh_Ui();
                              //This rebuilds the dropdownMenu Widget to update the check mark
                              menuSetState(() {});
                            },
                            child: Container(
                              height: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  if (isSelected)
                                    const Icon(Icons.check_box_outlined)
                                  else
                                    const Icon(Icons.check_box_outline_blank),
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
                  value: selectedItems.isEmpty ? null : selectedItems.last,
                  onChanged: (value) {},
                  selectedItemBuilder: (context) {
                    return familys.map(
                      (item) {
                        return Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            selectedItems.join(', '),
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
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(left: 16, right: 8),
                    height: 40,
                    width: 140,
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
                  hint: Text(
                    'الاصناف',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: items.map((item) {
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  if (isSelected)
                                    const Icon(Icons.check_box_outlined)
                                  else
                                    const Icon(Icons.check_box_outline_blank),
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
                    return items.map(
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
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(left: 16, right: 8),
                    height: 40,
                    width: 140,
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
    );
  }
}
