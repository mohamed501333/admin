// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:jason_company/app/validation.dart';
import 'package:jason_company/controllers/CategorysController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/blocksStock/outofStock_viewmoder.dart';
import 'package:jason_company/ui/blocksStock/widgets.dart';
import 'package:jason_company/ui/commen/textformfield.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

class BlockCategoryView extends StatelessWidget {
  BlockCategoryView({super.key});

  BlocksStockViewModel vm = BlocksStockViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: vm.formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            const DropDdowenFor_blockCategory(),
            const SizedBox(
              height: 19,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomTextFormField(
                  keybordtupe: TextInputType.name,
                  width: MediaQuery.of(context).size.width * .70,
                  hint: " البيان",
                  controller: vm.blockdesription,
                ),
                CustomTextFormField(
                  width: MediaQuery.of(context).size.width * .30,
                  hint: "الكثافه",
                  controller: vm.densitycontroller,
                  validator: Validation.validateothers,
                ),
              ],
            ),
            const SizedBox(
              height: 19,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomTextFormField(
                  width: MediaQuery.of(context).size.width * .50,
                  hint: "اللون",
                  keybordtupe: TextInputType.text,
                  controller: vm.colercontroller,
                  validator: Validation.validateothers,
                ),
                CustomTextFormField(
                  width: MediaQuery.of(context).size.width * .50,
                  hint: "النوع",
                  keybordtupe: TextInputType.name,
                  controller: vm.typecontroller,
                  validator: Validation.validateothers,
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  if (vm.formKey.currentState!.validate()) {
                    context.read<Category_controller>().addNewBlockCategory(
                            BlockCategory(
                                id: DateTime.now().millisecondsSinceEpoch,
                                description: vm.blockdesription.text,
                                type: vm.typecontroller.text,
                                density: vm.densitycontroller.text,
                                color: vm.colercontroller.text,
                                actions: [
                              BlockCategoryAction.creat_new_block_category.add
                            ]));
                    vm.clearfields();
                  }
                },
                child: const SizedBox(
                  width: 90,
                  height: 45,
                  child: Center(
                    child: Text(
                      "اضافة",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
