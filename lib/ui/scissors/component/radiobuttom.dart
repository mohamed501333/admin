import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/controllers/scissors_controller.dart';
import 'package:provider/provider.dart';

class Radiobuttom extends StatelessWidget {
  const Radiobuttom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRadioButton(
      width: 63,
      defaultSelected: Provider.of<ScissorsController>(context, listen: false)
          .indexOfRadioButon,
      elevation: 0,
      absoluteZeroSpacing: true,
      unSelectedColor: Theme.of(context).canvasColor,
      buttonLables: const ['H1', 'H2', 'H3', 'R1', 'R2', 'R3'],
      // ignore: prefer_const_literals_to_create_immutables
      buttonValues: [0, 1, 2, 3, 4, 5],
      radioButtonValue: (value) =>
          Provider.of<ScissorsController>(context, listen: false)
              .changeIndexOfRadioButoon(value),
      selectedColor: Colors.blueAccent,
      buttonTextStyle: const ButtonTextStyle(
          selectedColor: Colors.white,
          unSelectedColor: Colors.black,
          textStyle: TextStyle(fontSize: 16)),
    );
  }
}
