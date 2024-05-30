import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:jason_company/ui/cutting_order/cutting_order_view.dart';
import 'package:serverpods_client/serverpods_client.dart';
import 'controllers/CategorysController.dart';
import 'controllers/ChemicalsController.dart';
import 'controllers/Customer_controller.dart';
import 'controllers/Order_controller.dart';
import 'controllers/bFractionsController.dart';
import 'controllers/bSubfractions.dart';
import 'controllers/blockFirebaseController.dart';
import 'controllers/dropDowen_controller.dart';
import 'controllers/final_product_controller.dart';
import 'controllers/invoice_controller.dart';
import 'controllers/non_final_controller.dart';
import 'controllers/purchesController.dart';
import 'controllers/setting_controller.dart';
import 'controllers/stockCheckController.dart';
import 'controllers/users_controllers.dart';
import 'controllers/zupdate.dart';
import 'setings/login.dart';
import 'package:provider/provider.dart';
import 'controllers/ObjectBoxController.dart';
import 'controllers/main_controller.dart';
import 'controllers/scissors_controller.dart';
import 'dataScorse/objectBox_helper.dart';
import 'ui/main/main_view.dart';

DateFormat format = DateFormat('yyyy/MM/dd');
DateFormat formatwitTime = DateFormat('yyyy-MM-dd/hh:mm a');
DateFormat formatwitTime2 = DateFormat('yyyy-MM-dd -hh:mm a');
DateFormat formatwitTime3 = DateFormat('hh:mm a');
late Database database;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true,
    sound: UriAndroidNotificationSound("default"),
    description: AutofillHints.gender);

Future<void> messagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

final localanotification = FlutterLocalNotificationsPlugin();
void handleMassage(RemoteMessage? massage) {
  if (massage == null) return;
  navigatorKey.currentState!
      .push(MaterialPageRoute(builder: (context) => const CuttingOrderView()));
}

initPushNotification() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.instance.subscribeToTopic("myTopic1");
  FirebaseMessaging.instance.getInitialMessage().then(handleMassage);
  FirebaseMessaging.onMessageOpenedApp.listen(handleMassage);
  FirebaseMessaging.onBackgroundMessage(messagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((event) {
    final notificatin = event.notification;
    if (notificatin == null) return;
    localanotification.show(
        notificatin.hashCode,
        notificatin.title,
        notificatin.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
          channel.id,
          channel.name,
        )));
  });
}
final client= Client('192.168.1.197:8080');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAkWHl9E0KfHcvf5Ifx0WVvEXuvk2URhhs",
          appId: "1:106186917009:android:fcd892c86b7d3e3447ab30",
          messagingSenderId: "106186917009",
          projectId: "janson-11f24"));
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  initPushNotification();

  FirebaseDatabase.instance.setPersistenceEnabled(true);

  database = await Database.create();
  runApp(const MyApp());
  client.openStreamingConnection();
client.user.stream.listen((data){
     data.toJson().toString();
});
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          ChangeNotifierProvider(
            create: (context) => Fractions_Controller(),
          ),
          ChangeNotifierProvider(
            create: (context) => SubFractions_Controller(),
          ),
          ChangeNotifierProvider(
            create: (context) => StokCheck_Controller(),
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
