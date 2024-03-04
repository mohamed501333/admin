// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/ui/stockCheck/stockchek_veiwModel.dart';
import 'package:provider/provider.dart';

class Stockcheck extends StatelessWidget {
  Stockcheck({super.key});
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<final_prodcut_controller>(
        builder: (context, myType, child) {
          Stockcheck_veiwModel vm = Stockcheck_veiwModel();
          List<FinalProdcutBalanceModel> f =
              vm.finalprodctBalance(myType.finalproducts);
          for (var e in f) {
            print("${e.color}${e.density}${e.type}${e.quantity}");
          }
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      items: f.map((e) => e.color).toSet().toList().map((item) {
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
                        return f.map((e) => e.color).toSet().toList().map(
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
                      items: myType.finalproducts
                          .map((e) => e.type)
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
                        return myType.finalproducts
                            .map((e) => e.color)
                            .toSet()
                            .toList()
                            .map(
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
                      items: myType.finalproducts
                          .map((e) => e.density.toString())
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
                        return myType.finalproducts
                            .map((e) => e.density)
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
            ],
          );
        },
      ),
    );
  }
}
