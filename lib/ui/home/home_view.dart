import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../app/extentions.dart';
import '../../app/functions.dart';
import '../../controllers/users_controllers.dart';
import '../Users_dashboard/users_dashbord.dart';
import '../addCategoreys/blockCategory.dart';
import '../chemical_stock/ChemicalStock_view.dart';
import '../commen/claculator.dart';
import '../customers/customersView.dart';
import '../cutting_order/cutting_order_view.dart';
import '../final_product_imported/improtedFinalProduct_view.dart';
import '../invoices/invoices_view.dart';
import '../main/componants/item_widget.dart';
import '../blocksStock/blocksStock_view.dart';
import '../final_product_outOrder/outOfStockOrder_veiw.dart';
import '../block_out_of_stock/outOfStock_view.dart';
import '../not_final/not_final_view.dart';
import '../purching/purching_view.dart';
import '../recources/color_manager.dart';
import '../recources/enums.dart';
import '../recources/icons_manager.dart';
import '../recources/strings_manager.dart';
import '../final_product_stock/Stock_of_finalProduct_View.dart';
import '../scissors/scissors_view.dart';
import '../stockCheck/stockcheck.dart';
import '../users_actions/users_actios.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    checkAuth(context);

    return Consumer<Users_controller>(
      builder: (context, myType, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.prussianBlue,
                    SringsManager.itemTitle12,
                    IconsManager.itemIcon1,
                    ontap: () {
                      context.gonext(context, BlocksStock());
                    },
                  ).permition(context, UserPermition.show_block_incetion),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    const Color(0xff1AB0B0),
                    SringsManager.itemTitle11,
                    IconsManager.itemIcon2,
                    ontap: () {
                      context.gonext(context, FinalProductStockView());
                    },
                  ).permition(context, UserPermition.show_finalProdcut_stock),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.russet,
                    SringsManager.itemTitle9,
                    IconsManager.itemIcon1,
                    ontap: () {
                      context.gonext(context, const OutOfStockView());
                    },
                  ).permition(context, UserPermition.show_blockconsume),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    const Color(0xffFF7544),
                    SringsManager.itemTitle2,
                    IconsManager.itemIcon1,
                    ontap: () {
                      context.gonext(context, const FinalProductView());
                    },
                  ).permition(context,
                      UserPermition.show_finalprodcut_importedFormcuttingUint),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.darkViolet,
                    SringsManager.itemTitle5,
                    IconsManager.itemIcon3,
                    ontap: () {
                      context.gonext(context, const NotFinal());
                    },
                  ).permition(context, UserPermition.show_not_final_stock),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.darkgreen,
                    SringsManager.itemTitle7,
                    IconsManager.itemIcon1,
                    ontap: () {
                      context.gonext(context, outOfStockOrder());
                    },
                  ).permition(
                      context, UserPermition.show_finalprodcut_invoicemaking),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    const Color(0xffFA5A7D),
                    SringsManager.itemTitle10,
                    IconsManager.itemIcon1,
                    ontap: () {
                      context.gonext(context, const CuttingOrderView());
                    },
                  ).permition(context, UserPermition.show_cutting_orders),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    const Color(0xff8676FE),
                    "اذون صرف منتج تام",
                    IconsManager.itemIcon1,
                    ontap: () {
                      context.gonext(context, InvicesView());
                    },
                  ).permition(context, UserPermition.show_finalprodcut_invoice),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.arsenic,
                    " المقصات",
                    Icons.cut,
                    ontap: () {
                      context.gonext(context, const ScissorsView());
                    },
                  ).permition(context, UserPermition.show_scissors),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    const Color.fromARGB(255, 47, 105, 42),
                    " المشتريات",
                    Icons.cut,
                    ontap: () {
                      context.gonext(context, PurchVeiw());
                    },
                  ).permition(context, UserPermition.Show_purches_module),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.cobalt,
                    SringsManager.itemTitle13,
                    IconsManager.itemIcon1,
                    ontap: () {
                      context.gonext(context, const MyStatefulWidget());
                    },
                  ),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    const Color.fromARGB(255, 157, 125, 45),
                    "الاوردرات الاونلاين",
                    IconsManager.itemIcon1,
                    ontap: () {},
                  ),
                ],
              ).permition(context, UserPermition.not_working),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.teal,
                    "العملاء",
                    IconsManager.itemIcon1,
                    ontap: () {
                      context.gonext(context, Customers_view());
                    },
                  ).permition(context, UserPermition.show_customers),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.cobalt,
                    "قوائم الجرد",
                    IconsManager.itemIcon1,
                    ontap: () {
                      context.gonext(context, Stockcheck());
                    },
                  ).permition(context, UserPermition.show_stcokCheck_moldule),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.blueGrey,
                    "المراسله والطلبات",
                    IconsManager.itemIcon1,
                    ontap: () {},
                  ).permition(context, UserPermition.not_working),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    const Color.fromARGB(255, 137, 180, 87),
                    " الكيماويات",
                    IconsManager.itemIcon1,
                    ontap: () {
                      context.gonext(context, Chemical_view());
                    },
                  ).permition(context, UserPermition.show_chemicals_model),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.prussianBlue,
                    " الاحصائيات",
                    IconsManager.itemIcon1,
                    ontap: () {},
                  ).permition(context, UserPermition.not_working),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.arsenic,
                    " الارشيف",
                    IconsManager.itemIcon1,
                    ontap: () {},
                  ).permition(context, UserPermition.not_working),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    const Color.fromARGB(255, 26, 99, 70),
                    " تسجيل الاصناف",
                    IconsManager.itemIcon1,
                    ontap: () {
                      context.gonext(context, BlockCategoryView());
                    },
                  ).permition(context, UserPermition.show_add_new_category),
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    const Color.fromARGB(255, 99, 26, 73),
                    "ادارة العهد",
                    IconsManager.itemIcon1,
                    ontap: () async {},
                  ).permition(context, UserPermition.show_Ohda_management),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Item0(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.arsenic,
                    " users actions",
                    IconsManager.itemIcon1,
                    ontap: () {
                      context.gonext(context, const UsersActions());
                    },
                  ).permition(context, UserPermition.show_users_actions),
                  FirebaseAuth.instance.currentUser!.email == "m.khaled@0.com"
                      ? Item0(
                          MediaQuery.of(context).size.width * .45,
                          ColorManager.arsenic,
                          " dashboard ",
                          IconsManager.itemIcon1,
                          ontap: () {
                            context.gonext(context, UsersDashboard());
                          },
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
