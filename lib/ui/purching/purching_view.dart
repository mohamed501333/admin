
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';


class PurchingView extends StatelessWidget {
  PurchingView({super.key});
  TextStyle style= const TextStyle(fontSize: 18,fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
                 const Center(child: Text("تسجيل طلب شراء جديد",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),) ,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              IconButton(onPressed: (){
                
              }, icon: const Icon(Icons.add,color: Colors.amber,)),

              const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Text(":الاداره الطالبه",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              )
            ],
          )
,
           Column(children: [
            Center(
              child: IntrinsicHeight(child: SizedBox(
                width: 800,
                child: Row(children: [
                
                  Container(decoration:  BoxDecoration(border: Border.all()),child:  Center(child: Text("م",style: style,),),),
                  Container(decoration:  BoxDecoration(border: Border.all()),child:  Center(child: Text("الكميه",style: style),),),
                  Container(decoration:  BoxDecoration(border: Border.all()),child:  Center(child: Text("الوحده",style: style),),),
                  Container(decoration:  BoxDecoration(border: Border.all()),child:  Center(child: Text("الصنف",style: style),),),
                  Container(decoration:  BoxDecoration(border: Border.all()),child:  Center(child: Text("ملاحظات",style: style),),),
                
                
                
                ].reversed.toList(),),
              )),
            )
           ],)
      ],),
    );
  }
}

