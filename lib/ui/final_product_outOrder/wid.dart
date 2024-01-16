// ignore_for_file: must_be_immutable, duplicate_ignore

import 'package:advanced_search/advanced_search.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/validation.dart';
import 'package:jason_company/controllers/Customer_controller.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/commen/textformfield.dart';
import 'package:jason_company/ui/final_product_imported/finalProductStock_viewmodel.dart';
import 'package:jason_company/ui/final_product_outOrder/outOfStockOrder_veiwModel.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OutOrder extends StatelessWidget {
  OutOrder({super.key, required this.item, required this.total});
  outOfStockOrderveiwModel vm = outOfStockOrderveiwModel();
  final FinalProductModel item;
  final int total;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    scrollable: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    content: SizedBox(
                      height: 250,
                      child: SingleChildScrollView(
                        child: Form(
                          key: vm.formKey,
                          child: Column(
                            children: [
                              Container(
                                color: Colors.blue[900],
                                height: 30,
                                child: const Center(
                                  child: Text(
                                    ' صرف منتج تام    ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomTextFormField(
                                        autovalidate: true,
                                        validator: Validation.validateothe,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        keybordtupe: TextInputType.number,
                                        hint: "الكميه",
                                        controller: vm.amountcontroller,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  const SizedBox(height: 15),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red)),
                                        onPressed: () {
                                          vm.add(context, item, total);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('أضافه')),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.blue)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('الغاء')),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ));
        },
        child: const Text("صرف"));
  }
}

class HistoryOfLoaded extends StatelessWidget {
  HistoryOfLoaded({
    super.key,
  });
  FinalProductStockViewModel vm = FinalProductStockViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, finalproducts, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("سجل "),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Table(
                    columnWidths: const {
                      4: FlexColumnWidth(2),
                    },
                    children: finalproducts.finalproducts
                        .where((e) => e.amount < 0)
                        .toList()
                        .map((user) {
                      return TableRow(
                          decoration: BoxDecoration(color: Colors.teal[50]),
                          children: [
                            Container(
                                padding: const EdgeInsets.all(4),
                                child: GestureDetector(
                                    onTap: () {
                                      user.actions.if_action_exist(
                                                  finalProdcutAction
                                                      .createInvoice
                                                      .getactionTitle) ==
                                              false
                                          ? context
                                              .read<final_prodcut_controller>()
                                              .deletefinalProudut(user)
                                          : DoNothingAction();
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))),
                            Container(
                                padding: const EdgeInsets.all(2),
                                child: Text(user.density.toString())),
                            Container(
                                padding: const EdgeInsets.all(2),
                                child: Text(user.customer.toString())),
                            Container(
                                padding: const EdgeInsets.all(1),
                                child: Text(user.type.toString())),
                            Container(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                    "${user.hight.removeTrailingZeros}*${user.width.removeTrailingZeros}*${user.lenth.removeTrailingZeros}")),
                            Container(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  user.amount.toString(),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 221, 2, 75)),
                                )),
                          ]);
                    }).toList(),
                    border: TableBorder.all(width: 1, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class InvoiceM extends StatelessWidget {
  InvoiceM({
    super.key,
  });
  outOfStockOrderveiwModel vm = outOfStockOrderveiwModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, finalproducts, child) {
        List<FinalProductModel> sorce = finalproducts.finalproducts
            .where((e) =>
                e.amount < 0 &&
                e.actions.if_action_exist(
                        finalProdcutAction.createInvoice.getactionTitle) ==
                    false)
            .toList();
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
            tooltip: 'Increment',
            onPressed: () {
              vm.addInvoice(
                  context,
                  finalproducts.finalproducts
                      .where((e) => e.amount < 0)
                      .toList());
            },
            child: const Icon(Icons.check, color: Colors.white, size: 28),
          ),
          appBar: AppBar(
            title: const Text("تسجيل اذن "),
          ),
          body: Form(
            key: vm.formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                AdvancedSearch(
                  searchItems: context
                      .read<Customer_controller>()
                      .customers
                      .map((e) => e.name)
                      .toList(),
                  maxElementsToDisplay: 4,
                  singleItemHeight: 50,
                  borderColor: Colors.grey,
                  minLettersForSearch: 1,
                  selectedTextColor: const Color(0xFF3363D9),
                  fontSize: 14,
                  borderRadius: 12.0,
                  hintText: ' ابحث عن عميل',
                  cursorColor: Colors.blueGrey,
                  autoCorrect: false,
                  focusedBorderColor: Colors.blue,
                  searchResultsBgColor: const Color(0xFAFAFA),
                  disabledBorderColor: Colors.cyan,
                  enabledBorderColor: Colors.black,
                  enabled: true,
                  caseSensitive: false,
                  inputTextFieldBgColor: Colors.white10,
                  clearSearchEnabled: true,
                  itemsShownAtStart: 2,
                  searchMode: SearchMode.CONTAINS,
                  showListOfResults: true,
                  unSelectedTextColor: Colors.black54,
                  verticalPadding: 10,
                  horizontalPadding: 10,
                  hideHintOnTextInputFocus: true,
                  hintTextColor: Colors.grey,
                  onItemTap: (index, value) {
                    vm.customerName.text = value;
                  },
                  onSearchClear: () {
                    print("Cleared Search");
                  },
                  onSubmitted: (searchText, listOfResults) {
                    print("Submitted: $searchText");
                  },
                  onEditingProgress: (searchText, listOfResults) {
                    print("TextEdited: $searchText");
                    print("LENGTH: ${listOfResults.length}");
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      CustomTextFormField(
                          label: "العميل",
                          readOnly: true,
                          validator: Validation.validateothers,
                          hint: 'فارغ  ',
                          width: 120,
                          controller: vm.customerName),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomTextFormField(
                          validator: Validation.validateothers,
                          hint: 'رقم العربه',
                          width: 120,
                          controller: vm.carnumber),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      CustomTextFormField(
                          validator: Validation.validateothers,
                          keybordtupe: TextInputType.name,
                          hint: 'اسم السائق ',
                          width: 120,
                          controller: vm.driverName),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomTextFormField(
                          validator: Validation.validateothers,
                          keybordtupe: TextInputType.name,
                          hint: 'القائم بالتحميل',
                          width: 120,
                          controller: vm.whoLoad),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Table(
                      columnWidths: const {
                        4: FlexColumnWidth(2),
                      },
                      children: sorce.map((user) {
                        return TableRow(
                            decoration: BoxDecoration(color: Colors.teal[50]),
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(4),
                                  child: GestureDetector(
                                      onTap: () {
                                        context
                                            .read<final_prodcut_controller>()
                                            .deletefinalProudut(user);
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ))),
                              Container(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(user.density.toString())),
                              Container(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(user.customer.toString())),
                              Container(
                                  padding: const EdgeInsets.all(1),
                                  child: Text(user.type.toString())),
                              Container(
                                  padding: const EdgeInsets.all(4),
                                  child: Text(
                                      "${user.hight.removeTrailingZeros}*${user.width.removeTrailingZeros}*${user.lenth.removeTrailingZeros}")),
                              Container(
                                  padding: const EdgeInsets.all(4),
                                  child: Text(
                                    user.amount.toString(),
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 221, 2, 75)),
                                  )),
                            ]);
                      }).toList(),
                      border: TableBorder.all(width: 1, color: Colors.black),
                    ),
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
