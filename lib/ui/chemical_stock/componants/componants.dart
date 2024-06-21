// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:jason_company/controllers/ChemicalsController.dart';
import 'package:jason_company/ui/chemical_stock/ChemicalStock_viewModel.dart';
import 'package:jason_company/ui/commen/errmsg.dart';
import 'package:jason_company/ui/commen/textformfield.dart';
import 'package:provider/provider.dart';

//صفحة تكويد اصناف جديده
class CreateChemicalCategory extends StatelessWidget {
  CreateChemicalCategory({super.key});
  ChemicalStockViewModel vm = ChemicalStockViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<Chemicals_controller>(
      builder: (context, myType, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("تكويد اصناف جديده"),
          ),
          body: Form(
            key: vm.formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [   errmsg() ,
                  ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("الوحدات"),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('اضافة وحده جديده'),
                                      content: SizedBox(
                                        height: 300,
                                        child: Column(children: [
                                          Column(
                                            children: [
                                              CustomTextFormField(
                                                  keybordtupe: TextInputType.name,
                                                  hint: "وحدة جديده",
                                                  width: 130,
                                                  controller: vm.unit),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              CustomTextFormField(
                                                  hint: "الكميه للوحده",
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .28,
                                                  controller: vm.quantityForUnit),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    vm.addUnit(context);
                                                  },
                                                  child: const Text("Add")),
                                            ],
                                          ),
                                        ]),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('ok')),
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(Icons.add))
                      ],
                    ),
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
                  ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("العائله"),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('اضافة عائله جديده'),
                                      content: SizedBox(
                                        height: 300,
                                        child: Column(children: [
                                          Column(
                                            children: [
                                              CustomTextFormField(
                                                  keybordtupe: TextInputType.name,
                                                  hint: "عائله جديده",
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .28,
                                                  controller: vm.family),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    vm.addFamily(context);
                                                  },
                                                  child: const Text("Add")),
                                            ],
                                          ),
                                        ]),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('ok')),
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(Icons.add))
                      ],
                    ),
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
                  ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("الاصناف"),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('اضافة صنف جديد'),
                                      content: SizedBox(
                                        height: 300,
                                        child: Column(children: [
                                          Column(
                                            children: [
                                              CustomTextFormField(
                                                  keybordtupe: TextInputType.name,
                                                  hint: "صنف",
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .28,
                                                  controller: vm.item),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    vm.addItem(context);
                                                  },
                                                  child: const Text("Add")),
                                            ],
                                          ),
                                        ]),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('ok')),
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(Icons.add))
                      ],
                    ),
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
                  ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("الموردين"),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('اضافة مورد جديد'),
                                      content: SizedBox(
                                        height: 300,
                                        child: Column(children: [
                                          Column(
                                            children: [
                                              CustomTextFormField(
                                                  keybordtupe: TextInputType.name,
                                                  hint: "مورد",
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .28,
                                                  controller: vm.supplyer),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    vm.addSupplyer(context);
                                                  },
                                                  child: const Text("Add")),
                                            ],
                                          ),
                                        ]),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('ok')),
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(Icons.add))
                      ],
                    ),
                    children: myType.ChemicalCategorys.where(
                            (element) => element.cummingFrom.isNotEmpty)
                        .map((e) => Row(
                              children: [
                                Text(e.cummingFrom),
                                IconButton(
                                    onPressed: () {
                                      vm.delete(context, e);
                                    },
                                    icon: const Icon(Icons.delete))
                              ],
                            ))
                        .toList(),
                  ),
                  ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("العملاء"),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('اضافة عميل جديد'),
                                      content: SizedBox(
                                        height: 300,
                                        child: Column(children: [
                                          Column(
                                            children: [
                                              CustomTextFormField(
                                                  keybordtupe: TextInputType.name,
                                                  hint: "عميل",
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .28,
                                                  controller: vm.customer),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    vm.addcustomer(context);
                                                  },
                                                  child: const Text("Add")),
                                            ],
                                          ),
                                        ]),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('ok')),
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(Icons.add))
                      ],
                    ),
                    children: myType.ChemicalCategorys.where(
                            (element) => element.OutTo.isNotEmpty)
                        .map((e) => Row(
                              children: [
                                Text(e.OutTo),
                                IconButton(
                                    onPressed: () {
                                      vm.delete(context, e);
                                    },
                                    icon: const Icon(Icons.delete))
                              ],
                            ))
                        .toList(),
                  ),
                ].reversed.toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
