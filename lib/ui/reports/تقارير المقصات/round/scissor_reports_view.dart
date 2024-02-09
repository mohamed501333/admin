// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/controllers/dropDowen_controller.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/main.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/reports/%D8%AA%D9%82%D8%A7%D8%B1%D9%8A%D8%B1%20%D8%A7%D9%84%D9%85%D9%82%D8%B5%D8%A7%D8%AA/horizintal/scissor_viewmodel.dart';
import 'package:jason_company/ui/reports/%D8%AA%D9%82%D8%A7%D8%B1%D9%8A%D8%B1%20%D8%A7%D9%84%D9%85%D9%82%D8%B5%D8%A7%D8%AA/round/widgets.dart';
import 'package:jason_company/ui/reports/reprtsForFinlProuduct/reports_viewmoder.dart';
import 'package:provider/provider.dart';

class R_Reports_view extends StatefulWidget {
  const R_Reports_view({super.key});

  @override
  State<R_Reports_view> createState() => _R_Reports_viewState();
}

class _R_Reports_viewState extends State<R_Reports_view> {
  String chosenDate = format.format(DateTime.now());
  scissor_viewmodel vm = scissor_viewmodel();
  ReportsViewModel vm2 = ReportsViewModel();

  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, myType, child) {
        //fractions
        List<FractionModel> fractions = myType.blocks
            .expand((element) => element.fractions)
            .where((element) =>
                element.actions
                        .get_Date_of_action(
                            FractionActon.cut_fraction_OnRscissor.getTitle)
                        .formatt() ==
                    chosenDate &&
                element.Rscissor ==
                    context
                        .read<dropDowenContoller>()
                        .initioalFor_RScissorsReports)
            .toList();
//notfinals

        List<NotFinalmodel> notfinals =
            fractions.expand((element) => element.notfinals).toList();
        return Scaffold(
          appBar: AppBar(
            actions: [
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
            title: const Text(" تقارير المقصات الدائرى"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const RDropDdowenFor_scissors_reports(),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("${fractions.length}   : اجمالى عدد الفرد"),
                      Text(
                          "${fractions.map((e) => e.lenth * e.wedth * e.hight / 1000000).isEmpty ? 0 : fractions.map((e) => e.lenth * e.wedth * e.hight / 1000000).reduce((value, element) => value + element).toStringAsFixed(2)}  :  اجمالى الفرد  م3 "),
                      Text(
                          "${fractions.map((e) => e.lenth * e.wedth * e.hight / 1000000).isEmpty ? 0 : fractions.map((e) => e.density * e.lenth * e.wedth * e.hight / 1000000).reduce((value, element) => value + element).toStringAsFixed(2)}  :  اجمالى الفرد  كج "),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: Text(
                        " kg ${fractions.map((e) => e.lenth * e.wedth * e.hight / 1000000).isEmpty ? 0 : fractions.map((e) => e.notfinals).expand((element) => element.map((e) => e.wight)).reduce((a, b) => a + b).toStringAsFixed(2)}    :  اجمالى الهوالك"),
                    children: fractions
                        .expand((element) => element.notfinals)
                        .toList()
                        .filter_notfinals___()
                        .map((e) => Row(
                              children: [
                                Text(
                                    "kg ${notfinals.isEmpty ? 0 : vm.total_amount_for_notfinals(e, fractions.expand((element) => element.notfinals).toList()).toStringAsFixed(2)}"),
                                Text(" ${vm.get(e.type)}"),
                              ],
                            ))
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: Column(
                      children: [
                        Text(
                            "اجمالى المنتج التام م3 : ${context.read<final_prodcut_controller>().finalproducts.where((element) => element.actions.get_Date_of_action(finalProdcutAction.incert_finalProduct_from_cutingUnit.getactionTitle).formatt() == chosenDate && element.scissor - 3 == context.read<dropDowenContoller>().initioalFor_RScissorsReports).isEmpty ? 0 : context.read<final_prodcut_controller>().finalproducts.where((element) => element.actions.get_Date_of_action(finalProdcutAction.incert_finalProduct_from_cutingUnit.getactionTitle).formatt() == chosenDate && element.scissor - 3 == context.read<dropDowenContoller>().initioalFor_RScissorsReports).map((e) => e.amount * e.hight * e.lenth * e.width / 1000000).reduce((a, b) => a + b).toStringAsFixed(2)}")
                      ],
                    ),
                    children: context
                            .read<final_prodcut_controller>()
                            .finalproducts
                            .where((element) =>
                                element.actions
                                        .get_Date_of_action(finalProdcutAction
                                            .incert_finalProduct_from_cutingUnit
                                            .getactionTitle)
                                        .formatt() ==
                                    chosenDate &&
                                element.scissor - 3 ==
                                    context
                                        .read<dropDowenContoller>()
                                        .initioalFor_RScissorsReports)
                            .isEmpty
                        ? []
                        : context
                            .read<final_prodcut_controller>()
                            .finalproducts
                            .where((element) =>
                                element.actions
                                        .get_Date_of_action(finalProdcutAction
                                            .incert_finalProduct_from_cutingUnit
                                            .getactionTitle)
                                        .formatt() ==
                                    chosenDate &&
                                element.scissor - 3 ==
                                    context
                                        .read<dropDowenContoller>()
                                        .initioalFor_RScissorsReports)
                            .toList()
                            .filteronfinalproduct()
                            .map((e) => Row(
                                  children: [
                                    Text(
                                        "عدد ${vm2.totalofSingleSizeOfsingleScissor(e, context.read<final_prodcut_controller>().finalproducts.where((element) => element.actions.get_Date_of_action(finalProdcutAction.incert_finalProduct_from_cutingUnit.getactionTitle).formatt() == chosenDate && element.scissor - 3 == context.read<dropDowenContoller>().initioalFor_RScissorsReports).toList())}"),
                                    Text(
                                        "  ${e.lenth.removeTrailingZeros} * ${e.width.removeTrailingZeros} * ${e.hight.removeTrailingZeros}"),
                                  ],
                                ))
                            .toList(),
                  ),
                ),
              ],
            ),
          ),
        ).permition(context, UserPermition.show_Reports_R);
      },
    );
  }
}
