// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/purchesController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/purching/componants0.dart';

class PurchVeiw extends StatelessWidget {
  const PurchVeiw({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                context.gonext(context, NewPurch());
              },
              child: Container(
                width: 66,
                decoration: const BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.all(Radius.circular(11))),
                child: const Center(
                    child: Text(
                  "جديد",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.amber,
                      fontWeight: FontWeight.bold),
                )),
              ))
        ],
      ),
      body:  Consumer<PurchesController>(
        builder: (context, myType, child) {
          return SingleChildScrollView(
            child: Column(children: 
            myType.purchesOrders.map((e) => Card1(e:  e)).toList(),),
          );
        },
      ),
    );
  }
}




class Card1 extends StatelessWidget {
  final PurcheOrder e;
  const Card1({
    Key? key,
    required this.e,
  }) : super(key: key);
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        color: const Color.fromARGB(255, 232, 216, 167),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
      
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Container(
                    color: const Color.fromARGB(255, 138, 89, 71),
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.add_shopping_cart_rounded,
                                  color: Colors.white,
                                )),
                            Expanded(flex: 1, child: Container()),
                             Expanded(
                              flex: 4,
                              child: Text(
                                "  طلب شراء ( ${e.serial} )      الحاله (قيد الموافقه)" ,
                                style: const TextStyle(color: Color.fromARGB(255, 73, 223, 35),fontWeight: FontWeight.bold,fontSize: 22),
                              ),
                            ),
                          ],
                        )),
                  ),
                collapsed: Container(),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                     Text("الادراه الطالبه: ${e.Adminstrationrequested}"),
                     Text(" اسم الطالب: ${e.requester}"),
                      ...e.items.map((e) =>  Data(),)
             

                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}




class Data extends StatelessWidget {
   Data({
    super.key,
  });

  TextStyle style = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicHeight(
          child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .6,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: Text(
                "م",
                style: style,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .8,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: Text("الكميه", style: style),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .16,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: Text("الوحده", style: style),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .29,
            decoration: BoxDecoration(border: Border.all()),
            child: Center(
              child: Text("الصنف", style: style),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .21,
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

