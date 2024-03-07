// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/validation.dart';
import 'package:jason_company/controllers/purchesController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/purching/Purches_veiwModel.dart';
import 'package:provider/provider.dart';

class PurchingView extends StatelessWidget {
  PurchingView({super.key});
  TextStyle style = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  PurchesViewMolel vm = PurchesViewMolel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(),
        body: Consumer<PurchesController>(
          builder: (context, myType, child) {
            return Form(
              key: vm.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                
                  const Center(
                    child: Text(
                      "تسجيل طلب شراء جديد",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                       Container(
                        height: 40,
                                      width: MediaQuery.of(context).size.width *
                                          .30,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: Center(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            vm.administrationRequstTheOrder.text=value;
                                          },
                                          validator: Validation.validateOOOOOO,
                                        ),
                                      ),
                                    ),
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Text(
                          ":الاداره الطالبه",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
               
                  Header(style: style),
                 
                  Expanded(   
                      child: SingleChildScrollView(
                    child: Column(
                      children: vm.permanentWidget
                          .map((e) => Center(
                                child: IntrinsicHeight(
                                    child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .10,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: Center(
                                        child: Text(
                                          "م",
                                          style: style,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .12,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: Center(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            e.quantity = value.to_double();
                                          },
                                          keyboardType: TextInputType.number,
                                          validator: Validation.validateOOOOOO,
                                          initialValue: "",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .20,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: Center(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            e.Unit = value;
                                          },
                                          validator: Validation.validateOOOOOO,
                                          initialValue: e.Unit.toString(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .33,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: Center(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            e.item = value;
                                          },
                                          validator: Validation.validateOOOOOO,
                                          initialValue: e.item.toString(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .25,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: Center(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            e.note = value;
                                          },
                                          initialValue: e.note.toString(),
                                        ),
                                      ),
                                    ),
                                  ].reversed.toList(),
                                )),
                              ))
                          .toList(),
                    ),
                  )),
                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                                      
                            if ( vm.formKey.currentState!.validate()) {
                                 vm.permanentWidget.add(PurcheItem(
                                item_Id: 0,
                                purcheOrder_Id: 0,
                                quantity: 0,
                                Unit: "",
                                item: "",
                                note: "",
                                actions: []));
                            myType.Refrech_UI();
                            }
                         
                          },
                          icon: const Icon(
                            size: 40,
                            Icons.add,
                            color: Colors.red,
                          )),
                   
                   
                    ElevatedButton(onPressed: (){}, child: const Text('تسجيل'))
                   
                    ],
                  ),
          
                ],
              ),
            );
          },
        ));
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.style,
  });

  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicHeight(
          child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .10,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: Text(
                "م",
                style: style,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .12,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: Text("الكميه", style: style),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .20,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: Text("الوحده", style: style),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .33,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: Text("الصنف", style: style),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .25,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: Text("ملاحظات", style: style),
            ),
          ),
        ].reversed.toList(),
      )),
    );
  }
}
