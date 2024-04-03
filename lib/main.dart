import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jason_company/controllers/CategorysController.dart';
import 'package:jason_company/controllers/ChemicalsController.dart';
import 'package:jason_company/controllers/Customer_controller.dart';
import 'package:jason_company/controllers/Order_controller.dart';
import 'package:jason_company/controllers/blockFirebaseController.dart';
import 'package:jason_company/controllers/dropDowen_controller.dart';
import 'package:jason_company/controllers/final_product_controller.dart';
import 'package:jason_company/controllers/invoice_controller.dart';
import 'package:jason_company/controllers/non_final_controller.dart';
import 'package:jason_company/controllers/purchesController.dart';
import 'package:jason_company/controllers/setting_controller.dart';
import 'package:jason_company/controllers/users_controllers.dart';
import 'package:jason_company/controllers/zupdate.dart';
import 'package:jason_company/setings/login.dart';
import 'package:provider/provider.dart';
import 'package:jason_company/controllers/ObjectBoxController.dart';
import 'package:jason_company/controllers/main_controller.dart';
import 'package:jason_company/controllers/scissors_controller.dart';
import 'package:jason_company/dataScorse/objectBox_helper.dart';
import 'package:jason_company/ui/main/main_view.dart';

DateFormat format = DateFormat('yyyy/MM/dd');
DateFormat formatwitTime = DateFormat('yyyy-MM-dd/hh:mm a');
DateFormat formatwitTime2 = DateFormat('yyyy-MM-dd -hh:mm a');
DateFormat formatwitTime3 = DateFormat('hh:mm a');
late Database database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAkWHl9E0KfHcvf5Ifx0WVvEXuvk2URhhs",
          appId: "1:106186917009:android:fcd892c86b7d3e3447ab30",
          messagingSenderId: "106186917009 ",
          projectId: "janson-11f24"));
  FirebaseDatabase.instance.ref();

  FirebaseDatabase.instance.setPersistenceEnabled(true);
  database = await Database.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MainController(),
          ),
          ChangeNotifierProvider(
            create: (context) => ScissorsController(),
          ),
          ChangeNotifierProvider(
            create: (context) => ObjectBoxController(),
          ),
          ChangeNotifierProvider(
            create: (context) => SettingController(),
          ),
          ChangeNotifierProvider(
            create: (context) => final_prodcut_controller(),
          ),
          ChangeNotifierProvider(
            create: (context) => UpdatesController(),
          ),
          ChangeNotifierProvider(
            create: (context) => BlockFirebasecontroller(),
          ),
          ChangeNotifierProvider(
            create: (context) => NonFinalController(),
          ),
          ChangeNotifierProvider(
            create: (context) => Invoice_controller(),
          ),
          ChangeNotifierProvider(
            create: (context) => Customer_controller(),
          ),
          ChangeNotifierProvider(
            create: (context) => OrderController(),
          ),
          ChangeNotifierProvider(
            create: (context) => dropDowenContoller(),
          ),
          ChangeNotifierProvider(
            create: (context) => Users_controller(),
          ),
          ChangeNotifierProvider(
            create: (context) => Category_controller(),
          ),
          ChangeNotifierProvider(
            create: (context) => Chemicals_controller(),
          ),
          ChangeNotifierProvider(
            create: (context) => PurchesController(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          theme: ThemeData(useMaterial3: false),
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: Builder(
            builder: (c) {
              c.read<Users_controller>().get_users_data();
              c.read<UpdatesController>().Updates_up();
              return a(c)
                  ? FirebaseAuth.instance.currentUser?.uid == null
                      ? const MyloginPage()
                      : Mainview()
                  : const CircularProgressIndicator();
            },
          ),
        ));
  }

  a(BuildContext c) {
    //    هذا المتغير اجعله ثابت على الجهاز او من الانترنت
    bool x = c.watch<UpdatesController>().updates == 0;
    //اطرح هنا التاريخ
    if (DateTime.now().compareTo(DateTime(2024, 6, 6)) >= 0) {
      x = false;
    }

    return x;
  }
}

class Commons {
  static const tileBackgroundColor = Color(0xFFF1F1F1);
  static const chuckyJokeBackgroundColor = Color(0xFFF1F1F1);
  static const chuckyJokeWaveBackgroundColor = Color(0xFFA8184B);
  static const gradientBackgroundColorEnd = Color(0xFF601A36);
  static const gradientBackgroundColorWhite = Color(0xFFFFFFFF);
  static const mainAppFontColor = Color(0xFF4D0F29);
  static const appBarBackGroundColor = Color(0xFF4D0F28);
  static const categoriesBackGroundColor = Color(0xFFA8184B);
  static const hintColor = Color(0xFF4D0F29);
  static const mainAppColor = Color(0xFF4D0F29);
  static const gradientBackgroundColorStart = Color(0xFF4D0F29);
  static const popupItemBackColor = Color(0xFFDADADB);
  static List<Color> dashColor = [
    const Color(0xff1AB0B0),
    const Color(0xffFF7544),
    const Color(0xffFA5A7D),
    const Color(0xff8676FE)
  ];
}
