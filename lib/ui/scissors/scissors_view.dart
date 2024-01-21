import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/controllers/scissors_controller.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/scissors/component/radiobuttom.dart';
import 'package:jason_company/ui/scissors/scissors_viewModer.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ScissorsView extends StatelessWidget {
  ScissorsView({super.key});
  ScissorsViewModel vm = ScissorsViewModel();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Radiobuttom(),
        Expanded(
          child: Consumer<ScissorsController>(
            builder: (context, controller, child) {
              return vm.csissorsPages[controller.indexOfRadioButon];
            },
          ),
        ),
      ],
    ).permition(context, UserPermition.show_scissors);
  }
}
