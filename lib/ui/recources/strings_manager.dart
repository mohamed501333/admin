import 'package:firebase_auth/firebase_auth.dart';

class SringsManager {
  static const String itemTitle1 = " منصرف من مخزن البلوك";
  static const String itemTitle2 = "انتاج الدائرى";
  static const String itemTitle3 = "التقارير";
  static const String itemTitle4 = "المخازن";
  static const String itemTitle5 = "مخزن دون التام";
  static const String itemTitle6 = "المخازن";
  static const String itemTitle7 = "   صرف منتج تام";
  static const String itemTitle9 = "صرف بلوكات";
  static const String itemTitle10 = "اوامر التشغيل";
  static const String itemTitle11 = "رصيد منتج تام";
  static const String itemTitle12 = "اضافه الى البلوكات";
  static const String itemTitle13 = " الاله الحسابه";
  static String myemail =
      FirebaseAuth.instance.currentUser!.email ?? "unknowen";
}
