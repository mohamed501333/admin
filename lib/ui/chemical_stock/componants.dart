// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:jason_company/controllers/CategorysController.dart';
import 'package:jason_company/ui/chemical_stock/ChemicalStock_viewModel.dart';
import 'package:jason_company/ui/commen/textformfield.dart';
import 'package:provider/provider.dart';

class CreateChemicalCategory extends StatelessWidget {
  CreateChemicalCategory({super.key});
  ChemicalStockViewModel vm = ChemicalStockViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<Category_controller>(
      builder: (context, myType, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("تكويد اصناف جديده"),
          ),
          body: Form(
            key: vm.formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                        keybordtupe: TextInputType.name,
                        hint: "وحدة جديده",
                        width: MediaQuery.of(context).size.width * .28,
                        controller: vm.unit),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                        hint: "الكميه للوحده",
                        width: MediaQuery.of(context).size.width * .28,
                        controller: vm.quantityForUnit),
                    ElevatedButton(
                        onPressed: () {
                          vm.addUnit(context);
                        },
                        child: const Text("Add")),
                    SingleChildScrollView(
                      child: Column(
                        children: myType.ChemicalCategorys.where(
                                (element) => element.unit.isNotEmpty)
                            .map((e) => Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(e.unit),
                                        Text(e.quantityForUnit.toString()),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          vm.delete(context, e);
                                        },
                                        icon: const Icon(Icons.delete))
                                  ],
                                ))
                            .toList(),
                      ),
                    )
                  ],
                ),
                Container(
                  width: 1,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                        keybordtupe: TextInputType.name,
                        hint: "عائله جديده",
                        width: MediaQuery.of(context).size.width * .28,
                        controller: vm.family),
                    ElevatedButton(
                        onPressed: () {
                          vm.addFamily(context);
                        },
                        child: const Text("Add")),
                    SingleChildScrollView(
                      child: Column(
                        children: myType.ChemicalCategorys.where(
                                (element) => element.family.isNotEmpty)
                            .map((e) => Row(
                                  children: [
                                    Text(e.family),
                                    IconButton(
                                        onPressed: () {
                                          vm.delete(context, e);
                                        },
                                        icon: const Icon(Icons.delete))
                                  ],
                                ))
                            .toList(),
                      ),
                    )
                  ],
                ),
                Container(
                  width: 1,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                        keybordtupe: TextInputType.name,
                        hint: "صنف",
                        width: MediaQuery.of(context).size.width * .28,
                        controller: vm.item),
                    ElevatedButton(
                        onPressed: () {
                          vm.addItem(context);
                        },
                        child: const Text("Add")),
                    SingleChildScrollView(
                      child: Column(
                        children: myType.ChemicalCategorys.where(
                                (element) => element.item.isNotEmpty)
                            .map((e) => Row(
                                  children: [
                                    Text(e.item),
                                    IconButton(
                                        onPressed: () {
                                          vm.delete(context, e);
                                        },
                                        icon: const Icon(Icons.delete))
                                  ],
                                ))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ].reversed.toList(),
            ),
          ),
        );
      },
    );
  }
}
