import 'package:flutter/material.dart';
import 'package:jason_company/controllers/Customer_controller.dart';
import 'package:jason_company/controllers/Order_controller.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/controllers/fractinsFirebaseController.dart';
import 'package:jason_company/controllers/invoice_controller.dart';
import 'package:jason_company/controllers/non_final_controller.dart';
import 'package:jason_company/controllers/scissors_controller.dart';
import 'package:jason_company/controllers/users_controllers.dart';
import 'package:jason_company/ui/main/componants/nav_bar.dart';
import 'package:jason_company/controllers/main_controller.dart';
import 'package:jason_company/ui/main/main_viewModel.dart';
import 'package:jason_company/ui/recources/color_manager.dart';
import 'package:provider/provider.dart';

class Mainview extends StatelessWidget {
  Mainview({
    super.key,
  });

  final MainViewModel vm = MainViewModel();

  @override
  Widget build(BuildContext context) {
    context.read<final_prodcut_controller>().get_finalProdcut_data(context);
    context.read<final_prodcut_controller>().c();
    context.read<BlockFirebasecontroller>().get_blocks_data();
    context.read<BlockFirebasecontroller>().c();
    context.read<FractionFirebaseController>().get_Fractions_data();
    context.read<NonFinalController>().getdataOfnotFinals();
    context.read<Invoice_controller>().get_invice_data();
    context.read<Customer_controller>().get_Customers_data();
    context.read<OrderController>().get_Order_data();
    context.read<Users_controller>().get_users_data();
    // User currentUser = FirebaseAuth.instance.currentUser!;
    // context.read<Users_controller>().Add_User_permition(
    //     Users(
    //         id: DateTime.now().millisecondsSinceEpoch,
    //         uidemail: currentUser.email ?? "",
    //         uid: currentUser.uid,
    //         name: "",
    //         permitions: []),
    //     UserPermition.show_block_incetion);
    return Consumer<Users_controller>(
      builder: (context, myType, child) {
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
