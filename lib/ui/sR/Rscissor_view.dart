// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/validation.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/commen/textformfield.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/sR/Rscissor_viewModel.dart';
import 'package:provider/provider.dart';

class Rscissor extends StatelessWidget {
  Rscissor({super.key, required this.scissor});
  final int scissor;
  Rscissor_veiwModel vm = Rscissor_veiwModel();

  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, myType, child) {
        return Form(
          key: vm.formKey,
          child: Row(
            children: [
              SizedBox(
                width: 250,
                child: Column(
                  children: vm
                      .fractions_Not_Cut_On_RScissor(context, myType.blocks)
                      .filter_Fractios___()
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            if (vm.validate()) {
                              for (var element in vm
                                  .fractions_Not_Cut_On_RScissor(
                                      context, myType.blocks)
                                  .where((f) =>
                                      f.wedth == e.wedth &&
                                      f.hight == e.hight &&
                                      f.lenth == e.lenth)
                                  .take(vm.amountcontroller.text.to_int())) {
                                myType.add_on_R_scissor(
                                    context: context,
                                    fractiond: element,
                                    scissor: scissor,
                                    w: vm.wightcontroller.text.to_double() /
                                        vm.amountcontroller.text.to_double());
                              }
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 200,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 10,
                            ),
                            decoration: ShapeDecoration(
                              color: const Color.fromARGB(255, 46, 158, 149),
                              shape: StadiumBorder(
                                side: BorderSide(
                                  width: 2,
                                  color: Colors.green[200]!,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "${e.wedth}*${e.lenth}*${e.hight}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 22,
                                ),
                                Text(
                                  vm
                                      .fractions_Not_Cut_On_RScissor(
                                          context, myType.blocks)
                                      .where((element) =>
                                          element.wedth == e.wedth &&
                                          element.lenth == e.lenth &&
                                          element.hight == e.hight)
                                      .toList()
                                      .length
                                      .toString(),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 191, 7, 236),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                        validator: Validation.validateothe,
                        hint: "اعداد الفرد",
                        width: 120,
                        controller: vm.amountcontroller),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                        validator: Validation.validateothe,
                        hint: "وزن الهالك للدور",
                        width: 120,
                        controller: vm.wightcontroller),
                    const SizedBox(
                      height: 20,
                    ),
                    const DropDdowen0023(),
                    ElevatedButton(
                        onPressed: () {
                          context.gonext(
                              context,
                              ReportsFroH(
                                scissor: scissor,
                              ));
                        },
                        child: const Text("تقرير"))
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class DropDdowen0023 extends StatelessWidget {
  const DropDdowen0023({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectBoxController>(
      builder: (context, v, child) {
        return DropdownButton(
            value: context.read<ObjectBoxController>().initial2,
            items: v.notfials
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toString()),
                    ))
                .toList(),
            onChanged: (v) {
              if (v != null) {
                context.read<ObjectBoxController>().initial2 = v;
                context.read<ObjectBoxController>().get();
              }
            });
      },
    );
  }
}

class ReportsFroH extends StatelessWidget {
  const ReportsFroH({super.key, required this.scissor});
  final int scissor;
  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, myType, child) {
        List<FractionModel> fractions = myType.blocks
            .map((e) => e.fractions)
            .toList()
            .expand((element) => element)
            .toList()
            .where((element) => element.Rscissor == scissor)
            .where((element) =>
                element.actions
                    .get_Date_of_action(FractionActon.creat_fraction.getTitle)
                    .formatt() ==
                DateTime.now().formatt())
            .toList();

        var output = context
            .read<final_prodcut_controller>()
            .finalproducts
            .where((element) =>
                element.actions
                    .get_Date_of_action(FractionActon.creat_fraction.getTitle)
                    .formatt() ==
                DateTime.now().formatt())
            .where((element) => element.scissor == scissor + 3);
        double totalOUtput = output.isNotEmpty
            ? output
                .map((e) =>
                    e.lenth *
                    e.width *
                    e.hight *
                    e.density *
                    e.amount /
                    1000000)
                .reduce((a, b) => a + b)
            : 0;
        double totalinput = fractions.isNotEmpty
            ? fractions
                .map((element) =>
                    element.lenth *
                    element.wedth *
                    element.hight *
                    element.density /
                    1000000)
                .reduce((a, b) => a + b)
            : 0;
        double totalNotfinal = fractions.isNotEmpty
            ? fractions
                .map((element) => element.notfinals.map((e) => e.wight))
                .expand((element) => element)
                .reduce((a, b) => a + b)
            : 0;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Text(
                "         total input kg     ${totalinput.removeTrailingZeros}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "  total notFinal kg     ${totalNotfinal.removeTrailingZeros}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "         total output kg     ${totalOUtput.removeTrailingZeros}",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        );
      },
    );
  }
}
