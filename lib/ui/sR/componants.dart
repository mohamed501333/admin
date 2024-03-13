import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/validation.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/commen/textformfield.dart';
import 'package:jason_company/ui/sH/H1_veiwModel.dart';
import 'package:jason_company/ui/sR/Rscissor_view.dart';
import 'package:jason_company/ui/sR/Rscissor_viewModel.dart';
import 'package:provider/provider.dart';

showmyAlertDialog1414(BuildContext context, BlockFirebasecontroller myType,
    int scissor, int lastStage) {
  Rscissor_veiwModel vm = Rscissor_veiwModel();
  List<FractionModel> fractions_Not_Cut_On_RScissor =
      vm.fractions_Not_Cut_On_RScissor(context, myType.blocks);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(''),
          content: SizedBox(
            height: 400,
            child: SingleChildScrollView(
              child: Column(children: [
                CustomTextFormField(
                    validator: Validation.validateothe,
                    hint: "عدد",
                    width: 60,
                    controller: vm.amountcontroller),
                const Text("من"),
                SingleChildScrollView(
                  child: Column(
                    children: fractions_Not_Cut_On_RScissor
                        .filter_Fractios___()
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              if (vm.amountcontroller.text.isNotEmpty) {
                                for (var element
                                    in fractions_Not_Cut_On_RScissor
                                        .where((f) =>
                                            f.item.W == e.item.W &&
                                            f.item.type == e.item.type &&
                                            f.item.density == e.item.density &&
                                            f.item.color == e.item.color &&
                                            f.item.H == e.item.H &&
                                            f.item.L == e.item.L)
                                        .take(vm.amountcontroller.text
                                            .to_int())) {
                                  myType.add_on_R_scissor(
                                    lastStage: lastStage,
                                    context: context,
                                    fractiond: element,
                                    scissor: scissor,
                                  );
                                }
                              }
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: 180,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
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
                                    "${e.item.W}*${e.item.L}*${e.item.H} ${e.item.color} ${e.item.type} D${e.item.density.removeTrailingZeros}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    fractions_Not_Cut_On_RScissor
                                        .where((element) =>
                                            element.item.color == e.item.color &&
                                            element.item.type == e.item.type &&
                                            element.item.density == e.item.density &&
                                            element.item.W == e.item.W &&
                                            element.item.L == e.item.L &&
                                            element.item.H == e.item.H)
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
                )
              ]),
            ),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('ok')),
          ],
        );
      });
}

dialogOfAddNotFinalToBlock4544(
    BuildContext context,
    //المقصوصه على هذا المقص فى هئا الدور
    List<FractionModel> fractions) {
  H1VeiwModel vm = H1VeiwModel();
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('اضافة هوالك الى هذا الدور'),
          content: SizedBox(
            height: 200,
            child: Column(children: [
              const DropDdowen0023(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 18),
                child: CustomTextFormField(
                    hint: " وزن دون التام",
                    width: 120,
                    validator: Validation.validateothers,
                    controller: vm.wightcontroller),
              ),
            ]),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  // for (var e in fractions) {
                  //   context
                  //       .read<BlockFirebasecontroller>()
                  //       .add_Not_final_ToFraction(
                  //           fractiond: e,
                  //           type: context.read<ObjectBoxController>().initial2,
                  //           Rscissord: e.Rscissor,
                  //           wight: vm.wightcontroller.text.to_double() /
                  //               fractions.length);
                  // }

                  // Navigator.pop(context);
                },
                child: const Text('تم')),
          ],
        );
      });
}
