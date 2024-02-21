import 'package:flutter/material.dart';
import 'package:jason_company/controllers/scissors_controller.dart';
import 'package:jason_company/ui/scissors/component/radiobuttom.dart';
import 'package:jason_company/ui/scissors/scissors_viewModer.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ScissorsView extends StatelessWidget {
  ScissorsView({super.key});
  ScissorsViewModel vm = ScissorsViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<ScissorsController>(
      builder: (context, myType, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              const Radiobuttom(),
              Expanded(
                child: vm.csissorsPages[myType.indexOfRadioButon],
              ),
            ],
          ),
        );
      },
    );
  }
}
