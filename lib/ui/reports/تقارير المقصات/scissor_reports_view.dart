// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/models/moderls.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:provider/provider.dart';

class H_Reports_view extends StatelessWidget {
  const H_Reports_view({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, myType, child) {
        List<BlockModel> totalblocks = myType.blocks
            .where((element) =>
                element.actions
                    .get_Date_of_action(
                        BlockAction.cut_block_on_H.getactionTitle)
                    .formatt() ==
                DateTime.now().formatt())
            .toList();
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title: Text("${totalblocks.length}   اجمالى البلوكات"),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title: Text("اجمالى الهوالك"),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title: Text("اجمالى النواتج"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
