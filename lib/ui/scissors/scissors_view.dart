import 'package:flutter/material.dart';
import 'package:jason_company/ui/recources/userpermitions.dart';
import '../../app/extentions.dart';
import '../../controllers/scissors_controller.dart';
import '../sA/automaticScissor.dart';
import '../sH/h1_veiw.dart';
import '../sR/Rscissor_view.dart';
import 'component/radiobuttom.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ScissorsView extends StatelessWidget {
  const ScissorsView({super.key});
  @override
  Widget build(BuildContext context) {
    List csissorsPages = [
      const H1Veiw(
        scissor: 1,
      ).permition(context, UserPermition.show_H1),
      const H1Veiw(
        scissor: 2,
      ).permition(context, UserPermition.show_H2),
      const H1Veiw(
        scissor: 3,
      ).permition(context, UserPermition.show_H3),
      RVeiw2(Rscissor: 1).permition(context, UserPermition.show_R1),
      RVeiw2(Rscissor: 2).permition(context, UserPermition.show_R2),
      RVeiw2(Rscissor: 3).permition(context, UserPermition.show_R3),
      RVeiw23(
        Ascissor: 1,
      ).permition(context, UserPermition.show_R3),
    ];

    return Consumer<ScissorsController>(
      builder: (context, myType, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              const Radiobuttom(),
              Expanded(
                child: csissorsPages[myType.indexOfRadioButon],
              ),
            ],
          ),
        );
      },
    );
  }
}
