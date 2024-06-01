// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, file_names, non_constant_identifier_names
// ignore_for_file: library_private_types_in_public_api, unused_local_variable
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:jason_company/controllers/setting_controller.dart';
import 'package:jason_company/app/extentions.dart';
import 'package:jason_company/setings/SignUp.dart';

import 'package:jason_company/setings/login.dart';
import 'package:jason_company/ui/blocksStock/outofStock_viewmoder.dart';
import 'package:jason_company/ui/commen/textformfield.dart';
import 'package:jason_company/ui/reports/reportsforH/h_reports_viewModel.dart';
import 'package:provider/provider.dart';

class Setings extends StatelessWidget {
  Setings({super.key});
  HReportsViewModel vm1 = HReportsViewModel();
  HReportsViewModel vm2 = HReportsViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        ElevatedButton(
            onPressed: () {
              context.gonext(context, const MyloginPage());
            },
            child: const Text("تسجيل الدخول")),
        FirebaseAuth.instance.currentUser!.email == "m.khaled@0.com"
            ? ElevatedButton(
                onPressed: () {
                  context.gonext(context, SignupPage());
                },
                child: const Text("تسجيل مستخدم جديد"))
            : const SizedBox(),
      
      ],
    ));
  }
}

class CustonSwitch extends StatelessWidget {
  const CustonSwitch({
    super.key,
    this.fontsize = 16,
  });
  final double fontsize;
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingController>(
      builder: (context, myType, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "صرف البلوك اتوماتيك عند الاضافه للمخزن",
              style: TextStyle(fontSize: fontsize, fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}

class CustonSwitch2 extends StatelessWidget {
  CustonSwitch2({
    super.key,
    this.fontsize = 13,
  });
  final double fontsize;
  BlocksStockViewModel vm = BlocksStockViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingController>(
      builder: (context, myType, child) {
        return SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Text(
                    "الاضافه الاوتماتيكيه عند الضغط ",
                    style: TextStyle(
                        fontSize: fontsize, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "على الاختصار فى رصيد البلوك",
                    style: TextStyle(
                        fontSize: fontsize, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

showmyAlertDialog1(
    BuildContext context, SettingController myType, BlocksStockViewModel vm) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('  ?'),
          content: SizedBox(
            height: 200,
            child: Column(children: [
              const Text("ادخل رقم البدايه"),
              CustomTextFormField(hint: "", width: 100, controller: vm.N)
            ]),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('الغاء')),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'تم',
                )),
          ],
        );
      });
}
