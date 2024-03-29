// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/validation.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/commen/textformfield.dart';
import 'package:jason_company/ui/final_product_imported/Widgets.dart';
import 'package:jason_company/ui/final_product_imported/finalProductStock_viewmodel.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/sH/H1_veiwModel.dart';
import 'package:jason_company/ui/sR/Rscissor_view.dart';
import 'package:jason_company/ui/sR/Rscissor_viewModel.dart';

showmyAlertDialog1414(BuildContext context, BlockFirebasecontroller myType,
    int scissor, int lastStage) {
  Rscissor_veiwModel vm = Rscissor_veiwModel();
  List<FractionModel> fractionsNotCutOnRscissor =
      vm.fractions_Underoperation(context, myType.blocks);
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
                    children: fractionsNotCutOnRscissor
                        .filter_Fractios___()
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              if (vm.amountcontroller.text.isNotEmpty) {
                                for (var element in fractionsNotCutOnRscissor
                                    .where((f) =>
                                        f.item.W == e.item.W &&
                                        f.item.type == e.item.type &&
                                        f.item.density == e.item.density &&
                                        f.item.color == e.item.color &&
                                        f.item.H == e.item.H &&
                                        f.item.L == e.item.L)
                                    .take(vm.amountcontroller.text.to_int())) {
                                  myType.add_on_R_scissor(
                                    lastStage: lastStage,
                                    context: context,
                                    fractiond: element,
                                    Rscissor: scissor,
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
                                    "${e.item.W.removeTrailingZeros}*${e.item.L}*${e.item.H.removeTrailingZeros} ${e.item.color} ${e.item.type} D${e.item.density.removeTrailingZeros}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    fractionsNotCutOnRscissor
                                        .where((element) =>
                                            element.item.color ==
                                                e.item.color &&
                                            element.item.type == e.item.type &&
                                            element.item.density ==
                                                e.item.density &&
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
// ignore: non_constant_identifier_names
showmyAlertDialog_forAddingFinalProductToRscissor(BuildContext context,
    int Rscissor, int stageOfR) {
  Rscissor_veiwModel vm = Rscissor_veiwModel();
  FinalProductStockViewModel vm1=FinalProductStockViewModel();

  showDialog(
               

      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          title: const Text(''),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: SingleChildScrollView(
              
              child: Form(
                key: vm.formKey,
                child: Column(
                  
                  children: [
                  
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                       CustomTextFormField(
                  keybordtupe: TextInputType.name,
                  width: MediaQuery.of(context).size.width * .40,
                  hint: "ملاحظات ",
                  controller: vm.notes,
                ),
                     Column(
                       children: [
                         CustomTextFormField(
                          width: MediaQuery.of(context).size.width * .23,
                          hint: "عدد",
                          controller: vm.amountcontroller,
                          validator: Validation.validateothers,
                                       ),
                                        const Text("من",style: TextStyle(fontWeight: FontWeight.bold),),
                                        
                       ],
                     ),
                   ],
                 ),
                 
                FieldsINsertInFInalProdcutFormScissor(vm: vm1)
                            
                ]),
              ),
            ),
          ),
          actions: [
               Row(
                       children: [

                         AddUnregular2(Rscissor: Rscissor,lastStage:stageOfR ,).permition(context,
                                         UserPermition.incert_unregular_in_importedfinal_prodcut),

                                          AddUnregular().permition(context,
                               UserPermition.incert_unregular_in_importedfinal_prodcut)

                       ],
                     ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  if (vm.formKey.currentState!.validate()) {
                    vm.incert_finalProduct_from_cutingUnitR2324(context, stageOfR, Rscissor);
                  Navigator.pop(context);

                  }
                },
                child: const Text('ok')),
          ],
        );
      });
}

dialogOfAddNotFinalToBlock4544(
    BuildContext context,
    //الفرد المقصوصه على هذا المقص فى هئا الدور 
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
                  for (var e in fractions) {
                    context
                        .read<BlockFirebasecontroller>()
                        .add_Not_final_ToFractionR(
                            fractiond: e,
                            type: context.read<ObjectBoxController>().initial2,
                            Rscissord: e.Rscissor,
                            wight: vm.wightcontroller.text.to_double() /
                                fractions.length);
                  }

                  Navigator.pop(context);
                },
                child: const Text('تم')),
          ],
        );
      });
}


class FieldsINsertInFInalProdcutFormScissor extends StatelessWidget {
  const FieldsINsertInFInalProdcutFormScissor({
    super.key,
    required this.vm,
  });

  final FinalProductStockViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          SearchForSize(),
    
          const SizedBox(height: 15),
        
        ],
      ),
    );
  }
}

//شغل مرحله اخرى تحت التشغيل(غير تام)'
class AddUnregular2 extends StatelessWidget {
  AddUnregular2({
    Key? key,
    required this.Rscissor,
    required this.lastStage,
  }) : super(key: key);
  Rscissor_veiwModel vm = Rscissor_veiwModel();
   final int Rscissor;
   final int lastStage;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    scrollable: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    content: SizedBox(
                      height: 450,
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
                                    'شغل مرحله اخرى تحت التشغيل(غير تام)',
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomTextFormField(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        hint: "النوع",
                                        keybordtupe: TextInputType.name,
                                        controller: vm.typecontroller,
                                        validator: Validation.validateothers,
                                      ),
                                      CustomTextFormField(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        hint: "الكثافه",
                                        controller: vm.densitycontroller,
                                        validator: Validation.validateothers,
                                      ),
                         
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomTextFormField(
                                        validator: Validation.validateothers,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        keybordtupe: TextInputType.number,
                                        hint: "الكميه",
                                        controller: vm.amountcontroller,
                                      ),
                                      CustomTextFormField(
                                        validator: Validation.validateothers,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        keybordtupe: TextInputType.number,
                                        hint: "مقص",
                                        controller: vm.scissorcontroller,
                                      ),
                                      CustomTextFormField(
                                        validator: Validation.validateothers,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        keybordtupe: TextInputType.name,
                                        hint: "اللون",
                                        controller: vm.colercontroller,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomTextFormField(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        hint: "الارتفاع",
                                        controller: vm.hightncontroller,
                                        validator: Validation.validateothers,
                                      ),
                                      CustomTextFormField(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        hint: "العرض",
                                        controller: vm.widthcontroller,
                                        validator: Validation.validateothers,
                                      ),
                                      CustomTextFormField(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        hint: "الطول ",
                                        controller: vm.lenthcontroller,
                                        validator: Validation.validateothers,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  CustomTextFormField(
                                    width:
                                        MediaQuery.of(context).size.width * .22,
                                    hint: "رقم الدور",
                                    controller: vm.N,
                                    validator: Validation.validateothers,
                                  ),
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
                                          if (vm.validate()) {
                                            vm.add_UnderOperatin_work(context);
                                          }
                                          
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
        icon: const Icon(color: Colors.red, Icons.add_box_sharp));
  }
}
