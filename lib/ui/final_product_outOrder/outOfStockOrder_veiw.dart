// ignore_for_file: must_be_immutable, file_names, camel_case_types

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/ui/commen/errmsg.dart';
import 'package:jason_company/ui/final_product_outOrder/wid.dart';
import 'package:provider/provider.dart';

class outOfStockOrder extends StatelessWidget {
  const outOfStockOrder({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, finalproducts, child) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 50,
            title: const RadiobuttomForFInalProdcutOUtOrder(),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [   errmsg() ,
                if (finalproducts.indexOfRadioButon == 0) OUT(),
                // if (finalproducts.indexOfRadioButon == 0) column
              ],
            ),
          ),
        );
      },
    );
  }
}

class RadiobuttomForFInalProdcutOUtOrder extends StatelessWidget {
  const RadiobuttomForFInalProdcutOUtOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, myType, child) {
        return CustomRadioButton(
          width: 166,
          defaultSelected: myType.indexOfRadioButon,
          elevation: 0,
          absoluteZeroSpacing: true,
          unSelectedColor: Theme.of(context).canvasColor,
          buttonLables: const [
            'صرف',
            'صرف من اوامر الشغل',
          ],
          buttonValues: const [
            0,
            1,
          ],
          radioButtonValue: (value) {
            myType.indexOfRadioButon = value;
            myType.Refresh_Ui();
          },
          // ignore: prefer_const_constructors
          selectedColor: Color.fromARGB(255, 86, 179, 15),
          buttonTextStyle: const ButtonTextStyle(
              selectedColor: Colors.white,
              unSelectedColor: Colors.black,
              textStyle: TextStyle(fontSize: 16)),
        );
      },
    );
  }
}
