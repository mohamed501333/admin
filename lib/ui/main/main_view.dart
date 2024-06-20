import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/ui/recources/publicVariables.dart';
import '../../app/functions.dart';
import '../../controllers/CategorysController.dart';
import '../../controllers/ChemicalsController.dart';
import '../../controllers/Customer_controller.dart';
import '../../controllers/Order_controller.dart';
import '../../controllers/bFractionsController.dart';
import '../../controllers/bSubfractions.dart';
import '../../controllers/blockFirebaseController.dart';
import '../../controllers/final_product_controller.dart';
import '../../controllers/invoice_controller.dart';
import '../../controllers/non_final_controller.dart';
import '../../controllers/purchesController.dart';
import '../../controllers/scissors_controller.dart';
import '../../controllers/stockCheckController.dart';
import '../../controllers/users_controllers.dart';
import 'componants/nav_bar.dart';
import '../../controllers/main_controller.dart';
import 'main_viewModel.dart';
import '../recources/color_manager.dart';
import 'package:jason_company/ui/recources/userpermitions.dart';
import 'package:provider/provider.dart';
import 'dart:io';

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
        if (initialized == false) {
          initialized = true;
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
            context.read<Chemicals_controller>()..getData()..getData2();
          }
          if (permitionss(context, UserPermition.can_get_data_of_final_prodcut)) {
           context.read<final_prodcut_controller>().getData();
          }
          if ( permitionss(context, UserPermition.can_get_data_of_invoice)) {
           context.read<Invoice_controller>().getData();
          }
  
        }

//         permitionss(context, UserPermition.can_get_data_of_stcokCheck)
//             ? context.read<StokCheck_Controller>().get_StokCheck_data()
//             : DoNothingAction();

//         context.read<final_prodcut_controller>().c();
//         
// context.read<BlockFirebasecontroller>().c();
//         permitionss(context, UserPermition.can_get_data_of_fractions)
//             ? context.read<Fractions_Controller>().get_Fractions_data()
//             : DoNothingAction();

//         permitionss(context, UserPermition.can_get_data_of_subfractions)
//             ? context.read<SubFractions_Controller>().get_SubFractions_data()
//             : DoNothingAction();

//         context.read<BlockFirebasecontroller>().c();

//         permitionss(context, UserPermition.can_get_data_of_notfinals)
//             ? context.read<NonFinalController>().getdataOfnotFinals()
//             : DoNothingAction();


//         permitionss(context, UserPermition.can_get_data_of_purches)
//             ? context.read<PurchesController>().getDataOfPurchesrr()
//             : DoNothingAction();


//         permitionss(context, UserPermition.can_get_data_of_notfinals)
//             ? context.read<NonFinalController>().getdataOfnotFinals()

//         permitionss(context, UserPermition.show_cutting_order_notifications)
//             ? FirebaseMessaging.instance.subscribeToTopic("myTopic1")
//             : FirebaseMessaging.instance.unsubscribeFromTopic("myTopic1");

        return Scaffold(
          backgroundColor: ColorManager.gallery,
          appBar: AppBar(
            title: Consumer<MainController>(
              builder: (context, myType, child) {
                return Center(
                    child: Text(
                  vm.indexOfAppBar(myType.currentIndex,
                      context.watch<ScissorsController>().indexOfRadioButon),
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ));
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
