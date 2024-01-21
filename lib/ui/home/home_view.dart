import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/app/functions.dart';
import 'package:jason_company/controllers/users_controllers.dart';
import 'package:jason_company/ui/Users_dashboard/users_dashbord.dart';
import 'package:jason_company/ui/commen/claculator.dart';
import 'package:jason_company/ui/customers/customersView.dart';
import 'package:jason_company/ui/cutting_order/cutting_order_view.dart';
import 'package:jason_company/ui/final_product_imported/improtedFinalProduct_view.dart';
import 'package:jason_company/ui/invoices/invoices_view.dart';
import 'package:jason_company/ui/main/componants/item_widget.dart';
import 'package:jason_company/ui/blocksStock/blocksStock_view.dart';
import 'package:jason_company/ui/final_product_outOrder/outOfStockOrder_veiw.dart';
import 'package:jason_company/ui/block_out_of_stock/outOfStock_view.dart';
import 'package:jason_company/ui/not_final/not_final_view.dart';
import 'package:jason_company/ui/recources/color_manager.dart';
import 'package:jason_company/ui/recources/enums.dart';
import 'package:jason_company/ui/recources/icons_manager.dart';
import 'package:jason_company/ui/recources/strings_manager.dart';
import 'package:jason_company/ui/final_product_stock/Stock_of_finalProduct_View.dart';
import 'package:jason_company/ui/users_actions/users_actios.dart';
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
                  Item(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.prussianBlue,
                    SringsManager.itemTitle12,
                    IconsManager.itemIcon1,
                    ontap: () {
                      context.gonext(context, BlocksStock());
                    },
                  ).permition(context, UserPermition.show_block_incetion),
                  Item(
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
                  Item(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.russet,
                    SringsManager.itemTitle9,
                    IconsManager.itemIcon1,
                    ontap: () {
                      context.gonext(context, const OutOfStockView());
                    },
                  ).permition(context, UserPermition.show_blockconsume),
                  Item(
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
                  Item(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.darkViolet,
                    SringsManager.itemTitle5,
                    IconsManager.itemIcon3,
                    ontap: () {
                      context.gonext(context, const NotFinal());
                    },
                  ).permition(context, UserPermition.show_not_final_stock),
                  Item(
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
                  Item(
                    MediaQuery.of(context).size.width * .45,
                    const Color(0xffFA5A7D),
                    SringsManager.itemTitle10,
                    IconsManager.itemIcon1,
                    ontap: () {
                      context.gonext(context, const CuttingOrderView());
                    },
                  ).permition(context, UserPermition.show_cutting_orders),
                  Item(
                    MediaQuery.of(context).size.width * .45,
                    const Color(0xff8676FE),
                    "اذون صرف منتج تام",
                    IconsManager.itemIcon1,
                    ontap: () {
                      context.gonext(context, const InvicesView());
                    },
                  ).permition(context, UserPermition.show_finalprodcut_invoice),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Item(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.cobalt,
                    SringsManager.itemTitle13,
                    IconsManager.itemIcon1,
                    ontap: () {
                      context.gonext(context, const MyStatefulWidget());
                    },
                  ),
                  Item(
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
                  Item(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.teal,
                    "العملاء",
                    IconsManager.itemIcon1,
                    ontap: () {
                      context.gonext(context, Customers_view());
                    },
                  ).permition(context, UserPermition.show_customers),
                  Item(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.cobalt,
                    "قوائم الجرد",
                    IconsManager.itemIcon1,
                    ontap: () {},
                  ).permition(context, UserPermition.not_working),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Item(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.blueGrey,
                    "المراسله والطلبات",
                    IconsManager.itemIcon1,
                    ontap: () {},
                  ).permition(context, UserPermition.not_working),
                  Item(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.arsenic,
                    " الكيماويات",
                    IconsManager.itemIcon1,
                    ontap: () {},
                  ).permition(context, UserPermition.not_working),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Item(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.prussianBlue,
                    " الاحصائيات",
                    IconsManager.itemIcon1,
                    ontap: () {},
                  ).permition(context, UserPermition.not_working),
                  Item(
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
                  Item(
                    MediaQuery.of(context).size.width * .45,
                    ColorManager.arsenic,
                    " users actions",
                    IconsManager.itemIcon1,
                    ontap: () {
                      context.gonext(context, const UsersActions());
                    },
                  ).permition(context, UserPermition.show_users_actions),
                  FirebaseAuth.instance.currentUser!.email == "m.khaled@0.com"
                      ? Item(
                          MediaQuery.of(context).size.width * .45,
                          ColorManager.arsenic,
                          " dashboard ",
                          IconsManager.itemIcon1,
                          ontap: () {
                            context.gonext(context, const UsersDashboard());
                          },
                        )
                      : SizedBox(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
