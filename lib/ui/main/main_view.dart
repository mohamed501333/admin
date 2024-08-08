import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jason_company/controllers/biscol.dart';
import 'package:jason_company/controllers/industerialSecurityController.dart';
import 'package:jason_company/controllers/stockCheckController.dart';
import 'package:jason_company/ui/recources/publicVariables.dart';
import '../../app/functions.dart';
import '../../controllers/CategorysController.dart';
import '../../controllers/ChemicalsController.dart';
import '../../controllers/Customer_controller.dart';
import '../../controllers/Order_controller.dart';

import '../../controllers/blockFirebaseController.dart';
import '../../controllers/final_product_controller.dart';
import '../../controllers/invoice_controller.dart';

import '../../controllers/users_controllers.dart';
import 'componants/nav_bar.dart';
import '../../controllers/main_controller.dart';
import 'main_viewModel.dart';
import '../recources/color_manager.dart';
import 'package:jason_company/ui/recources/userpermitions.dart';
import 'package:provider/provider.dart';

class Mainview extends StatelessWidget {
  Mainview({
    super.key,
  });

  final MainViewModel vm = MainViewModel();

  @override
  Widget build(BuildContext context) {
    return Consumer<Users_controller>(
      builder: (context, myType, child) {
        print("refesh home  Users_controller");
        getModulesData(context);

        return Scaffold(
          backgroundColor: ColorManager.gallery,
          appBar: AppBar(
            title: Consumer<MainController>(
              builder: (context, myType, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("طريقة الاتصال : ${internet ? 'الانترنت' : 'السيرفر'}",
                        style: TextStyle(fontSize: 15, color: Colors.black)),
                    // Text(
                    //   vm.indexOfAppBar(
                    //       myType.currentIndex,
                    //       context
                    //           .watch<ScissorsController>()
                    //           .indexOfRadioButon),
                    //   style: const TextStyle(
                    //       fontSize: 22, fontWeight: FontWeight.bold),
                    // ),
                    Row(
                      children: [
                        const Text(
                          "server stutues :",
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                        const Gap(5),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color: myType.isServerOnline
                                ? const Color.fromARGB(255, 111, 255, 116)
                                : Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Gap(5),
                        Text(
                          myType.isServerOnline ? 'online' : "offline",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          body: Consumer<MainController>(
            builder: (context, controller, child) {
              return vm.screens[controller.currentIndex];
            },
          ),
          bottomNavigationBar: NavBar(),
        );
      },
    );
  }
}

void getModulesData(BuildContext context) {
  if (initialized == false) {
    initialized = true;
    context.read<Hivecontroller>().channelConection();
    if (permitionss(context, UserPermition.can_get_data_of_blocks)) {
      context.read<BlockFirebasecontroller>().getData();
      context.read<Category_controller>().getData();
    }
    if (permitionss(context, UserPermition.can_get_data_of_orders)) {
      context.read<OrderController>().getData();
    }
    if (permitionss(context, UserPermition.can_get_data_of_customers)) {
      context.read<Customer_controller>().getData();
    }
    if (permitionss(context, UserPermition.can_get_data_of_chemicals)) {
      context.read<Chemicals_controller>()
        ..getData()
        ..getData2();
    }
    if (permitionss(context, UserPermition.can_get_data_of_final_prodcut)) {
      context.read<final_prodcut_controller>().getData();
    }
    if (permitionss(context, UserPermition.can_get_data_of_invoice)) {
      context.read<Invoice_controller>().getData();
    }
    if (permitionss(context, UserPermition.can_get_data_of_stcokCheck)) {
      context.read<StokCheck_Controller>().get_StokCheck_data();
    }
    if (permitionss(context, UserPermition.Industrial_Security)) {
      context.read<IndusterialSecuritycontroller>().getdata();
    }
    if (Platform.isAndroid) {
      if (permitionss(
          context, UserPermition.show_cutting_order_notifications)) {
        FirebaseMessaging.instance.subscribeToTopic("myTopic1");
      } else {
        FirebaseMessaging.instance.unsubscribeFromTopic("myTopic1");
      }
    }
  }
}



//         permitionss(context, UserPermition.can_get_data_of_fractions)
//             ? context.read<Fractions_Controller>().get_Fractions_data()
//             : DoNothingAction();

//         permitionss(context, UserPermition.can_get_data_of_subfractions)
//             ? context.read<SubFractions_Controller>().get_SubFractions_data()
//             : DoNothingAction();

//         permitionss(context, UserPermition.can_get_data_of_notfinals)
//             ? context.read<NonFinalController>().getdataOfnotFinals()
//             : DoNothingAction();

//         permitionss(context, UserPermition.can_get_data_of_purches)
//             ? context.read<PurchesController>().getDataOfPurchesrr()
//             : DoNothingAction();


